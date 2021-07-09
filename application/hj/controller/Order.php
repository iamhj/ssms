<?php


namespace app\hj\controller;

use app\hj\controller\Base;
use think\image\gif\Encoder;

class Order extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $list = db('hj_order o')
                ->join('hj_user u','o.phone=u.phone','left')
//                ->join('hj_user u','g.user_id=u.type_id','right')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            return view();
        }
    }

    // 查询当前登录买家的订单
    public function buyer_order()
    {

        if (request()->isAjax()) {
            $buyer_id = $_GET['buyer_id'];  // 获取买家编号
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $list = db('hj_order o')
                ->where('buyer_id', 'eq', $buyer_id)
//                ->join('hj_user u','o.buyer_id=u.user_id','left')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);

        } else {
            return view('buyer_order');
        }
    }

    public function seller_order()
    {
        if (request()->isAjax()) {
            $seller_id = $_GET['seller_id'];
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $list = db('hj_order o')
                ->where('seller_id', 'eq', $seller_id)
//                ->join('hj_user u','o.phone=u.phone','left')
//                ->join('hj_user u','g.user_id=u.type_id','right')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            return view();
        }
    }

    public function orderEdit()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $order_id = input('post.order_id');
            db('hj_order')
                ->where('order_id', 'eq', $order_id)
                ->update($data);
            return $this->success('订单修改成功！');
        } else {
            $list = db('hj_order')->select();
            $this->assign('list', $list);
            return view('order_edit_form');
        }
    }

    public function orderDel()
    {
        $id = input('post.order_id');
        db('hj_order')->delete($id);
        return $this->success('删除成功！');
    }
}