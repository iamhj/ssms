<?php

// $x=array(1=>"Google", 2=>"Runoob", 3=>"Taobao");
$data = [
	[
		"cid":1,
		"sid":1
	],
	[
		"cid":2,
		"sid":2
	],[
		"cid":3,
		"sid":3
	]
];
foreach ($data as $key => $value)
{
    echo "key  为 " . $key . "，对应的 value 为 ". $value . PHP_EOL;
}
?>