<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelCountries extends JModelList
{
  protected function getListQuery()
  {
    $db = JFactory::getDBO();
    $query = new TEQuery($db) ;
    $query->select('country_id,country_name');
    $query->from('#__te_countries');
    $query->order('country_name');
    return $query;
  }
}
?>