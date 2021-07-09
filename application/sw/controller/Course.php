<?php


namespace app\sw\controller;


use app\sw\controller\Base;


class Course extends Base
{
    public function index()
    {
        if (request()->isAjax()) {

            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $key = $get['key'] ?? '';
            //            $role_id = $get['role'] ?? 0;
            //            $sell_id = $get['teacher_id'];
            // $where = 'c.semester_id != -1';
            $where = 'c.semester_id = 1';
            //            $where = '';
            if ($key) {
                $where .= " and (course_name like '%" . $key . "%'";
                $where .= " or semester_name like '%" . $key . "%')";
            }

            $list = db('sw_course')->alias('c')
                ->join('sw_semester t', 'c.semester_id = t.semester_id', 'left')
                // ->join('sw_semester t', 'c.semester_id = 1', 'left') //指定学科学期
                ->field('c.*,t.semester_name') //查询结果
                ->join('sw_user u', 'u.user_id = c.user_id', 'left')
                ->field('c.*,u.real_name') //查询结果
                ->where($where)
                ->paginate($limit)
                ->toArray();

            return $this->showList($list);
        } else {
            return view();
        }
    }

    public function userInfo()
    {
        $id = $_GET['user_id'];
        $list = db('sw_user')
            ->field('real_name, phone, address')
            ->where('user_id', '=', $id)
            ->select();
        //        return $this->showList($list, '1', '成功');
        return json($list);
    }

    //教师开班
    public function sendStatus()
    {
        $status = input('post.status');
        if (db('sw_course')->where('course_id', input('post.course_id'))->update(['status' => '已开班']) !== false) {
            return $this->success('开班成功!');
        } else {
            return $this->error('开班失败!');
        }
    }

    //教师添加课程
    public function courseForm()
    {
        if (request()->isPost()) {
            $data = input('post.');
            $id = input('post.course_id');
            if ($id == null) {
                db('sw_course')->insert($data);
                return $this->success('课程添加成功！');
            } else {
                db('sw_course')->update($data);
                return $this->success('课程修改成功！');
            }
        } else {
            $list = db('sw_semester')->select();
            $this->assign('list', $list);
            return view('course_form');
        }
    }

    public function courseDel()
    {
        $id = input('post.course_id');
        db('sw_course')->delete($id);
        return $this->success('删除成功！');
    }

    public function semester()
    {
        return view();
    }

    public function semesterData()
    {
        $list = db('sw_semester')->select();
        return $this->showAll($list);
    }

    // 选课功能
    public function change_quantity()
    {
        if (request()->isAjax()) {
            // 可选人数减一
            $selected_number = $_GET['selected_number'];
            $course_id = $_GET['course_id'];
            $rest_number = $_GET['rest_number'];
            $arr = [
                'course_id' => $course_id,
                'selected_number' => $selected_number + 1,
                'rest_number' => $rest_number - 1,
                'select_status' => '已选课'
            ];
            db('sw_course')->update($arr);

            // 将选课记录插入sw_select表
            $get = $this->request->get();
            $data = [
                "student_id" =>  $get['student_id'],
                "teacher_id" => $get['user_id'],
                "course_id" => $get['course_id'],
                "course_name" => $get['course_name'],
                "semester_id" => $get['semester_id'],
                "address" => $get['address'],
                "time" => $get['time'],
                "credit" => $get['credit'],
            ];
            db('sw_select')->insert($data);
            return $this->success('选课成功');
        }
    }

    // 判断当前课程是否已选
    public function isSelected()
    {
        if (request()->isAjax()) {
            $course_id = $_GET['course_id'];
            $student_id = $_GET['student_id'];
            $list = db('sw_select s')
                ->join('sw_course c', 's.course_id=c.course_id', 'left')
                ->field('s.*')
                ->where('s.student_id', 'eq', $student_id);
            if ($list) {
                return $this->success('');
            }
        }
    }


    //    选择课程，写入sw_select表
    //     public function selectCourse()
    //     {
    //         if (request()->isPost()) {
    // //            $data1 = input('post.');
    // //            if(input('post.pay')==null){
    // //                return $this->success('选择人数超过库存，请重新输入！');
    // //            }
    //             $data = [
    //                 "student_id" => input('post.student_id')
    //                 , "teacher_id" => input('post.user_id')
    // //                , "real_name" => input('post.real_name')
    // 								, "describe" => input('post.describe')
    //                 , "address" => input('post.address')
    //                 , "course_id" => input('post.course_id')
    //                 , "course_name" => input('post.course_name')
    // 								, "credit" => input('post.credit')
    //                 , "rest_number" => input('post.rest_number')
    //                 , "select_number" => input('post.select_number')
    //             ];
    //             db('sw_select')->insert($data);  // 插入选课

    //             $data2 = [
    //                 "rest_number" => input('post.rest_number') - input('post.select_number')
    //             ];
    //             db('sw_course')    // 修改库存
    //             ->where('course_id', 'eq', input('post.course_id'))
    //                 ->update($data2);

    //             return $this->success('选课成功！');

    //         } else {
    //             $list = db('sw_course g')
    //                 ->join('sw_user u', 'g.user_id=u.user_id', 'inner')
    //                 ->select();
    //             $this->assign('list', $list);
    //             return view('select_form');
    //         }
    //     }

    // 销售选课
    public function teacher_form()
    {
        if (request()->isAjax()) {
            //            $teacher_id = $_GET['teacher_id'];
            $get = $this->request->get();
            $teacher_id = $get['teacher_id'];
            $limit = $get['limit'] ?? 10;
            $key = $get['key'] ?? '';
            // $where = 'course_id!=-1';
            $where = "user_id = " . $teacher_id;
            if ($key) {
                $where .= " and (course_name like '%" . $key . "%'";
                //                $where .= " and user_id = $teacher_id";
                $where .= " or semester_name like '%" . $key . "%')";
            }

            $list = db('sw_course')->alias('g')
                ->join('sw_semester t', 'g.semester_id = t.semester_id', 'left')
                ->field('g.*,t.semester_name') //查询结果
                ->where($where)
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);

            //        if (request()->isAjax()) {
            //            $get = $this->request->get();
            //            $limit = $get['limit'] ?? 10;
            //            $list = db('sw_course g')
            //                ->join('sw_semester t','g.semester_id=t.semester_id','left')
            ////                ->join('sw_user u','g.user_id=u.semester_id','right')
            //                ->paginate($limit)
            //                ->toArray();
            //            return $this->showList($list);
        } else {
            return view("teacher_form");
        }
    }
}
