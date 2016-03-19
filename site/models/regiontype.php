<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."TravelEntityModelLItem.php";

class TravelEntityModelRegionType extends TravelEntityModelLItem
{
 public function getItem()
 {
  if (!isset($this->item)) 
  {
   $this->SetIds(JRequest::getInt('class_id'),JRequest::getInt('country_id'),JRequest::getInt('type_id'),JRequest::getInt('region_id'));
   $this->SetPointsArr() ;
   $this->SetPointsMap() ;
  }
  return $this->item;
 }
}


