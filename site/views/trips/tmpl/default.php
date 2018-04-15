<?php
// No direct access to this file
defined('_JEXEC') or die;

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";

$labs=TravelEntityGetTextLabels();

echo "<table width=\"100%\">" ;

foreach($this->items as $i => $item): 
  echo "<tr>" ;
  echo "<td> ".$item->trip_name."</td>" ;
  echo "<td>".$item->trip_start_date."</td>"; 
  echo "<td><a href=\"".JRoute::_('index.php? option=com_travelentity&view=trips&id='.$item->trip_id)."\">".$labs['trip_plan_label']."</a></td>" ;
  echo "<td><a href=\"".JRoute::_('index.php? option=com_travelentity&view=trips&page=photos&id='.$item->trip_id)."\">".$labs['trip_photos_label']."</a></td>" ;
  echo "</tr>" ;
endforeach;

echo "</table>" ;

echo $this->pagination->getListFooter(); 


