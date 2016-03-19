<?php

// No direct access to this file
defined('_JEXEC') or die('Restricted access');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."TravelEntityModelLItem.php";

class TravelEntityModelRegionCountry extends TravelEntityModelLItem
{
 public function getItem()
 {
  if (!isset($this->item)) 
  {
   $country_id=JRequest::getInt('country_id') ;
   $region_id=JRequest::getInt('region_id') ;
   $this->SetIds(0,$country_id,0,$region_id);

   $this->SetPointsArr() ;
   $this->SetPointsMap() ;

   //print_r($country_id) ;
   //print_r($region_id) ;
   //print_r($this->item['data']) ;

   // Заполняем массив классов точек в данном регионе страны 
   $this->AddSubList('distinct point_class_id,point_class_name'.$glt.',point_class_name_pl'.$glt,$this->item['labs']['byclasses_label']) ;
   //print_r($this->item['sublists']) ;
      
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
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute($pointitem['point_class_id'],$this->GetCountryId(),0,$this->GetRegionId()) ; 
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle($pointitem['point_class_id'],$this->GetCountryId(),0,$this->GetRegionId(),$pointitem) ;
    }
  // print_r($this->item['sublists']) ;
 }
}
