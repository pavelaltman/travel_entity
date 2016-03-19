<?php
// No direct access to this file
defined('_JEXEC') or die;

echo "<table width=\"100%\">" ;

foreach($this->items as $i => $item): 
  echo "<tr>" ;
  echo "<td><a href=\"".JRoute::_('index.php? option=com_travelentity&view=trips&id='.$item->trip_id)."\">".$item->trip_name."</a></td>" ;
  echo "<td>".$item->trip_stage_name."</td>"; 
  echo "<td>".$item->trip_start_date."</td>"; 
  echo "</tr>" ;
endforeach;

echo "</table>" ;

echo $this->pagination->getListFooter(); 


