<?php


namespace app\cy\controller;

use think\Cache;
use think\Controller;
use think\captcha\Captcha;

class Login extends Controller
{
    public function _initialize()
    {
        if (session('user_id')) {
            $this->redirect('cy/index/index');
        }
    }

    public function index() //映射view\login\index.html
    {
        if (request()->isAjax()) {
            $data = input('post.');
            if (!captcha_check($data['code'])) {
                return $this->error('验证码错误');
            }
            $user = db('cy_user')->where('user_name', $data['user_name'])->find();
            if ($user) {
//                if ($user['status'] == 1 && $user['password'] == md5($data['password'])) {
                if ($user['password'] == md5($data['password'])) {
                    session('user_name', $user['user_name']);
                    session('real_name', $user['real_name']);
                    session('user_id', $user['user_id']);
                    session('role_id', $user['role_id']);
                    //db('cy_user')->where('user_id', $user['user_id'])->update(['login_time' => time()]);
                    //db('cy_user')->where('user_id',$user['user_id'])->setField('online',1);
                    return $this->success('登录成功!', url('cy/index/index')); //信息正确
                    console . log("login.php/index(37)");
                } else {
                    return $this->error('用户名或者密码错误，重新输入!'); //密码错误
                }
            } else {
                return $this->error('用户不存在!'); //用户不存在
            }
        } else {
            return view();  //默认映射view\index\index.html
        }
    }

    public function forgetPwd()
    {
        return view('forget_pwd');
    }

    public function register()  //对应view\login\register.html
    {
        if (request()->isPost()) {
            $data = input('post.');
            $user = db('cy_user')->where('user_name', $data['user_name'])->find();
            if ($user) {
                return $this->error('该用户名已经注册!');
            } else {
                $phone = db('cy_user')->where('phone', $data['phone'])->find();
                if ($phone) {
                    return $this->error('该手机号已经注册!');
                } else {
                    $data['user_name'] = $data['user_name'];
//                    $data['role_id'] = 2;   //默认注册为“买家”
                    $data['role_id'] = $data['role_id'];
                    $data['password'] = md5($data['password']);
                    db('cy_user')->insert($data);
                    return $this->success('注册成功!', 'index');
                }
            }
        } else {
            return view();
        }

    }

    public function resetPwd()
    {
        if (request()->isPost()) {
//            $data1 = input('post.');
//            $phone = db('cy_user')->where('phone', $_POST['phone'])->find();
//            $phone = $_POST['phone'];
//            $data = input('post.');
//            $data['password'] = md5($data['password']);
            $data = [
                'phone' => input('post.phone2'),
                'password' => md5(input('post.password'))
            ];
            db('cy_user')
                ->where('phone', 'eq', $data['phone'])
                ->update($data);
            return $this->success('密码重置成功！', 'index');

        } else {
            return view();
        }
    }
}