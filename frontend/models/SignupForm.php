<?php
namespace frontend\models;

use common\models\UserModel;
use yii;
use yii\base\Model;

/**
 * Signup form
 */
class SignupForm extends Model
{
    public $username;
    public $email;
    public $password;

    public $rePassword;
    public $verifyCode;

    /**
     * @inheritdoc
     */
    public function rules()
    {
        return [
            ['username', 'trim'],
            ['username', 'required'],
            ['username', 'unique', 'targetClass' => '\common\models\UserModel', 'message' => 'This username has already been taken.'],
            ['username', 'string', 'min' => 2, 'max' => 255],
            ['username', 'match', 'pattern' => '/^[(\x{4E00}-\x{9FA5})a-zA-Z]+[(\x{4E00}-\x{9FA5})a-zA-Z_\d]*$/u', 'message' => '用户名由字母、汉字、数字、下划线组成，且不能以数字或下划线开头'],
            ['email', 'trim'],
            ['email', 'required'],
            ['email', 'email'],
            ['email', 'string', 'max' => 255],
            ['email', 'unique', 'targetClass' => '\common\models\UserModel'],

            [['password', 'rePassword'], 'required'],
            [['password', 'rePassword'], 'string', 'min' => 6],
            ['rePassword', 'compare', 'compareAttribute' => 'password', 'message' => Yii::t('common', 'Two times the password is not consistent.')],

            ['verifyCode', 'captcha'],
        ];
    }

    public function attributeLabels()
    {
        return [
            'username'   => '用户名',
            'email'      => Yii::t('common', 'Email'),
            'password'   => Yii::t('common', 'Password'),
            'rePassword' => '重复密码',
            'verifyCode' => '验证码',
        ];
    }

    /**
     * Signs user up.
     *
     * @return User|null the saved model or null if saving fails
     */
    public function signup()
    {
        if (!$this->validate()) {
            return null;
        }

        $user           = new UserModel();
        $user->username = $this->username;
        $user->email    = $this->email;
        $user->setPassword($this->password);
        $user->generateAuthKey();

        return $user->save() ? $user : null;
    }
}