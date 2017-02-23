<?php

namespace frontend\models;

use common\models\PostModel;
use Yii;
use yii\base\Model;
use yii\db\Query;
use common\models\RelationPostTagModel;
use yii\web\NotFoundHttpException;

/**
 *文章表单模型
 */
class PostForm extends Model
{
    public $id;
    public $title;
    public $content;
    public $label_img;
    public $cat_id;
    public $tags;

    public $_lastError = "";

    /**
     *定义场景：创建和更新
     */
    const SCENARIOS_CREATE = 'create';
    const SCENARIOS_UPDATE = 'update';

    //定义事件
    const EVENT_AFTER_CREATE = 'eventAfterCreate';
    const EVENT_AFTER_UPDATE = 'eventAfterUpdate';

    /**
     *场景设置
     */
    public function scenarios()
    {
        $scenarios = [
            self::SCENARIOS_CREATE => ['title', 'content', 'label_img', 'cat_id', 'tags'],
            self::SCENARIOS_UPDATE => ['title', 'content', 'label_img', 'cat_id', 'tags'],
        ];

        return array_merge(parent::scenarios(), $scenarios);
    }

    public function rules()
    {
        return [
            [['id', 'title', 'content', 'cat_id'], 'required'],
            [['id', 'cat_id'], 'integer'],
            ['title', 'string', 'min' => 3, 'max' => 50],
        ];
    }

    /**
     *创建文章
     */
    public function attributeLabels()
    {
        return [
            'id'        => '编码',
            'title'     => '标题',
            'content'   => '内容',
            'label_img' => '标签图',
            'tags'      => '标签',
            'cat_id'    => '分类',
        ];
    }

    public function create()
    {
        //事务
        $transaction = Yii::$app->db->beginTransaction();
        try {
            $model = new PostModel();
            $model->setAttributes($this->attributes);
            $model->summary    = $this->_getSummary();
            $model->user_id    = Yii::$app->user->identity->id;
            $model->user_name  = Yii::$app->user->identity->username;
            $model->is_valid   = PostModel::IS_VALID;
            $model->created_at = time();
            $model->updated_at = time();
            if (!$model->save()) {
                throw new \Exception("文章保存失败");
            }

            $this->id = $model->id;

            //调用事件
            $data = array_merge($this->getAttributes(), $model->getAttributes());
            $this->_eventAfterCreate($data);

            $transaction->commit();
            return true;
        } catch (\Excetion $e) {
            $transaction->rollBack();
            $this->_lastError = $e->getMessage();
            return false;
        }
    }

    /*
     * 截取文章摘要
     */
    public function getViewById($id)
    {
        $res = PostModel::find()->with('relate.tag', 'extend')->where(['id' => $id])->asArray()->one();
        if (!$res) {
            throw new NotFoundHttpException('文章不存在');
        }
        //处理标签格式
        if (isset($res['relate']) && !empty($res['relate'])) {
            foreach ($res['relate'] as $list) {
                $res['tags'][] = $list['tag']['tag_name'];
            }
        }
        unset($res['relate']);
        return $res;
    }

    /**
     *获取文章摘要
     */
    private function _getSummary($s = 0, $e = 90, $char = 'utf-8')
    {
        if (empty($this->content)) {
            return null;
        }

        return (mb_substr(str_replace('&nbsp;', '', strip_tags($this->content)), $s, $e, $char));
    }

    /*
     *文章创建完成后的事件
     */
    public function _eventAfterCreate($data)
    {
        //添加事件
        $this->on(self::EVENT_AFTER_CREATE, [$this, '_eventAddTag'], $data);
        //触发事件
        $this->trigger(self::EVENT_AFTER_CREATE);
    }

    /**
     *添加标签
     */
    public function _eventAddTag($event)
    {
        //保存标签
        $tag       = new TagForm();
        $tag->tags = $event->data['tags'];
        $tagids    = $tag->saveTags();

        //删除原先的关联关系
        RelationPostTagModel::deleteAll(['post_id' => $event->data['id']]);

        //批量保存
        if (!empty($tagids)) {
            foreach ($tagids as $k => $id) {
                $row[$k]['post_id'] = $this->id;
                $row[$k]['tag_id']  = $id;
            }
            //批量插入
            $res = (new Query())->createCommand()
                ->batchInsert(RelationPostTagModel::tableName(), ['post_id', 'tag_id'], $row)
                ->execute();
            //返回结果
            if (!$res) {
                throw new \Exception("关联关系保存失败");
            }

        }

    }
}
