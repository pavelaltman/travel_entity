<?php

// No direct access to this file
defined('_JEXEC') or die('Restricted access');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."TravelEntityModelLItem.php";

class TravelEntityModelMainCountry extends TravelEntityModelLItem
{
 public function getItem()
 {
  global $glt ;

  if (!isset($this->item)) 
  {
   $country_id=JRequest::getInt('country_id') ;

   $this->SetIds(0,$country_id);
   $this->SetPointsArr() ;
   $this->SetPointsMap() ;

   // «аполн€ем массив классов точек в данной стране 
   $this->AddSubList('distinct point_class_id,point_class_name'.$glt.',point_class_name_pl'.$glt,$this->item['labs']['byclasses_label']) ;
      
   // «аполн€ем массив регионов с точками в данной стране 
   $this->AddSubList('distinct region_id,region_name'.$glt.',region_name_rod'.$glt,$this->item['labs']['byregions_label'],'region_name'.$glt,1) ;

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
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute($pointitem['point_class_id'],$this->GetCountryId(),0,0) ; 
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle($pointitem['point_class_id'],$this->GetCountryId(),0,0,$pointitem) ;
    }
    elseif ($j==1)
    {
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute(0,$this->GetCountryId(),0,$pointitem['region_id']) ;
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle(0,$this->GetCountryId(),0,$pointitem['region_id'],$pointitem);
    }
  // print_r($this->item['sublists']) ;
 }
}
