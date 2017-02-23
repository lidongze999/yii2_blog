<?php
namespace frontend\controllers;

use frontend\controllers\base\BaseController;
use frontend\models\PostForm;

/**
*文章控制器
*/
class PostController extends BaseController
{
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
		return $this->render('create', [
		    'model' => $model,
		]);
	}
}