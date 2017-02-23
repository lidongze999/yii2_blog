<?php
namespace frontend\controllers;

use frontend\controllers\base\BaseController;

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
}