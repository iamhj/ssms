<?php


namespace app\cy\controller;

use app\cy\controller\Base;
use think\image\gif\Encoder;

class Order extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $list = db('cy_order o')
                ->join('cy_user u','o.phone=u.phone','left')
//                ->join('cy_user u','g.user_id=u.type_id','right')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            return view();
        }
    }

    //店主发货
    public function sendStatus()
    {
        $status = input('post.status');
        if (db('cy_order')->where('order_id', input('post.order_id'))->update(['status' => '已发货']) !== false) {
            return $this->success('发货成功!');
        } else {
            return $this->error('发货失败!');
        }
    }

    //读者确认订单
    public function firmStatus()
    {
        $status = input('post.status');
        if (db('cy_order')->where('order_id', input('post.order_id'))->update(['order_status' => '已确认']) !== false) {
            return $this->success('确认成功!');
        } else {
            return $this->error('确认失败!');
        }
    }

    // 查询当前登录买家的订单
    public function buyer_order()
    {

        if (request()->isAjax()) {
            $buyer_id = $_GET['buyer_id'];  // 获取买家编号
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $list = db('cy_order o')
                ->where('buyer_id', 'eq', $buyer_id)
//                ->join('cy_user u','o.buyer_id=u.user_id','left')
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
            $list = db('cy_order o')
                ->where('seller_id', 'eq', $seller_id)
//                ->join('cy_user u','o.phone=u.phone','left')
//                ->join('cy_user u','g.user_id=u.type_id','right')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            return view();
        }
    }

    //店主修改订单信息
    public function orderEdit()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $order_id = input('post.order_id');
            db('cy_order')
                ->where('order_id', 'eq', $order_id)
                ->update($data);
            return $this->success('订单修改成功！');
        } else {
            $list = db('cy_order')->select();
            $this->assign('list', $list);
            return view('order_edit_form');
        }
    }

    public function orderDel()
    {
        $id = input('post.order_id');
        db('cy_order')->delete($id);
        return $this->success('删除成功！');
    }
}