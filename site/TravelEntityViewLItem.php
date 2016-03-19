<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');
 
// import Joomla view library
jimport('joomla.application.component.view');
 
class TravelEntityViewLItem extends JView
{
 function display($tpl = null) 
 {
  $this->item = $this->GetModel()->getItem() ;

  $items = $this->get('Items');
  $pagination = $this->get('Pagination');
 
  $this->items = $items;
  $this->pagination = $pagination;
  $this->state = $this->get('State');
               

  // Check for errors.
  if (count($errors = $this->get('Errors'))) 
  {
   JError::raiseError(500, implode('<br />', $errors));
   return false;
  }

  // Display the view
  parent::display($tpl);
 }

 public function Show()
 {
  $source_route=$this->GetModel()->GetOwnSourceRoute() ;
 
  global $glt ;

  // выводим хлебные крошки
  echo "<table width=\"100%\">" ;
  foreach($this->item['breadcrumbs'] as $j => $row) 
  {
   echo "<tr>" ;
   foreach($row as $i => $col) 
    echo "<td><a href=\"".$col['link']."\">".$col['link_text']."</a></td>" ;
   echo "</tr>" ;
  }
  echo "</table>" ;

  // Заголовок (правее заголовка - фильтр все-был-хочу)
  echo "<table width=\"100%\"><tr>" ;
  echo "<td><h3>".$this->GetModel()->GetOwnTitle()."</h3></td>" ;
  echo "<td>" ;
  if ($this->GetModel()->user->id)
  {
   echo "<form action=\"".JRoute::_($this->GetModel()->GetOwnSourceRoute()."&task=".$this->GetModel()->GetOwnViewName().".change_awb")."&viewname=".$this->GetModel()->GetOwnViewName()."&cl_id=".$this->GetModel()->GetClassId()."&co_id=".$this->GetModel()->GetCountryId()."&re_id=".$this->GetModel()->GetRegionId()."&ty_id=".$this->GetModel()->GetTypeId()."\" method=\"post\" name=\"".$this->GetModel()->GetOwnViewName()."\">" ;
   echo " <fieldset id=\"filter-bar\">" ;
   echo          JHtml::_('select.radiolist', $this->GetModel()->all_want_been_arr,'all_want_been','class="radiobox" onchange="this.form.submit()"', 'value', 'text'.$glt ,$this->GetModel()->all_want_been,null,true) ;
   if ($this->GetModel()->all_want_been==2)
   {
    echo         JHtml::_('select.radiolist', $this->GetModel()->want_grade_arr,'want_grade','class="radiobox" onchange="this.form.submit()"', 'value', 'text' ,$this->GetModel()->want_grade,null,true) ;
   }
   echo " </fieldset>" ;
   echo "</form>" ;
   echo "</td>" ;
  }
  else echo $this->item['labs']['login_filter_label'] ;
  echo "</tr></table>" ;

  // Описание
  if (!is_null($this->item['descr']))
    echo "<p>".$this->item['descr']['long_descr'.$glt]."</p>" ;

  // выводим подсписки, в ширину
  echo "<p><table width=\"100%\"><tr>" ;
  foreach($this->item['sublists'] as $j => $sublist) 
  {
   echo "<td width=\"50%\" valign=\"top\">" ;
   if (strlen($sublist['label']))
     echo "<br><p><h5>".$this->GetModel()->GetOwnTitle()." ".$sublist['label']."</h5>" ;

   if ($sublist['flat']) // список
   {
    foreach($sublist['list'] as $i => $pointitem)
    {
     echo "<a href=\"".$pointitem['link']."\">".$pointitem['link_text']."</a> " ;
    }
   }
   else // таблица
   {
    echo "<table width=\"100%\">" ;
    foreach($sublist['list'] as $i => $pointitem)
    {
     echo "<tr>" ;
     echo "<td><a href=\"".$pointitem['link']."\">".$pointitem['link_text']."</a></td>" ;
     echo "</tr>" ;
    }
    echo "</table></td>" ;
   }
  }
  echo "</tr></table>" ;


  if ($this->GetModel()->CheckMap('pointsmap'))
  {
   $this->GetModel()->GetMaps()->DrawMap('pointsmap') ;
  }


  // Список точек 

  if ($this->GetModel()->show_list)
  {
   echo "<br><p><h5>".$this->GetModel()->GetOwnTitle()." - ".$this->GetModel()->all_want_been_arr[max(0,$this->GetModel()->all_want_been-1)]->text."</h5>" ;
   echo "<p><table width=\"100%\">" ;
   foreach($this->items as $i => $pointitem)
   {
    // print_r($pointitem) ;
    $pi= (array) $pointitem ;


    echo "<tr>" ;
    echo "<td>".GetPointNameLink($pi)."</td>" ;
    echo "<td>".$pi['point_subtype_name'.$glt]."</td>"; 
    if (!$this->GetModel()->GetTypeId())
      echo "<td>".$pi['point_type_name'.$glt]."</td>"; 
    echo "<td>".$pi['subregion_name'.$glt]."</td>"; 
    if (!$this->GetModel()->GetRegionId())
      echo "<td>".$pi['region_name'.$glt]."</td>"; 
    if (!$this->GetModel()->GetCountryId())
      echo "<td>".$pi['country_name'.$glt]."</td>"; 
    echo "</tr>" ;
   }
   echo "</table></p>" ;
   echo $this->pagination->getListFooter() ;
  }
 }
}
