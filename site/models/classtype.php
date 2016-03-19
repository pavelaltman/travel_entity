<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."TravelEntityModelLItem.php";

class TravelEntityModelClassType extends TravelEntityModelLItem
{
 public function getItem()
 {
  global $glt ;

  if (!isset($this->item)) 
  {
   $class_id=JRequest::getInt('class_id') ;
   $type_id=JRequest::getInt('type_id') ;
   $this->SetIds($class_id,0,$type_id);
   $this->SetPointsArr() ;
   $this->SetPointsMap() ;

   // «аполн€ем массив стран с точками данного типа 
   $this->AddSubList('distinct country_id,country_name'.$glt.',country_name_rod'.$glt,$this->item['labs']['bycountries_label']) ;

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
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute($this->GetClassId(),$pointitem['country_id'],$this->GetTypeId(),0) ;
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle($this->GetClassId(),$pointitem['country_id'],$this->GetTypeId(),0,$pointitem);
    }
 }
}


