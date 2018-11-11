<?php
defined('_JEXEC') or die('Restricted access');

jimport('joomla.database');

function query_replace($str) { return str_replace('#__te_', 'dollsfun_points.#__te_', $str) ; }


class TEQuery extends JDatabaseQueryMySqli 
{
 protected function replace($str) { return str_replace('#__te_', 'dollsfun_points.#__te_', $str) ; }

 public function from($str,$alias=NULL) { return parent::from($this->replace($str),$alias) ; }
 public function update($str) { return parent::update($this->replace($str)) ; }
 public function leftJoin($str) { return parent::join('LEFT',$this->replace($str)) ; }
 public function join($left,$str) { return parent::join($left,$this->replace($str)) ; }
}

class TETable extends JTable
{
	function __construct($name,$key,&$db)
	{
		parent::__construct('dollsfun_points.'.$name, $key, $db);
	}
}
