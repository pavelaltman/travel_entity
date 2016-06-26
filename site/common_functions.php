<?php
defined('_JEXEC') or die('Restricted access');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

function GetPointsMenuItem()
{
 global $glt ;
 return strlen($glt) ? '2151' : '765' ;
}

function GetPointNameRoute($point_id)
{
 return JRoute::_('index.php? option=com_travelentity&Itemid='.GetPointsMenuItem().'&id='.$point_id) ;
}

function GetPointNameLink(&$pointitem)
{
 global $glt ;
 return "<a href=\"".GetPointNameRoute($pointitem['point_id'])."\">".$pointitem['point_name'.$glt]."</a>" ;
}


function TravelEntityGetTextLabels()
{
 global $glt ;

 $db =& JFactory::getDBO();
 $query = new TEQuery($db) ;

 $query->select('*');
 $query->from('#__te_textlabels');
 $query->where('lang_tag=\''. (strlen($glt) ? $glt : 'ru') . '\'');

 $db->setQuery($query);
 return $db->loadAssoc();
}

// получить данные о точке, только те, что нужны для построения url 
function TravelEntityGetPointDataById($point_id)
{
 $db =& JFactory::getDBO();
 $query = new TEQuery($db) ;

 $query->select('*');
 $query->from('#__te_points p,#__te_point_subtypes pst,#__te_point_types pt,#__te_point_classes pcl');
 $query->where('pt.point_class=pcl.point_class_id AND pst.point_type=pt.point_type_id AND p.point_subtype=pst.point_subtype_id AND p.point_id = '. (int) $point_id);

 $db->setQuery($query);
 return $db->loadAssoc();
}

// получить данные о точке, все, что нужны для страницы точки, которые можно получить в один запрос 
function TravelEntityGetAllPointDataById($point_id)
{
 $db =& JFactory::getDBO();
 $query = new TEQuery($db) ;

 $query->select('*');
 $query->from('#__te_points p,#__te_point_subtypes pst,#__te_point_types pt,#__te_point_classes pcl,#__te_subregions sr,#__te_regions r,#__te_countries co,#__te_settlements setl');
 $query->where('p.point_settlement=setl.settlement_id AND r.region_country=co.country_id AND r.region_id=sr.subregion_region AND setl.settlement_subregion=sr.subregion_id AND pt.point_class=pcl.point_class_id AND pst.point_type=pt.point_type_id AND p.point_subtype=pst.point_subtype_id AND p.point_id = '. (int) $point_id);

 $db->setQuery($query);
 return $db->loadAssoc();
}

// получить данные о точке по алиасу (при разборе url'а)
function TravelEntityGetPointDataByAlias($point_alias)
{
 $db =& JFactory::getDBO();
 $query = new TEQuery($db) ;

 $query->select('*');
 $query->from('#__te_points p,#__te_point_subtypes pst,#__te_point_types pt,#__te_point_classes pcl');
 $query->where('pt.point_class=pcl.point_class_id AND pst.point_type=pt.point_type_id AND p.point_subtype=pst.point_subtype_id AND p.point_alias='.$db->quote( $db->getEscaped( $point_alias ) ));

 //print_r($query->dump()) ;

 $db->setQuery($query);
 $data=$db->loadAssoc();
 return $data ; 
}


// получить все данные о поездке
function TravelEntityGetTripDataById($trip_id)
{
 global $pdb ;

 $db = JFactory::getDBO();
 $query = new TEQuery($db) ;

 $query->select('*');
 $query->from($pdb.'#__te_trips t,#__te_trip_stages ts');
 $query->where('t.trip_stage=ts.trip_stage_id AND t.trip_id = '. (int) $trip_id);

 $db->setQuery($query);
 return $db->loadAssoc();
}


// получить данные о поездке по алиасу (при разборе url'а)
function TravelEntityGetTripDataByAlias($trip_alias)
{
 global $pdb ;

 $db =& JFactory::getDBO();
 $query = new TEQuery($db) ;

 $query->select('*');
 $query->from($pdb.'#__te_trips t');
 $query->where('t.trip_alias='.$db->quote( $db->getEscaped( $trip_alias ) ));

 $db->setQuery($query);
 $data=$db->loadAssoc();
 return $data ; 
}


