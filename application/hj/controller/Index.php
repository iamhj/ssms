<?php

namespace app\hj\controller;

use think\Db;
use think\debug\Console;

class Index extends Base
{
    public function index()
    {
        return view();
    }

    public function console()
    {
        return view();
    }

    public function menu()
    {
        //取出可见的菜单
        $data = db('hj_menu')
            ->where('visible',1)
            ->order('sort')
            ->select();
        $this->console("hello");

        foreach ($data as $key=>$val) {
            if(!in_array($val['menu_id'],$this->userMenus)){
                unset($data[$key]);
            }
        }

        //声明数组
        $menus = array();
        foreach ($data as $key=>$val){
            if($val['parent_id']==0){
                $val['icon'] = "layui-icon ".$val['icon'];
                $val['href'] = "javascript:;";
                    $menus[] = $val;
            }
        }
        foreach ($menus as $k=>$v){
            foreach ($data as $kk=>$vv){
                if($v['menu_id']==$vv['parent_id']){
                        $menus[$k]['subMenus'][] = $vv;
                }
            }
        }
        return json($menus);
    }

    /**
     * 清除缓存
     */
    public function clear() {
        if (delete_dir_file(CACHE_PATH) && delete_dir_file(TEMP_PATH)) {
            return $this->success('清除缓存成功');
        } else {
            return $this->error('清除缓存失败');
        }
    }

    /**
     * 主题设置
     */
    public function theme(){
        return view();
    }

    /**
     * 退出系统
     */
    public function logout(){
//        db('sys_user')->where('user_id',session('user_id'))->setField('online',0);
        session(null);
        $this->redirect('login/index');
    }
}