<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');

jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."temap".DS."TEMap.php";


abstract class TravelEntityModelLItem extends JModelList
{
  public $item, $class_id, $country_id, $type_id, $region_id, $show_list, $all_want_been_arr, $sstr, $fstr,$wstr ;

  protected $maps, $all_items, $query ;
  function &GetMaps() { return $this->maps ; }
  function CheckMap($mapname) { return isset($this->maps) ? $this->maps->CheckMap($mapname) : 0 ; }

  public abstract function getItem() ;


  public function SetIds($_class_id=0, $_country_id=0, $_type_id=0, $_region_id=0)
  {
   global $glt ;

   $this->class_id=$_class_id;
   $this->country_id=$_country_id;
   $this->type_id=$_type_id;
   $this->region_id=$_region_id;

   // print_r($this) ;
   
   // получаем текстовые метки
   $this->item['labs']=TravelEntityGetTextLabels();

   // получаем данные об айтеме
   $this->item['data']=TravelEntityGetAllCountryDataById($this->class_id,$this->country_id,$this->type_id,$this->region_id) ;

   // получаем описание
   $this->item['descr']=TravelEntityGetDescr($this->class_id,$this->country_id,$this->type_id,$this->region_id) ;

   // переключатель все-хочу-был и массив для него
   {
    $this->user =& JFactory::getUser();

    if ($this->user-id)
    {
     $this->all_want_been=1 ;

     $session = JFactory::getSession();
     $new_awb = $session->get('all_want_been') ;
     if ($new_awb)
       $this->all_want_been=$new_awb ;

     if ($this->all_want_been==2) // want
     {
      $this->want_grade=2 ; // по умолчанию видим все что хотим начиная с "возможно хочу" 

      $new_want_grade=$session->get('want_grade') ;
      if ($new_want_grade)
        $this->want_grade=$new_want_grade ;

      // массив объектов для переключателя очень хочу-хочу-возможно хочу
      $db = JFactory::getDBO();
      $query = new TEQuery($db) ;
      $query->select('grade_id as value, grade_name_before'.$glt.' as text');
      $query->from('#__te_grades');
      $query->where('grade_id>1');
      $db->setQuery($query) ;
      $this->want_grade_arr=$db->loadObjectList() ;
     }

     // массив объектов для переключателя все-хочу-был-неоцененные
     $db = JFactory::getDBO();
     $query = new TEQuery($db) ;
     $query->select('*');
     $query->from('#__te_all_want_been');
     $db->setQuery($query) ;
     $this->all_want_been_arr=$db->loadObjectList() ;
    }
   }


   $this->sstr='point_name, point_descr, country_name'.$glt ;

   $this->fstr='#__te_points as p' ;  
   $this->fstr.=' JOIN #__te_point_subtypes as pst ON p.point_subtype=pst.point_subtype_id' ;
   $this->fstr.=' JOIN #__te_point_types as pt ON pst.point_type=pt.point_type_id' ;
   $this->fstr.=' JOIN #__te_point_classes as pcl ON pt.point_class=pcl.point_class_id' ;
   $this->fstr.=' JOIN #__te_settlements as setl ON p.point_settlement=setl.settlement_id' ;   
   $this->fstr.=' JOIN #__te_subregions as sr ON setl.settlement_subregion=sr.subregion_id' ;   
   $this->fstr.=' JOIN #__te_regions as r ON r.region_id=sr.subregion_region' ;
   $this->fstr.=' JOIN #__te_countries as co ON r.region_country=co.country_id' ;

   $this->wstr='' ;
   if ($this->class_id)     add_wstr($this->wstr,'pt.point_class='.$this->class_id) ;
   if ($this->country_id)   add_wstr($this->wstr,'r.region_country='.$this->country_id) ;  
   if ($this->type_id)      add_wstr($this->wstr,'pst.point_type='.$this->type_id) ;  
   if ($this->region_id)    add_wstr($this->wstr,'sr.subregion_region='.$this->region_id) ;  

   if ($this->all_want_been>1 && $this->all_want_been<4 && $this->user->id)
   {
    $this->fstr .= ' JOIN #__te_grades_users gu ON p.point_id=gu.grade_point_id AND gu.user_id='.$this->user->id.' AND gu.before_after='.($this->all_want_been-1).' AND gu.grade_id>1' ;
    if ($this->all_want_been==2)
      add_wstr($this->wstr,'gu.grade_id>='.$this->want_grade) ;
   }
   if ($this->all_want_been==4 && $this->user->id) // неоцененные точки
   {
    $this->fstr .= ' LEFT JOIN #__te_grades_users AS gu ON gu.grade_point_id=p.point_id AND gu.user_id='.$this->user->id ;
    add_wstr($this->wstr,'gu.grade_id is NULL') ;
   }


   add_wstr($this->wstr,'length(point_name'.$glt.')>0') ;

   $this->GetItems() ;


   // Создаем массив для подсписков, заполняется в наследуемых классах
   $this->item['sublists']=array() ;

   $this->SetBreadCrumbs() ;
   $this->show_list=0 ;

   // Заполняем мета-данные
   $document=&JFactory::getDocument();
   $document->setTitle($this->GetOwnTitle()." - ".$this->item['labs']['sitename_label']);
   // $document->setMetaData('description',$this->item['data']['point_descr']);
  }

