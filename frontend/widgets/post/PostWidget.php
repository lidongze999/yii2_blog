<?php
namespace frontend\widgets\post;

use common\models\PostModel;
use frontend\models\PostForm;
use yii\base\Widget;
use yii\data\Pagination;
use Yii;
use yii\helpers\Url;

/**
 * 文章列表组件
 * @package frontend\widgets\post
 */
class PostWidget extends Widget
{
    /**
     * 文章列表标题
     */
    public $title = '';

    /**
     * 是否显示更多
     * @var int
     */
    public $limit = 6;

    /**
     * 是否显示更多
     */
    public $more = true;

    /**
     * 是否显示分页
     */
    public $page = true;

    public function run()
    {
        $curPage = Yii::$app->request->get('page', 1);
        //查询条件
        $cond = ['=', 'is_valid', PostModel::IS_VALID];
        $res = PostForm::getList($cond, $curPage, $this->limit);

        $result['title'] = $this->title?:'最新文章';
        $result['more'] = Url::to(['post/index']);
        $result['body'] = $res['data']?:[];
        //是否显示分页
        if ($this->page) {
            $pages = new Pagination(['totalCount' => $res['count'], 'pageSize' => $res['pageSize']]);
            $result['page'] = $pages;
        }

        return $this->render('index', ['data' => $result]);
    }
}