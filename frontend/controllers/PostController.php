<?php
namespace frontend\controllers;

use common\models\CatModel;
use common\models\PostExtendModel;
use frontend\controllers\base\BaseController;
use frontend\models\PostForm;
use Yii;
use yii\filters\AccessControl;
use yii\filters\VerbFilter;

/**
 *文章控制器
 */
class PostController extends BaseController
{
    public function behaviors()
    {
        return [
            'access' => [
                'class' => AccessControl::className(),
                'only'  => ['index', 'create', 'upload', 'ueditor'],
                'rules' => [
                    [
                        'actions' => ['index'],
                        'allow'   => true,
                    ],
                    [
                        'actions' => ['create', 'upload', 'ueditor'],
                        'allow'   => true,
                        'roles'   => ['@'],
                    ],
                ],
            ],
            'verbs'  => [
                'class'   => VerbFilter::className(),
                'actions' => [
                    '*' => ['get','post'],
                ],
            ],
        ];
    }

    public function actions()
    {
        return [
            'upload'  => [
                'class'  => 'common\widgets\file_upload\UploadAction', //这里扩展地址别写错
                'config' => [
                    'imagePathFormat' => "/image/{yyyy}{mm}{dd}/{time}{rand:6}",
                ],
            ],
            'ueditor' => [
                'class'  => 'common\widgets\ueditor\UeditorAction',
                'config' => [
                    //上传图片配置
                    'imageUrlPrefix' => "", /* 图片访问路径前缀 */
                    'imagePathFormat' => "/image/{yyyy}{mm}{dd}/{time}{rand:6}", /* 上传保存路径,可以自定义保存路径和文件名格式 */
                ],
            ],
        ];
    }

    /**
     *文章列表
     */
    public function actionIndex()
    {
        return $this->render('index');
    }

    /**
     *创建文章
     */
    public function actionCreate()
    {
        $model = new PostForm();
        //定义场景
        $model->setScenario(PostForm::SCENARIOS_CREATE);

        if ($model->load(Yii::$app->request->post()) && $model->validate()) {
            if (!$model->create()) {
                Yii::$app->session->setFlash('waring', $model->_lastError);
            } else {
                return $this->redirect(['post/detail', 'id' => $model->id]);
            }
            
        }
        //var_dump($model->getErrors());die;
        //获取所有分类
        $cat = CatModel::getAllCats();
        return $this->render('create', [
            'model' => $model,
            'cat'   => $cat,
        ]);
    }

    /**
     * 文章详情
     */
    public function actionDetail($id)
    {
        $model = new PostForm();
        $data = $model->getViewById($id);

        //文章统计
        $model = new PostExtendModel();
        $model->upCounter(['post_id' => $id], 'browser', 1);
        return $this->render('view', ['data' => $data]);
    }
}