// получить все данные о классе точек и стране
function TravelEntityGetAllCountryDataById($class_id,$country_id=0,$type_id=0,$region_id=0)
{
 $db =& JFactory::getDBO();
 $query = new TEQuery($db) ;

 $query->select('*');
 $query->from('#__te_points p,#__te_point_subtypes pst,#__te_point_types pt,#__te_point_classes pcl,#__te_settlements setl,#__te_subregions sr,#__te_regions r,#__te_countries co');
 $query->where(($country_id ? 'r.region_country='.$country_id.' AND ' : '').'r.region_id=sr.subregion_region AND p.point_settlement=setl.settlement_id AND setl.settlement_subregion=sr.subregion_id'.($class_id ? ' AND pt.point_class='.$class_id : '').' AND pst.point_type=pt.point_type_id AND p.point_subtype=pst.point_subtype_id  AND pt.point_class=pcl.point_class_id AND co.country_id=r.region_country'.($type_id ? ' AND pst.point_type='.$type_id : '').($region_id ? ' AND sr.subregion_region='.$region_id : ''));

 $db->setQuery($query);
 return $db->loadAssoc();
}

// получить данные о классе точек и стране для алиаса 
function TravelEntityGetCountryDataById($class_id,$country_id=0,$type_id=0,$region_id=0)
{
 $db = JFactory::getDBO();
 $arr = array() ;
 
 if ($class_id)
 {
  $query = new TEQuery($db) ;
  $query->select('point_class_alias_pl');
  $query->from('#__te_point_classes');
  $query->where('point_class_id='.$class_id);
  $db->setQuery($query);
  $arr['point_class_alias_pl']=$db->loadResult() ;
 }

 if ($country_id)
 {
  $query = new TEQuery($db) ;
  $query->select('country_alias');
  $query->from('#__te_countries');
  $query->where('country_id='.$country_id);
  $db->setQuery($query);
  $arr['country_alias']=$db->loadResult() ;
 }

 if ($type_id)
 {
  $query = new TEQuery($db) ;
  $query->select('point_type_alias');
  $query->from('#__te_point_types');
  $query->where('point_type_id='.$type_id);
  $db->setQuery($query);
  $arr['point_type_alias']=$db->loadResult() ;
 }

 if ($region_id)
 {
  $query = new TEQuery($db) ;
  $query->select('region_alias');
  $query->from('#__te_regions');
  $query->where('region_id='.$region_id);
  $db->setQuery($query);
  $arr['region_alias']=$db->loadResult() ;
 }

 return $arr ;
}


// получить данные о классе точек и стране по алиасам (при разборе url'а)
function TravelEntityGetCountryDataByAlias($class_id,$country_alias='',$type_alias='',$region_alias='')
{
 $db =& JFactory::getDBO();
 $query = new TEQuery($db) ;

 $query->select('*');
 $query->from('#__te_points p,#__te_point_subtypes pst,#__te_point_types pt,#__te_point_classes pcl,#__te_settlements setl,#__te_subregions sr,#__te_regions r,#__te_countries co');
 $wstr='r.region_country=co.country_id AND r.region_id=sr.subregion_region AND p.point_settlement=setl.settlement_id AND setl.settlement_subregion=sr.subregion_id'.($class_id ? ' AND pt.point_class='.$class_id : '').' AND pst.point_type=pt.point_type_id AND p.point_subtype=pst.point_subtype_id  AND pt.point_class=pcl.point_class_id'.(strlen($country_alias) ? ' AND co.country_alias='.$db->quote( $db->getEscaped($country_alias)) : '').(strlen($type_alias) ? ' AND point_type_alias='.$db->quote( $db->getEscaped($type_alias))   : '').(strlen($region_alias) ? ' AND region_alias='.$db->quote( $db->getEscaped($region_alias))   : '');
 $query->where($wstr) ;

 $db->setQuery($query);
 $data=$db->loadAssoc();
 //print_r($data) ;
 return $data ; 
}

// получить описание сочетания
function TravelEntityGetDescr($class_id,$country_id=0,$type_id=0,$region_id=0)
{
// print_r($class_id) ;
// print_r($country_id) ;
// print_r($type_id) ;

 $db =& JFactory::getDBO();
 $query = new TEQuery($db) ;

 $query->select('*');
 $query->from('#__te_class_type_country_region');
 $query->where('class_id='.$class_id.' AND country_id='.$country_id.' AND type_id='.$type_id.' AND region_id='.$region_id);

 $db->setQuery($query);
 return $db->loadAssoc();
}

// добавление условия в where- строку
function add_wstr(&$wstr,$new_str)
{
 if (strlen($wstr))
   $wstr.=' AND ' ;
 $wstr.= $new_str ;
}



