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
  echo "<td><a href=\"".JRoute::_('index.php?option=com_travelentity&task=rawlinks.dellink&link_id='.$item->link_id)."\">".$this->GetModel()->labs['del_label']."</a></td>" ;
  echo "</tr>" ;
 endforeach;

 echo "</table>" ;

 echo $this->pagination->getListFooter(); 

}
else echo $this->GetModel()->labs['login_rawlinks_label'] ;



