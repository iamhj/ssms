<?php

namespace app\j2\controller;
class Test
{
    public function hello()
    {
        return "hello";
    }

    public function db4()
    {
        $data=[
            'book_name'=>'动态网站',
            'type_id'=>2,
        ];
        $flag=db('book')
            ->where('book_id',2)
            ->update($data);

        $data=[
            'book_name'=>'动态网站',
            'type_id'=>2,
            'book_id'=>2
        ];
        $flag=db('book')
            ->update($data);
    }

    public function db3()
    {
        db('book')
            ->where('book_id','=',8)
            ->delete();
        db('book')
            ->where('book_id',8)
            ->delete();
        db('book')
            ->delete(8);
    }

    public function db2()
    {
        $data=[
            'book_name'=>'动态网站',
            'type_id'=>2
        ];
        $flag=db('book')->insert($data);
        if($flag){
            return "增加成功";
        }else{
            return "增加失败";
        }
    }
    public function db1()
    {
        $data=db('book b')
            ->field('book_name,type_name')
            ->join('book_type bt',
                'b.type_id=bt.type_id',
                'left')
            //->where('book_id','=',1)
            ->where('book_name','like','%计%')
            ->select();
        //->find();
        var_dump($data);
    }

}
