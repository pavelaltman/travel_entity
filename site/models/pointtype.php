<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."TravelEntityModelLItem.php";

class TravelEntityModelPointType extends TravelEntityModelLItem
{
 public function getItem()
 {
  if (!isset($this->item)) 
  {
   $this->SetIds(JRequest::getInt('class_id'),JRequest::getInt('country_id'),JRequest::getInt('type_id'));
   $this->SetPointsArr() ;
   $this->SetPointsMap() ;

   // Заполняем массив регионов с точками данного типа в данной стране 
   $this->AddSubList('distinct region_id,region_name'.$glt.',region_name_rod'.$glt,$this->item['labs']['byregions_label']) ;

   $this->FillSubListsLinks() ;
  }
  return $this->item;
 }

 public function FillSubListsLinks()
 {
  foreach($this->item['sublists'] as $j => $sublist) 
   foreach($sublist['list'] as $i => $pointitem)
    if ($j==0)
    {
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute($this->GetClassId(),$this->GetCountryId(),$this->GetTypeId(),$pointitem['region_id']) ;
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle($this->GetClassId(),$this->GetCountryId(),$this->GetTypeId(),$pointitem['region_id'],$pointitem);
    }
 }
}


