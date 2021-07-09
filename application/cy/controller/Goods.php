<?php


namespace app\cy\controller;


use app\cy\controller\Base;


class Goods extends Base
{
    public function index()
    {
        if (request()->isAjax()) {

            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $key = $get['key'] ?? '';
//            $role_id = $get['role'] ?? 0;
//            $sell_id = $get['seller_id'];
            $where = 'goods_id!=-1';
//            $where = '';
            if ($key) {
                $where .= " and (goods_name like '%" . $key . "%'";
                $where .= " or type_name like '%" . $key . "%')";
            }
//            if ($role_id > 0) {
//                $where .= " and (r.role_id=" . $role_id . ")";
//            }

            $list = db('cy_goods')->alias('g')
                ->join('cy_goods_type t', 'g.type_id = t.type_id', 'left')
                ->field('g.*,t.type_name')//查询结果
                ->where($where)
//                ->order('role_id,u.user_id')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);

//            $get = $this->request->get();
//            $limit = $get['limit'] ?? 10;
//            $list = db('cy_goods g')
//                ->join('cy_goods_type t','g.type_id=t.type_id','left')
////                ->join('cy_user u','g.user_id=u.type_id','right')
//                ->paginate($limit)
//                ->toArray();
//            return $this->showList($list);
        } else {
            return view();
        }
    }

    public function userInfo()
    {
        $id = $_GET['user_id'];
        $list = db('cy_user')
            ->field('real_name, phone, address')
            ->where('user_id', '=', $id)
            ->select();
//        return $this->showList($list, '1', '成功');
        return json($list);
    }

    //店主添加书籍
    public function goodsForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $id = input('post.goods_id');
//            $data['user_id'] = input('post.seller_id');
//            if ($data['goods_id'] == null) {
            if ($id == null) {
                db('cy_goods')->insert($data);
                return $this->success('商品添加成功！');
            } else {
                db('cy_goods')->update($data);
                return $this->success('商品修改成功！');
            }
        } else {
            $list = db('cy_goods_type')->select();
            $this->assign('list', $list);
            return view('goods_form');
        }
    }

    public function goodsDel()
    {
        $id = input('post.goods_id');
        db('cy_goods')->delete($id);
        return $this->success('删除成功！');
    }

    public function type()
    {
        return view();
    }

    public function typeData()
    {
        $list = db('cy_goods_type')->select();
        return $this->showAll($list);
    }

//    购买商品，写入cy_order表
    public function buyGoods()
    {
        if (request()->isPost()) {
//            $data1 = input('post.');
//            if(input('post.pay')==null){
//                return $this->success('购买数量超过库存，请重新输入！');
//            }
            $data = [
                "buyer_id" => input('post.buyer_id')
                , "consignee_name" => input('post.consignee_name')
                , "seller_id" => input('post.user_id')
//                , "real_name" => input('post.real_name')
                , "phone" => input('post.phone')
                , "address" => input('post.address')
                , "goods_id" => input('post.goods_id')
                , "goods_name" => input('post.goods_name')
                , "buy_number" => input('post.buy_number')
                , "pay" => input('post.pay')
                , "order_number" => input('post.order_number')
            ];
            db('cy_order')->insert($data);  // 插入订单

            $data2 = [
                "number" => input('post.number') - input('post.buy_number')
            ];
            db('cy_goods')    // 修改库存
            ->where('goods_id', 'eq', input('post.goods_id'))
                ->update($data2);

            return $this->success('下单成功！');

        } else {
            $list = db('cy_goods g')
                ->join('cy_user u', 'g.user_id=u.user_id', 'inner')
                ->select();
            $this->assign('list', $list);
            return view('buy_form');
        }
    }

    // 销售订单
    public function seller_form()
    {
        if (request()->isAjax()) {
//            $seller_id = $_GET['seller_id'];
            $get = $this->request->get();
            $seller_id = $get['seller_id'];
            $limit = $get['limit'] ?? 10;
            $key = $get['key'] ?? '';
//            $where = 'goods_id!=-1';
            $where = "user_id = " . $seller_id;
            if ($key) {
                $where .= " and (goods_name like '%" . $key . "%'";
//                $where .= " and user_id = $seller_id";
                $where .= " or type_name like '%" . $key . "%')";
            }
            $list = db('cy_goods')->alias('g')
                ->join('cy_goods_type t', 'g.type_id = t.type_id', 'left')
                ->field('g.*,t.type_name')//查询结果
                ->where($where)
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);

//        if (request()->isAjax()) {
//            $get = $this->request->get();
//            $limit = $get['limit'] ?? 10;
//            $list = db('cy_goods g')
//                ->join('cy_goods_type t','g.type_id=t.type_id','left')
////                ->join('cy_user u','g.user_id=u.type_id','right')
//                ->paginate($limit)
//                ->toArray();
//            return $this->showList($list);
        } else {
            return view("seller_form");
        }
    }
}