  public function SetBreadCrumbs()
  {
   $this->item['breadcrumbs']=array() ;

   $r0=0 ;
   $r1=0 ;
   if ($this->class_id && ($this->country_id || $this->type_id))
   {
    $this->item['breadcrumbs'][$r0][0]['link']=$this->GetRoute($this->class_id) ;
    $this->item['breadcrumbs'][$r0][0]['link_text']=$this->GetTitle($this->class_id) ;
    $r0=$r0+1 ;
   } 

   if ($this->country_id && ($this->region_id || $this->type_id))
   {
    $this->item['breadcrumbs'][$r1][1]['link']=$this->GetRoute($this->class_id,$this->country_id) ;
    $this->item['breadcrumbs'][$r1][1]['link_text']=$this->GetTitle($this->class_id,$this->country_id) ;
    $r1=$r1+1 ;
   } 

   if ($this->type_id && ($this->country_id || $this->region_id))
   {
    $this->item['breadcrumbs'][$r0][0]['link']=$this->GetRoute($this->class_id,0,$this->type_id) ;
    $this->item['breadcrumbs'][$r0][0]['link_text']=$this->GetTitle($this->class_id,0,$this->type_id) ;
    $r0=$r0+1 ;
   }

   if ($this->type_id && $this->region_id)
   {
    $this->item['breadcrumbs'][$r0][0]['link']=$this->GetRoute($this->class_id,$this->country_id,$this->type_id) ;
    $this->item['breadcrumbs'][$r0][0]['link_text']=$this->GetTitle($this->class_id,$this->country_id,$this->type_id) ;
    $r0=$r0+1 ;

    $this->item['breadcrumbs'][$r1][1]['link']=$this->GetRoute($this->class_id,$this->country_id,0,$this->region_id) ;
    $this->item['breadcrumbs'][$r1][1]['link_text']=$this->GetTitle($this->class_id,$this->country_id,0,$this->region_id) ;
    $r1=$r1+1 ;
   } 
  }


  public function GetClassId()   { return $this->class_id; }
  public function GetCountryId() { return $this->country_id; }
  public function GetTypeId()    { return $this->type_id; }
  public function GetRegionId()  { return $this->region_id; }

  public function SetPointsArr()
  {
   $this->show_list=1 ;
  }

  protected function getListQuery()
  {
   $db = JFactory::getDBO();
   $query = new TEQuery($db) ;
 
   $query->select('*');
   $query->from($this->fstr);

   if (strlen($this->wstr)) 
      $query->where($this->wstr);

   $this->all_items=$this->_getList($query) ;

   return $query ;
  }

  public function SetPointsMap()
  {
   $this->maps= new TEMapSystem ;

   $this->marker_array=array('/castle1.png','/castle2.png','/castle3.png') ; 

   foreach($this->all_items as $i => $point) 
   {
    $marker= strlen($m=$point->point_subtype_marker) ? $m : strlen($m=$point->point_type_marker) ? $m : strlen($m=$point->point_class_marker) ? $m : 'default' ;


    if ($this->user->id)
    {
     if ($this->all_want_been==1) // все
       $marker.='1.png' ;
     else if ($this->all_want_been==2) // хочу
     {
      if ($point->grade_id==2)
       $marker.='3.png' ;
      if ($point->grade_id==3)
       $marker.='2.png' ;
      if ($point->grade_id==4)
       $marker.='1.png' ;
     }
     else if ($this->all_want_been==3) // был
     {
      if ($point->grade_id==1 || $point->grade_id==2)
       $marker.='3.png' ;
      if ($point->grade_id==3)
       $marker.='2.png' ;
      if ($point->grade_id==4)
       $marker.='1.png' ;
     }
     else if ($this->all_want_been==4) // был
       $marker.='1.png' ;
    }
    else
       $marker.='1.png';
 
    $this->all_items[$i]->marker='/'.$marker ;

    $pi= (array) $point ;
    $this->all_items[$i]->point_link=GetPointNameLink($pi) ;
   }

   $this->maps->AddArrayMap('pointsmap',$this->all_items,'point_lat','point_lon','point_name','point_link','','marker') ;
  }

