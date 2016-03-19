<?php
// No direct access to this file
defined('_JEXEC') or die;

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."TravelEntityModelLItem.php";

class TravelEntityModelPointClass extends TravelEntityModelLItem
{
 public function getItem()
 {
  global $glt ;

  if (!isset($this->item)) 
  {
   $this->SetIds(JRequest::getInt('class_id'));
   $this->SetPointsArr() ;
   $this->SetPointsMap() ;

   // «аполн€ем массив стран с точками данного класса
   $this->AddSubList('distinct country_id,country_name'.$glt.',country_name_rod',$this->item['labs']['bycountries_label'],'country_name'.$glt,1) ;
      
   // «аполн€ем массив типов точек данного класса
   $this->AddSubList('distinct point_type_id,point_type_name'.$glt.',point_type_name_pl'.$glt,$this->item['labs']['bytypes_label']) ;


   $this->FillSubListsLinks() ;
  }
  return $this->item;
 }

 public function FillSubListsLinks()
 {
  foreach($this->item['sublists'] as $j => $sublist) 
   foreach($sublist['list'] as $i => $pointitem)
   {
    if ($j==0)
    {
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute($this->GetClassId(),$pointitem['country_id']) ; 
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle(0,$pointitem['country_id'],0,0,$pointitem) ;
    }
    if ($j==1)
    {
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute($this->GetClassId(),0,$pointitem['point_type_id']) ; 
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle($this->GetClassId(),0,$pointitem['point_type_id'],0,$pointitem) ;
    }
  }
 }
}



