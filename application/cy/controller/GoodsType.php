<?php


namespace app\cy\controller;


class GoodsType extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $list = db('cy_goods_type')->select();
            return $this->showAll($list);
        } else {
            return view();
        }
    }

    public function typeForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            if ($data['type_id'] == null) {
                db('cy_goods_type')->insert($data);
                return $this->success('添加成功！');
            } else {
                db('cy_goods_type')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            return view('type_form');
        }
    }

    public function typeDel()
    {
        $id = input('post.type_id');
        $sub = db('cy_goods')->where("type_id", $id)->find();
        if ($sub) {
            return $this->error('该类别有新闻，删除失败!');
        } else {
            db('cy_goods_type')->delete($id);
            return $this->success('删除成功!');
        }

    }
}