  public function AddSubList($sstr,$label,$orderstr="",$flat=0)
  {
   $sublist_count=count($this->item['sublists']);

   $db = JFactory::getDBO();
   $query = new TEQuery($db) ;

   $query->select($sstr);
   $query->from($this->fstr);
   if (strlen($this->wstr))
     $query->where($this->wstr);
   if (strlen($orderstr))
     $query->order($orderstr);

   $db->setQuery($query); 

   $this->item['sublists'][$sublist_count]=array() ;
   $this->item['sublists'][$sublist_count]['list'] = $db->loadAssocList();
   $this->item['sublists'][$sublist_count]['label'] = $label ;
   $this->item['sublists'][$sublist_count]['flat'] = $flat ;
  }

  public function GetTitle($_class_id=0, $_country_id=0, $_type_id=0, $_region_id=0, $alt_array=null)
  {
   global $glt ;


   $title='' ;
   if ($_type_id)
      if ($this->type_id)
       $title=$this->item['data']['point_type_name_pl'.$glt];
      else
       $title=$alt_array['point_type_name_pl'.$glt];
   else
      if ($_class_id)
        if ($this->class_id)
          $title=$this->item['data']['point_class_name_pl'.$glt];
        else
          $title=$alt_array['point_class_name_pl'.$glt];
 
   if (strlen($title))
    $title= $title.' ' ;

   if ($_region_id)
      if ($this->region_id)
         $title= $title.$this->item['data'][strlen($title) ? 'region_name_rod'.$glt : 'region_name'.$glt];
      else
         $title= $title.$alt_array[strlen($title) ? 'region_name_rod'.$glt : 'region_name'.$glt];
   elseif ($_country_id)
      if ($this->country_id)
         $title= $title.$this->item['data'][strlen($title) ? 'country_name_rod'.$glt : 'country_name'.$glt];
      else
         $title= $title.$alt_array[strlen($title) ? 'country_name_rod'.$glt : 'country_name'.$glt];

   if (!strlen($title))
     $title=$this->item['labs']['allpoints_label'];

   return $title ;
  }

  public function GetOwnTitle()
  {
   return $this->GetTitle($this->class_id,$this->country_id,$this->type_id,$this->region_id) ;
  }


  public function GetViewName($_class_id, $_country_id=0, $_type_id=0, $_region_id=0)
  {
   $view_str='' ;

   if ($_class_id)
    $view_str='pointclass' ;

   if ($_country_id)
    $view_str='country' ;

   if ($_type_id)
    if ($_country_id)
       $view_str='pointtype' ;
    else
       $view_str='classtype' ;

   if ($_region_id)
    if ($_type_id)
      $view_str='regiontype' ;
    else
      $view_str='region' ;

   if (!strlen($view_str))
       $view_str='points' ;

   return $view_str ;
  }

  public function GetOwnViewName()
  {
   return $this->GetViewName($this->class_id,$this->country_id,$this->type_id,$this->region_id) ;
  }

  public function GetSourceRoute($_class_id, $_country_id=0, $_type_id=0, $_region_id=0, $viewname='')
  {
   global $glt ;

   $route_str='index.php?option=com_travelentity' ;

   if ($_class_id)
   {
    $route_str= $route_str.'&class_id='.$_class_id ;
   }

   if ($_country_id)
   {
    $route_str= $route_str.'&country_id='.$_country_id ;
   }

   if ($_type_id)
   {
    $route_str= $route_str.'&type_id='.$_type_id ;
   }

   if ($_region_id)
   {
    $route_str= $route_str.'&region_id='.$_region_id ;
   }


   $route_str= $route_str."&view=".(strlen($viewname) ? $viewname : $this->GetViewName($_class_id, $_country_id, $_type_id, $_region_id)). GetPointsMenuItem() ;
   return $route_str ;
  }

  public function GetRoute($_class_id, $_country_id=0, $_type_id=0, $_region_id=0)
  {
   return JRoute::_($this->GetSourceRoute($_class_id, $_country_id, $_type_id, $_region_id)) ;
  }

  public function GetOwnRoute()
  {
   return $this->GetRoute($this->class_id,$this->country_id,$this->type_id,$this->region_id) ;
  }

  public function GetOwnSourceRoute()
  {
   return $this->GetSourceRoute($this->class_id,$this->country_id,$this->type_id,$this->region_id) ;
  }

}

