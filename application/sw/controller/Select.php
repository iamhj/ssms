<?php

namespace app\sw\controller;

use app\sw\controller\Base;

class Select extends Base
{
    public function index()
    {
        if (request()->isAjax()) {
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $list = db('sw_select o')
            // ->join('sw_user u','o.phone=u.phone','left')
            ->join('sw_user u', 'o.student_id=u.user_id', 'left')
                ->field('g.*,u.real_name') //查询结果
                ->join('sw_semester t', 'g.semester_id = t.semester_id', 'left')
                ->field('g.*,t.semester_name') //查询结果
                ->paginate($limit)
                ->toArray();

            return $this->showList($list);
        } else {
            return view();
        }
    }

    //学生退选
    public function withdraw()
    {
        if (db('sw_select')->where('select_id', input('post.select_id')) !== false) {
            $id = input('post.select_id');
            // // $course_id = input('post.course_id');
            // $course_id = 18;
            // $list = db('sw_course')->field('selected_number', 'rest_number')->where('course_id', $course_id)->paginate(10)->toArray();

            // $arr = [
            //     'course_id' => $course_id,
            //     'selected_number' => $list['selected_number'] - 1,
            //     'rest_number' => $list['rest_number'] + 1,
            //     'select_status' => '已选课'
            // ];
            // db('sw_course')->update($arr);
            db('sw_select')->delete($id);
            return $this->success('退选成功!');
        } else {
            return $this->error('退选失败!');
        }
    }

    public function selectDel()
    {
        $id = input('post.select_id');
        db('sw_select')->delete($id);
        return $this->success('删除成功！');
    }

    // 查询当前登录学生的选课
    public function student_select()
    {

        if (request()->isAjax()) {
            $student_id = $_GET['student_id']; // 获取学生编号
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $key = $get['key'] ?? '';
            $where = "s.student_id = " . $student_id;
            // $where .= " and s.score_status =  '已打分' ";
            if ($key) {
                $where .= " and m.semester_name like '%" . $key . "%'";
            } else {
                $where .= " and m.semester_name = '2018-2019第一学期'";
            }
//             $list = db('sw_select o')
            //                 ->where('student_id', 'eq', $student_id)
            // //                ->join('sw_user u','o.student_id=u.user_id','left')
            //                 ->paginate($limit)
            //                 ->toArray();

            $list = db('sw_course c')
                ->join('sw_select s', 's.course_id=c.course_id', 'inner')
                ->field('s.*, c.user_id, c.course_name')
                ->where($where)
                ->join('sw_semester m', 'm.semester_id=c.semester_id', 'inner')
                ->field('m.semester_name')
                // ->where('m.semester_name','eq','')
                ->join('sw_user u', 'u.user_id=c.user_id', 'inner')
                ->field('u.real_name')
                // ->where('s.student_id', 'eq', $student_id)
                //                ->join('sw_user u','o.student_id=u.user_id','left')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);

        } else {
            return view('student_select');
        }
    }

    // 查询学生成绩
    public function student_score()
    {

        if (request()->isAjax()) {
            $student_id = $_GET['student_id']; // 获取学生编号
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            $key = $get['key'] ?? '';
            $where = "s.student_id = " . $student_id;
            $where .= " and s.score_status =  '已打分' ";
            // $where .= " and s.score_status =  '已打分' and s.select_id = $key ";
            if ($key) {
                $where .= " and m.semester_name like '%" . $key . "%'";
            } else {
                $where .= " and m.semester_name = '2018-2019第一学期'";
            }
//             $list = db('sw_select o')
            //                 ->where('student_id', 'eq', $student_id)
            // //                ->join('sw_user u','o.student_id=u.user_id','left')
            //                 ->paginate($limit)
            //                 ->toArray();

            $list = db('sw_course c')
                ->join('sw_select s', 's.course_id=c.course_id', 'inner')
                ->field('s.*, c.user_id, c.course_name')
                ->where($where)
                // ->where($where1)
                ->join('sw_semester m', 'm.semester_id=c.semester_id', 'inner')
                ->field('m.semester_name')
                // ->where('m.semester_name','eq','')
                ->join('sw_user u', 'u.user_id=c.user_id', 'inner')
                ->field('u.real_name')
                // ->where('s.student_id', 'eq', $student_id)
                //                ->join('sw_user u','o.student_id=u.user_id','left')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);

        } else {
            return view('student_score');
        }
    }

