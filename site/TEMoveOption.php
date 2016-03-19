<?php
defined('_JEXEC') or die('Restricted access');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";

class TEMoveOption
{
 protected $arr ;

 public function LoadFromStayPoint($trip_id, $stay_point_id, $from_here_to)
 {
        $db = JFactory::getDBO();
        $query = new TEQuery($db) ;
        $query->select('trip_move_id,sspps.settlement_name as start_point,espps.settlement_name as end_point');
        $query->from('#__te_trips_moves as tm');
        $query->leftJoin('#__te_trips_stay_points AS ssp ON tm.trip_move_start_stay_point = ssp.trip_stay_point_id');
        $query->leftJoin('#__te_trips_stay_points AS esp ON tm.trip_move_end_stay_point = esp.trip_stay_point_id');
        $query->leftJoin('#__te_points AS sspp ON ssp.stay_point_id=sspp.point_id');
        $query->leftJoin('#__te_settlements AS sspps ON sspp.point_settlement=sspps.settlement_id');
        $query->leftJoin('#__te_points AS espp ON esp.stay_point_id=espp.point_id');
        $query->leftJoin('#__te_settlements AS espps ON espp.point_settlement=espps.settlement_id');
        $query->where('tm.trip_id='.$trip_id);
 
        if ($from_here_to=='from')
          $query->where('tm.trip_move_end_stay_point='.$stay_point_id.' AND tm.trip_move_start_stay_point!='.$stay_point_id);
        else if ($from_here_to=='here')
          $query->where('tm.trip_move_end_stay_point='.$stay_point_id.' AND tm.trip_move_start_stay_point='.$stay_point_id);
        else if ($from_here_to=='to')
          $query->where('tm.trip_move_end_stay_point!='.$stay_point_id.' AND tm.trip_move_start_stay_point='.$stay_point_id);

        $db->setQuery($query); 
        $this->arr = $db->loadAssoc();

        // для загруженного "мува" загружаем список опшнов
        $db = JFactory::getDBO();
        $o_query = new TEQuery($db) ;
        $o_query->select('*');
        $o_query->from('#__te_trips_moves_options');
        $o_query->where('trip_move='.$this->arr['trip_move_id']);
        $db->setQuery($o_query); 
        $this->arr['options'] = $db->loadAssocList();

        // для каждого опшна загружаем список точек 
        foreach($this->arr['options'] as $i => $option)
        {
         $db = JFactory::getDBO();
         $p_query = new TEQuery($db) ;
         $p_query->select('point_id,point_name');
         $p_query->from('#__te_trips_moves_options_points,#__te_points');
         $p_query->where('option_point_id=point_id AND trip_move_option='.$option['trip_move_option_id']);
         $db->setQuery($p_query); 
         $this->arr['options'][$i]['points'] = $db->loadAssocList();
        }

 }

 function __construct($trip_id, $stay_point_id, $from_here_to)
 {
  $this->LoadFromStayPoint($trip_id, $stay_point_id, $from_here_to) ;
 }

 public function GetTitle()
 {
  return $this->arr['start_point']." -> ".$this->arr['end_point'] ;
 }

 public function GetOptionsTitle()
 {
  $rstr="" ;

  foreach($this->arr['options'] as $i => $option) 
  {
   $rstr=$rstr.$option['trip_move_option_comment'] ;
   $cnt=0 ;
   foreach($option['points'] as $j => $point)
   {
    if ($cnt) $rstr=$rstr.", " ;
    else $rstr=$rstr.": " ;
    $cnt=$cnt+1 ;

    $rstr=$rstr.GetPointNameLink($point) ;
   }
   $rstr=$rstr."<br/>" ;
  }

  return $rstr ;
 }
}
