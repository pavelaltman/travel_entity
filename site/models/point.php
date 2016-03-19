<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');
jimport('joomla.application.component.modelitem');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."temap".DS."TEMap.php";

class TravelEntityModelPoint extends JModelItem
{
  protected $item;
  
  protected $maps ;
  function &GetMaps() { return $this->maps ; }
  function CheckMap($mapname) { return isset($this->maps) ? $this->maps->CheckMap($mapname) : 0 ; }

  public function getItem()
  {
    if (!isset($this->item)) {
      $id = JRequest::getInt('id');
 
      // получаем данные о точке, подтипе, типе, классе, территории и т д
      $this->item['data']=TravelEntityGetAllPointDataById($id) ;

      $this->maps= new TEMapSystem ;
      $this->maps->AddMap('localmap',$this->item['data']['point_lat'],$this->item['data']['point_lon'],17) ;

      // Заполняем массив ссылок точки - два вложенных массива: классов ссылок, а внутри ссылок данного класса
      $db = JFactory::getDBO();

      $link_class_query = new TEQuery($db) ;
      $link_class_query->select('distinct link_class_id,link_class_pre_label,link_class_link_label,link_class_post_label,link_class_sitelink,link_class_incl_point');
      $link_class_query->from('#__te_points_link_classes plc,#__te_points_links pl,#__te_points_link_types plt');
      $link_class_query->where('plc.link_class_id=plt.link_type_class AND pl.link_type=plt.link_type_id AND pl.link_point = '. (int) $id);
      $link_class_query->order('link_class_id');      
      $db->setQuery($link_class_query); 
      $this->item['link_class_arr'] = $db->loadAssocList();

      // print_r($this->item['link_class_arr']) ;
 
      foreach($this->item['link_class_arr'] as $i => $link_class)
      {
       $links_query = new TEQuery($db);
       $links_query->select('*');
       $links_query->from('#__te_points_links pl,#__te_points_link_types plt');
       $links_query->where('pl.link_type=plt.link_type_id AND pl.link_point = '. (int) $id.' AND plt.link_type_class = '. (int) $link_class['link_class_id']);
       $db->setQuery($links_query); 
       $this->item['link_class_arr'][$i]['links_arr'] = $db->loadAssocList();
      }

      // print_r($this->item['link_class_arr']) ;

      // Заполняем массив постов про точку
      $db = JFactory::getDBO();
      $posts_query = new TEQuery($db);
      $posts_query->select('cnt.id, cnt.catid, cnt.title, cats.title as ctitle, pp.post_menuitem');
      $posts_query->from('#__te_points_posts pp,#__content cnt,#__categories cats');
      $posts_query->where('cats.id=cnt.catid AND cnt.id=pp.post_article AND pp.post_point = '. (int) $id);
      $db->setQuery($posts_query); 
      $this->item['posts_arr'] = $db->loadAssocList();

      // Заполняем массив своих фотографий точки
      $db = JFactory::getDBO();
      $photos_query = new TEQuery($db) ;
      $photos_query->select('*');
      $photos_query->from('#__te_points_posts pp,#__te_photos ph');
      $photos_query->where('pp.post_article_point_id=ph.photo_article_point AND pp.post_point = '. (int) $id);
      $db->setQuery($photos_query); 
      $this->item['photos_arr'] = $db->loadAssocList();
      //print_r($this->item['photos_arr']) ;


      // Заполняем массив внешних фотографий точки
      $db = JFactory::getDBO();
      $link_photos_query = new TEQuery($db) ;
      $link_photos_query->select('*');
      $link_photos_query->from('#__te_points_link_photos plp,#__te_points_link_types lt,#__te_visual_content_types vct,#__te_points_link_classes plc');
      $link_photos_query->where('plc.link_class_id=lt.link_type_class AND vct.content_type_id=lt.link_type_content_type AND lt.link_type_id=plp.link_type AND plp.point_id = '. (int) $id);
      $link_photos_query->order('link_photo_order') ;
      $db->setQuery($link_photos_query); 
      $this->item['link_photos_arr'] = $db->loadAssocList();
      //print_r($this->item['link_photos_arr']) ;


      // получаем текстовые метки
      $this->item['labs']=TravelEntityGetTextLabels();

      // Заполняем мета-данные
      $document=&JFactory::getDocument();
      $document->setTitle($this->item['data']['point_name']." - ".$this->item['labs']['sitename_label']);
      $document->setMetaData('description',$this->item['data']['point_descr']);

      // Получаем ИД родительской точки если она есть
      if (!empty($this->item['data']['point_parent']))
      {
       $this->item['parent_data']=TravelEntityGetAllPointDataById($this->item['data']['point_parent']) ;
 
       // Поскольку есть родительская точка, могут быть сестры
       $db = JFactory::getDBO();
       $sisterpoints_query = new TEQuery($db) ;
       $sisterpoints_query->select('point_id,point_name,point_subtype_name'.$glt);
       $sisterpoints_query->from('#__te_points p,#__te_point_subtypes pst');
       $sisterpoints_query->where('p.point_subtype=pst.point_subtype_id AND p.point_parent = '. (int) $this->item['data']['point_parent'].' AND p.point_id != '. (int) $id);
       $db->setQuery($sisterpoints_query); 
       $this->item['sister_data'] = $db->loadAssocList();
      }

      // Заполняем массив ИДов, названий и подтипов дочерних точек
      $db = JFactory::getDBO();
      $childpoints_query = new TEQuery($db) ;
      $childpoints_query->select('point_id,point_name,point_subtype_name'.$glt);
      $childpoints_query->from('#__te_points p,#__te_point_subtypes pst');
      $childpoints_query->where('p.point_subtype=pst.point_subtype_id AND p.point_parent = '. (int) $id);
      $db->setQuery($childpoints_query); 
      $this->item['children_data'] = $db->loadAssocList();
    }

    {
     $user =& JFactory::getUser();
     $session = JFactory::getSession();
  
     $new_grade_id = $session->clear('grade_id') ;
     $new_before_after = $session->clear('before_after') ;

     if ($new_grade_id && $user->id)
     {
      // проверяем есть ли уже оценка
      $db = JFactory::getDBO();
      $grd_query = new TEQuery($db) ;
      $grd_query->select('*');
      $grd_query->from('#__te_grades_users gu');
      $grd_query->where('gu.user_id='.(int) $user->id.' AND gu.grade_point_id='.(int) $id);
      $db->setQuery($grd_query); 
      $old_id=$db->loadResult();

      if ($old_id)
      {
       // update
       $grd = new stdClass();
       $grd->grade_user_id = $old_id ;
       $grd->user_id = $user->id ;
       $grd->grade_point_id = $id ;
       $grd->grade_id = $new_grade_id ;
       $grd->before_after = $new_before_after ;
       $result = JFactory::getDbo()->updateObject(query_replace('#__te_grades_users'), $grd,'grade_user_id');
      }
      else
      {
       // insert
       $grd = new stdClass();
       $grd->user_id = $user->id ;
       $grd->grade_point_id = $id ;
       $grd->grade_id = $new_grade_id ;
       $grd->before_after = $new_before_after ;
       $result = JFactory::getDbo()->insertObject(query_replace('#__te_grades_users'), $grd);
      }
     }


     // получаем две (до и после) оценки данным юзером данной точки
     for ($j=1 ; $j<=2 ; $j++)
     {
      $db = JFactory::getDBO();
      $grade_query = new TEQuery($db) ;
      $grade_query->select('*');
      $grade_query->from('#__te_grades g, #__te_grades_users gu');
      $grade_query->where('gu.grade_id=g.grade_id AND gu.user_id='.(int) $user->id.' AND gu.grade_point_id='.(int) $id.' AND gu.before_after='.(int) $j);
      $db->setQuery($grade_query); 
 
      $this->item['usergrade'][$j] = $db->loadAssoc();
     }


     // получаем массив всех возможных оценок
     $db = JFactory::getDBO();
     $agrade_query = new TEQuery($db) ;
     $agrade_query->select('*');
     $agrade_query->from('#__te_grades g');
     $db->setQuery($agrade_query); 
     $this->item['gradeslist'] = $db->loadAssocList();

     $this->item['username']=$user->name ;
    }

    return $this->item;
  }
}
?>