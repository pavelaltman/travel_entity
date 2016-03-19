<?php

// No direct access to this file
defined('_JEXEC') or die('Restricted access');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."TravelEntityModelLItem.php";

class TravelEntityModelCountry extends TravelEntityModelLItem
{
 public function getItem()
 {
  global $glt ;

  if (!isset($this->item)) 
  {
   $this->SetIds(JRequest::getInt('class_id'),JRequest::getInt('country_id'));
   $this->SetPointsArr() ;
   $this->SetPointsMap() ;

   // Заполняем массив типов точек данного класса в данной стране 
   $this->AddSubList('distinct point_type_id,point_type_name'.$glt.',point_type_name_pl'.$glt,$this->item['labs']['bytypes_label']) ;
      
   // Заполняем массив регионов с точками данного класса в данной стране 
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
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute($this->GetClassId(),$this->GetCountryId(),$pointitem['point_type_id'],0) ; 
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle($this->GetClassId(),$this->GetCountryId(),$pointitem['point_type_id'],0,$pointitem) ;
    }
    elseif ($j==1)
    {
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute($this->GetClassId(),$this->GetCountryId(),0,$pointitem['region_id']) ;
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle(0,$this->GetCountryId(),0,$pointitem['region_id'],$pointitem);
    }
 }
}