    public function teacher_select()
    {
        if (request()->isAjax()) {
            $teacher_id = $_GET['teacher_id'];
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
//             $list = db('sw_select o')
            //                 ->where('teacher_id', 'eq', $teacher_id)
            // //                ->join('sw_user u','o.phone=u.phone','left')
            // //                ->join('sw_user u','g.user_id=u.semester_id','right')
            //                 ->paginate($limit)
            //                 ->toArray();
            $key = $get['key'] ?? '';
            $where1 = 'c.user_id=' . $teacher_id;
            // $where1 .= " and s.score_status =  '已打分' ";
            if ($key) {
                $where1 .= " and (c.course_name like '%" . $key . "%'";
                $where1 .= " or m.semester_name like '%" . $key . "%')";
            }

            $list = db('sw_select s')
                ->join('sw_course c', 's.course_id=c.course_id', 'left')
                ->field('s.*, c.*')
                ->where($where1)
                ->join('sw_semester m', 'm.semester_id=s.semester_id', 'left')
                ->field('m.semester_name')
                ->join('sw_user u', 'u.user_id=s.student_id', 'left')
                ->field('u.real_name, u.user_name')
                // ->where('s.student_id', 'eq', $student_id)
                //                ->join('sw_user u','o.student_id=u.user_id','left')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            return view();
        }
    }

    public function teacher_score()
    {
        if (request()->isAjax()) {
            $teacher_id = $_GET['teacher_id'];
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            //             $list = db('sw_select o')
            //                 ->where('teacher_id', 'eq', $teacher_id)
            // //                ->join('sw_user u','o.phone=u.phone','left')
            // //                ->join('sw_user u','g.user_id=u.semester_id','right')
            //                 ->paginate($limit)
            //                 ->toArray();
            $key = $get['key'] ?? '';
            $where1 = 'c.user_id=' . $teacher_id;
            $where1 .= " and s.score_status =  '已打分' ";
            // $where1 .= " and s.semester_id = " . $key;
            if ($key) {
                $where1 .= " and (c.course_name like '%" . $key . "%'";
                $where1 .= " or m.semester_name like '%" . $key . "%')";
            }

            $list = db('sw_select s')
                ->join('sw_course c', 's.course_id=c.course_id', 'left')
                ->field('s.*, c.*')
                ->where($where1)
                ->join('sw_semester m', 'm.semester_id=s.semester_id', 'left')
                ->field('m.semester_name')
                ->join('sw_user u', 'u.user_id=s.student_id', 'left')
                ->field('u.real_name,u.user_name')
                // ->where('s.student_id', 'eq', $student_id)
                //                ->join('sw_user u','o.student_id=u.user_id','left')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            return view();
        }
    }

    //教师打分
    public function selectEdit()
    {
        if (request()->isPost()) {
            $list = input('post.');
            $total_score = $list['normal_score'] * 0.3 + $list['test_score'] * 0.7;
            if ($total_score <= 100 && $total_score >= 90) {
                $grade_score = '优秀';
            } else if ($total_score < 90 && $total_score >= 80) {
                $grade_score = '良好';
            } else if ($total_score < 80 && $total_score >= 70) {
                $grade_score = '中等';
            } else if ($total_score < 70 && $total_score >= 60) {
                $grade_score = '及格';
            } else if ($total_score < 60) {
                $grade_score = '不及格';
            }

            $data = [
                "select_id" => $list['select_id'],
                "normal_score" => $list['normal_score'],
                "test_score" => $list['test_score'],
                "total_score" => $total_score,
                "grade_score" => $grade_score,
                'score_status' => '已打分',
            ];
            db('sw_select')->update($data);
            return $this->success('打分完成!');
        } else {
            $list = db('sw_select')->select();
            $this->assign('list', $list);
            return view('select_edit_form');
        }
    }

    //管理员修改教师打分权限
    public function Edit()
    {
        $status = input('post.score_status');
        if (db('sw_select')->where('select_id', input('post.select_id'))->update(['score_status' => '未打分'])) {
            return $this->success('修改成功!');
        } else {
            return $this->error('修改失败!');
        }
    }

    public function select()
    {
        if (request()->isAjax()) {
            // $teacher_id = $_GET['teacher_id'];
            $get = $this->request->get();
            $limit = $get['limit'] ?? 10;
            //             $list = db('sw_select o')
            //                 ->where('teacher_id', 'eq', $teacher_id)
            // //                ->join('sw_user u','o.phone=u.phone','left')
            // //                ->join('sw_user u','g.user_id=u.semester_id','right')
            //                 ->paginate($limit)
            //                 ->toArray();
            $key = $get['key'] ?? '';
            $where1 = 'c.user_id!=-1';
            // $where1 .= " and s.score_status =  '已打分' ";
            if ($key) {
                $where1 .= " and (c.course_name like '%" . $key . "%'";
                $where1 .= " or m.semester_name like '%" . $key . "%')";
            }

            $list = db('sw_select s')
                ->join('sw_course c', 's.course_id=c.course_id', 'left')
                ->field('s.*, c.*')
                ->where($where1)
                ->join('sw_semester m', 'm.semester_id=s.semester_id', 'left')
                ->field('m.semester_name')
                ->join('sw_user u', 'u.user_id=s.student_id', 'left')
                ->field('u.real_name')
                // ->where('s.student_id', 'eq', $student_id)
                //                ->join('sw_user u','o.student_id=u.user_id','left')
                ->paginate($limit)
                ->toArray();
            return $this->showList($list);
        } else {
            return view();
        }
    }
}
