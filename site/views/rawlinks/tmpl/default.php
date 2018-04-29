<?php
// No direct access to this file
defined('_JEXEC') or die;


if ($this->GetModel()->user->id)
{
 echo "<form action=\"".JRoute::_('index.php?option=com_travelentity&task=rawlinks.addlink')."\" method=\"post\" name=\"addlink\">" ;
 echo "<input type=\"text\" size=\"120\" name=\"new_link\">" ;
 echo "<input type=\"submit\" value=\"".$this->GetModel()->labs['add_label']."\">" ;
 echo "</form>" ;

 echo "<table width=\"100%\">" ;

 foreach($this->items as $i => $item): 
  echo "<tr>" ;
  echo "<td><a href=\"".$item->link_text."\">".$item->link_text."</a></td>" ;
  echo "<td><form action=\"".JRoute::_('index.php?option=com_travelentity&task=rawlinks.updatecountry&link_id='.$item->link_id)."\" method=\"post\" name=\"updatecountry\">" ;
  echo "<select name=\"country_id\" onchange=\"this.form.submit()\"><option value=\"\">".JText::_('TE_SELECT_COUNTRY')."</option>" ;
  echo JHtml::_('select.options', $this->GetCountryList(), 'value', 'text', $item->country_id);
  echo "</select></form></td>" ;
  // echo "<td><a href=\"".JRoute::_('index.php?option=com_travelentity&task=rawlinks.updatecountry&link_id='.$item->link_id."&country_id=".$item->country_id)."\">".$this->GetModel()->labs['update_label']."</a></td>" ;
  echo "<td><a href=\"".JRoute::_('index.php?option=com_travelentity&task=rawlinks.dellink&link_id='.$item->link_id)."\">".$this->GetModel()->labs['del_label']."</a></td>" ;
  echo "</tr>" ;
 endforeach;

 echo "</table>" ;

 echo $this->pagination->getListFooter(); 

}
else echo $this->GetModel()->labs['login_rawlinks_label'] ;



