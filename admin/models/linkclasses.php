<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelLinkClasses extends JModelList
{
  protected function getListQuery()
  {
    $db = JFactory::getDBO();
    $query = new TEQuery($db) ;
    $query->select('link_class_id,link_class_name');
    $query->from('#__te_points_link_classes');
    return $query;
  }
}
?>