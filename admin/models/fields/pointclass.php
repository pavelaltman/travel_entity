<?php
defined('_JEXEC') or die;
jimport('joomla.form.helper');
JFormHelper::loadFieldClass('list');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class JFormFieldPointClass extends JFormFieldList
{
  protected $type = 'PointClass';
  protected function getOptions()
  {
    $db = JFactory::getDBO();
    $query = new TEQuery($db) ;
    $query->select('point_class_id,point_class_name');
    $query->from('#__te_point_classes');
    $db->setQuery($query);
    $titles = $db->loadObjectList();
    $options = array();
    if($titles){
      foreach($titles as $title)
      {
        $options[] = JHtml::_('select.option', $title->point_class_id, $title->point_class_name);
      }
    }
    $options = array_merge(parent::getOptions(), $options);
    return $options;
  }
}