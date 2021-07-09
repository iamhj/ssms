<?php


namespace app\sw\controller;


class Semester extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $list = db('sw_semester')->select();
            return $this->showAll($list);
        } else {
            return view();
        }
    }

    public function semesterForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            if ($data['semester_id'] == null) {
                db('sw_semester')->insert($data);
                return $this->success('添加成功！');
            } else {
                db('sw_semester')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            return view('semester_form');
        }
    }

    public function semesterDel()
    {
        $id = input('post.semester_id');
        $sub = db('sw_course')->where("semester_id", $id)->find();
        if ($sub) {
            return $this->error('该类别有新闻，删除失败!');
        } else {
            db('sw_semester')->delete($id);
            return $this->success('删除成功!');
        }

    }
}
