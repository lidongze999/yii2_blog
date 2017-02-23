<?php

namespace frontend\models;

use yii\base\Model;

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
			['title', 'string', 'min' => 4, 'max' => 50],
		];
	}

	public function attributeLabels()
	{
		return [
			'id' => '编码',
			'title' => '标题',
			'content' => '内容',
			'label_img' => '标签图',
			'tags' => '标签',
			'cat_id' => '分类',
		];
	}
}