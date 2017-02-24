<?php
use frontend\widgets\banner\BannerWidget;
use frontend\widgets\post\PostWidget;

$this->title = '博客-首页';
?>
<div class="row">
    <div class="col-lg-9">
        <!--图片轮播-->
        <?= BannerWidget::widget() ?>
    </div>
    <div class="col-lg-3">
        222
    </div>
    <div class="row">
        <div class="col-lg-9">
            <!--文章列表-->
            <?= PostWidget::widget() ?>
        </div>
    </div>
</div>