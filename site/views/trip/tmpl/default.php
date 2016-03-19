<?php
// No direct access to this file
defined('_JEXEC') or die;

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";



//print_r($this->item);
?>

<b><?php echo $this->item['data']['trip_name']; ?></b></br>
<p><?php echo $this->item['data']['trip_descr']; ?></p></br>
<p><?php echo $this->item['labs']['stage_label'].": ".$this->item['data']['trip_stage_name']; ?></br>
<?php echo $this->item['labs']['start_date_label'].": ".$this->item['data']['trip_start_date']; ?></br></p>
<p><?php echo $this->item['data']['trip_stage_points_label']; ?></br>

<?php

if ($this->item['data']['trip_stage_id']==1)  // список точек
{
 echo "<table width=\"100%\">" ;

 foreach($this->item['points_arr'] as $i => $pointitem): 
  echo "<tr>" ;
  echo "<td>".GetPointNameLink($pointitem)."</td>" ;
  echo "<td>".$pointitem['point_subtype_name'.$glt]."</td>"; 
  echo "<td>".$pointitem['subregion_name'.$glt]."</td>"; 
  echo "<td>".$pointitem['region_name'.$glt]."</td>"; 
  echo "<td>".$pointitem['country_name'.$glt]."</td>"; 
  echo "</tr>" ;
 endforeach;

 echo "</table>" ;
}
elseif ($this->item['data']['trip_stage_id']==2)   // план - последовательность точек с датами
{
 echo "<table width=\"100%\">" ;

 $prev_day=0;
 foreach($this->item['points_plan_arr'] as $i => $pointitem): 
  echo "<tr>" ;
  echo "<td>".($pointitem['day_number']==$prev_day ? "" : $pointitem['day_number'])."</td>"; 
  echo "<td>".($pointitem['day_number']==$prev_day ? "" : $pointitem['a_date'])."</td>"; 
  echo "<td>".$pointitem['a_time']."-".$pointitem['d_time']."</td>"; 
  echo "<td>".GetPointNameLink($pointitem)."</td>" ;
  echo "<td>".$pointitem['point_comment']."</td>"; 
  echo "</tr>" ;
  $prev_day=$pointitem['day_number'];
 endforeach;

 echo "</table>" ;
}
elseif ($this->item['data']['trip_stage_id']==3)   // план - по местам проживания и перемещениям
{
// echo "<div id=\"triptable\">" 
 echo "<table  width=\"100%\" border=\"1\" bordercolor=\"red\" rules=\"all\" cellpadding=\"2\" cellspacing=\"3\">" ;

 echo "<tr>" ;
 echo "<th>".$this->item['labs']['trip_points_number_label']."</th>"; 
 echo "<th>".$this->item['labs']['trip_points_dates_label']."</th>"; 
 echo "<th>".$this->item['labs']['trip_points_place_label']."</th>"; 
 echo "<th>".$this->item['labs']['trip_points_nights_label']."</th>"; 
 echo "<th>".$this->item['labs']['trip_points_comment_label']."</th>"; 
 echo "</tr>" ;


 echo "<tr>" ;
 echo "<td></td>"; 
 echo "<td></td>"; 
 echo "<td></td>"; 
 echo "<td></td>"; 
 echo "<td></td>"; 
 echo "<td rowspan=\"2\">".$this->item['stay_points_arr'][0]['from_move']->GetTitle()."</td> <td rowspan=\"2\">".$this->item['stay_points_arr'][0]['from_move']->GetOptionsTitle()."</td> </tr>" ;
 echo "</tr>" ;

 foreach($this->item['stay_points_arr'] as $i => $pointitem): 
  echo "<tr>" ;
  echo "<td rowspan=\"3\">".$pointitem['stay_point_order']."</td>"; 
  echo "<td rowspan=\"3\">".$pointitem['a_date']." - ".$pointitem['d_date']."</td>"; 
  echo "<td rowspan=\"3\"><a href=\"".JRoute::_('index.php? option=com_travelentity&Itemid='.GetPointsMenuItem().'&id='.$pointitem['stay_point_id'])."\">".$pointitem['point_name']."</a></td>" ;
  echo "<td rowspan=\"3\">".$pointitem['nights_to_stay']."</td>"; 
  echo "<td rowspan=\"3\">".$pointitem['stay_point_comment']."</td>"; 
  echo "<tr> <td>".$pointitem['here_move']->GetTitle()."</td> <td>".$pointitem['here_move']->GetOptionsTitle()."</td> </tr>" ;
  echo "<tr> <td rowspan=\"2\">".$pointitem['to_move']->GetTitle()."</td> <td rowspan=\"2\">".$pointitem['to_move']->GetOptionsTitle()."</td> </tr>" ;
  echo "</tr>" ;
 endforeach;

 echo "</table>" ;
// echo "</div>" ;
}

?>


