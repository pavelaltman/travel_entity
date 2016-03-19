<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');
jimport('joomla.application.component.modelitem');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."TEMoveOption.php";


class TravelEntityModelTrip extends JModelItem
{
  protected $item;


  public function getItem()
  {
    if (!isset($this->item)) {
      $id = JRequest::getInt('id');
 
      // получаем текстовые метки
      $this->item['labs']=TravelEntityGetTextLabels();

      // получаем данные о поездке
      $this->item['data']=TravelEntityGetTripDataById($id) ;

      // Заполняем массив точек поездки
      if ($this->item['data']['trip_stage_id']==1)     // список точек
      {
       $db = JFactory::getDBO();
       $points_query = new TEQuery($db) ;
       $points_query->select('*');
       $points_query->from('#__te_points_trips pptt,#__te_points p,#__te_point_subtypes pst,#__te_point_types pt,#__te_point_classes pcl,#__te_subregions sr,#__te_regions r,#__te_countries co,#__te_settlements setl');
       $points_query->where('pptt.point_id=p.point_id AND p.point_settlement=setl.settlement_id AND r.region_country=co.country_id AND r.region_id=sr.subregion_region AND setl.settlement_subregion=sr.subregion_id AND pt.point_class=pcl.point_class_id AND pst.point_type=pt.point_type_id AND p.point_subtype=pst.point_subtype_id');
       $db->setQuery($points_query); 
       $this->item['points_arr'] = $db->loadAssocList();
      }
      elseif ($this->item['data']['trip_stage_id']==2)     // план - последовательность точек с датами
      {
       $db = JFactory::getDBO();
       $points_query = new TEQuery($db) ;
       $points_query->select('*, date_format(arrival_date,\'%d.%m\') as a_date, time_format(arrival_date,\'%H:%i\') as a_time, time_format(departure_date,\'%H:%i\') as d_time');
       $points_query->from('#__te_points_trips_plan pptt,#__te_points p,#__te_point_subtypes pst,#__te_point_types pt,#__te_point_classes pcl,#__te_subregions sr,#__te_regions r,#__te_countries co,#__te_region_names rn,#__te_settlements setl');
       $points_query->where('pptt.point_id=p.point_id AND p.point_settlement=setl.settlement_id AND rn.country_id=co.country_id AND r.region_country=co.country_id AND r.region_id=sr.subregion_region AND setl.settlement_subregion=sr.subregion_id AND pt.point_class=pcl.point_class_id AND pst.point_type=pt.point_type_id AND p.point_subtype=pst.point_subtype_id');
       $points_query->order('point_order') ;
       $db->setQuery($points_query); 
       $this->item['points_plan_arr'] = $db->loadAssocList();
      }
      elseif ($this->item['data']['trip_stage_id']==3)     // план - по местам проживания и перемещениям 
      {
       $db = JFactory::getDBO();
       $points_query = new TEQuery($db) ;
       $points_query->select('*, date_format(departure_date,\'%d.%m.%y\') as d_date, date_format(arrival_date,\'%d.%m.%y\') as a_date, time_format(arrival_date,\'%H:%i\') as a_time, time_format(departure_date,\'%H:%i\') as d_time');
       $points_query->from('#__te_trips_stay_points pptt,#__te_points p,#__te_point_subtypes pst,#__te_point_types pt,#__te_point_classes pcl,#__te_subregions sr,#__te_regions r,#__te_countries co,#__te_settlements setl');
       $points_query->where('pptt.stay_point_id=p.point_id AND p.point_settlement=setl.settlement_id AND r.region_country=co.country_id AND r.region_id=sr.subregion_region AND setl.settlement_subregion=sr.subregion_id AND pt.point_class=pcl.point_class_id AND pst.point_type=pt.point_type_id AND p.point_subtype=pst.point_subtype_id AND trip_id='.$this->item['data']['trip_id']);
       $points_query->order('stay_point_order') ;
       $db->setQuery($points_query); 
       $this->item['stay_points_arr'] = $db->loadAssocList();

       foreach($this->item['stay_points_arr'] as $i => $pointitem) 
       {
        $this->item['stay_points_arr'][$i]['from_move'] = new TEMoveOption($this->item['data']['trip_id'],$pointitem['trip_stay_point_id'],'from') ; 
        $this->item['stay_points_arr'][$i]['here_move'] = new TEMoveOption($this->item['data']['trip_id'],$pointitem['trip_stay_point_id'],'here') ; 
        $this->item['stay_points_arr'][$i]['to_move'] = new TEMoveOption($this->item['data']['trip_id'],$pointitem['trip_stay_point_id'],'to') ; 
       }
      }

      // Заполняем мета-данные
      $document=&JFactory::getDocument();
      $document->setTitle($this->item['data']['trip_name']." - ".$this->item['labs']['sitename_label']);
      // $document->setMetaData('description',$this->item['data']['point_descr']);



      // $style =  '.triptable { border: 1px black ; }' ;
      // $document->addStyleDeclaration( $style );

    }
    return $this->item;
  }
}
?>