<?php
defined('_JEXEC') or die('Restricted access');

jimport('joomla.database');

function query_replace($str) { return str_replace('#__te_', 'dollsfun_points.#__te_', $str) ; }


class TEQuery extends JDatabaseQueryMySql 
{
 protected function replace($str) { return str_replace('#__te_', 'dollsfun_points.#__te_', $str) ; }

 public function from($str) { return parent::from($this->replace($str)) ; }
 public function leftJoin($str) { return parent::join('LEFT',$this->replace($str)) ; }
 public function join($left,$str) { return parent::join($left,$this->replace($str)) ; }
}

