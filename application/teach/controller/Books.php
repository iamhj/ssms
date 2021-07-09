<?php


namespace app\teach\controller;


use app\admin\controller\Base;


class Books extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $list = db('book b')
                ->join('book_type t','b.type_id=t.type_id','left')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            return view();
        }
    }

    public function bookForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            if ($data['book_id'] == null) {
                db('book')->insert($data);
                return $this->success('图书添加成功！');
            } else {
                db('book')->update($data);
                return $this->success('图书编辑成功！');
            }
        } else {
            $list = db('book_type')->select();
            $this->assign('list', $list);
            return view('book_form');
        }
    }

    public function bookDel()
    {
        $id=input('post.book_id');
        db('book')->delete($id);
        return $this->success('删除成功！');
    }

    public function type()
    {
        return view();
    }
    public function typeData()
    {
        $list = db('book_type')->select();
        return $this->showAll($list);
    }
}