<?php

namespace frontend\models;

use common\models\TagModel;
use yii\base\Model;

/**
*标签的表单模型
*/

class TagForm extends Model
{
	public $id;
	public $tags;

	public function rules()
	{
		return [
			['tag', 'required'],
			['tag', 'each', 'rule' => ['string']],
		];
	}

	/*
	*保存标签集合
	*/
	public function saveTags()
	{
		$ids = [];
		if(!empty($this->tags)) {
			foreach ($this->tags as $k => $tag) {
				$ids[] = $this->_saveTag($tag);
			}
		} 

		return $ids;
	}

	/*
	*保存标签
	*/
	public function _saveTag($tag)
	{
		$model = new TagModel();
		$res = $model->find()->where(['tag_name' => $tag])->one();
		if (!$res) {
			$model->tag_name = $tag;
			$model->post_num = 1;
			if(!$model->save()) {
				throw new \Exception("保存标签失败！");
			}
			return $model->id;
		} else {
			$res->updateCounters(['post_num' => 1]);
		}

		return $res->id;
	}
}