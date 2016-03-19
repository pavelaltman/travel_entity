<?php

// No direct access to this file
defined('_JEXEC') or die('Restricted access');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."TravelEntityModelLItem.php";

class TravelEntityModelPoints extends TravelEntityModelLItem
{
 public function getItem()
 {
  global $glt ;


  if (!isset($this->item)) 
  {
   $this->SetIds();
   $this->SetPointsArr() ;
   $this->SetPointsMap() ;

   // Заполняем массив списка стран 
   $this->AddSubList('distinct country_id,country_name'.$glt.',country_name_rod'.$glt,'','country_name'.$glt,1) ;

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
     $this->item['sublists'][$j]['list'][$i]['link']=$this->GetRoute(0,$pointitem['country_id'],0,0) ; 
     $this->item['sublists'][$j]['list'][$i]['link_text']= $this->GetTitle(0,$pointitem['country_id'],0,0,$pointitem) ;
    }
 }
}
