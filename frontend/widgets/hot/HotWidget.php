<?php
namespace frontend\widgets\hot;

use common\models\PostExtendModel;
use common\models\PostModel;
use Yii;
use yii\base\Widget;
use yii\db\Query;

/**
 * 热门浏览组件
 * @package frontend\widgets\hot
 */
class HotWidget extends Widget
{
    /**
     * 文章列表的标题
     * @var unknown
     */
    public $title = '';

    /**
     * 显示条数
     * @var unknown
     */
    public $limit = 8;

    /**
     * 是否显示更多
     * @var unknown
     */
    public $more = true;

    /**
     * 是否显示分页
     * @var unknown
     */
    public $page = true;

    public function run()
    {
        $res = (new Query())
            ->select('a.browser, b.id, b.title')
            ->from(['a' => PostExtendModel::tableName()])
            ->join('LEFT JOIN', ['b' => PostModel::tableName()], 'a.post_id = b.id')
            ->where('b.is_valid ='.PostModel::IS_VALID)
            ->orderBy(['browser' => SORT_DESC, 'id' => SORT_DESC])
            ->limit($this->limit)
            ->all();
        $result['title'] = $this->title?:'热门浏览';
        $result['body'] = $res?:[];

        return $this->render('index', ['data' => $result]);
    }
}