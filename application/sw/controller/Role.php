<?php


namespace app\sw\controller;


class Role extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $list = db('sw_role')->select();
            return $this->showAll($list);
        } else {
            return view();
        }
    }

    public function roleTree()
    {
        $role_id=input('get.role_id');
        $menu=db("sw_role")->where("role_id",$role_id)->value("menus");
        //去掉加载icon字段是避免ztree中图标不显示
        $list = db('sw_menu')->field('icon', true)->select();
        foreach ($list as $key => $val){
            $id=$list[$key]['menu_id'];
            if(strpos(','.$menu,','.$id.',')===false) {
                $list[$key]['checked'] = false;
            }else{
                $list[$key]['checked'] = true;
            }
        }
        return $this->showAll($list);
    }

    public function roleForm()
    {
        if (request()->isPost()) {
            //清除缓存
            delete_dir_file(CACHE_PATH) && delete_dir_file(TEMP_PATH);
            $data = input('post.');
            if ($data['role_id'] == null) {
                db('sw_role')->insert($data);
                return $this->success('添加成功！');
            } else {
                db('sw_role')->update($data);
                return $this->success('编辑成功！');
            }
        } else {
            return view('role_form');
        }
    }

    public function roleDel()
    {
        $id = input('post.role_id');
        $subuser = db('sw_user')->where("role_id", $id)->find();
        if ($subuser) {
            return $this->error('该角色分配有用户，删除失败!');
        } else {
            db('sw_role')->delete($id);
            return $this->success('删除成功!');
        }

    }
}