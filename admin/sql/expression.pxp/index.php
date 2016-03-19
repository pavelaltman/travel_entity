<?php

$link = mysql_connect('dollsfun.mysql.ukraine.com.ua','dollsfun_words','5qjrucvp');
if(!$link) die ('Could not connect to database: '.mysql_error());
mysql_select_db('dollsfun_words',$link);

require_once('formfromtable.php') ;

$form=new FormFromTable() ;
$form->init_state() ;
echo $form->build_form(1,"wl_words") ;

//print_r($form->insert_sequence) ;
//print_r($_POST) ;

$form->insert_data() ;
$form->show_table() ;
$form->save_state() ;


mysql_close($link);
?>


