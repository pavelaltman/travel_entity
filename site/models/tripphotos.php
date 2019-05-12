<?php
// No direct access to this file
defined('_JEXEC') or die('Restricted access');
jimport('joomla.application.component.modelitem');

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";

class TravelEntityModelTripPhotos extends JModelItem
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

      
      // «аполн€ем массив фотографий
      $db = JFactory::getDBO();
      $points_query = new TEQuery($db) ;
      $points_query->select('p.*');
      $points_query->from('#__te_photos p');
      $points_query->where('photo_trip='.$id);

      $points_query->select('point_name'); $points_query->join('LEFT', '#__te_points ON point_id = photo_point');
      $points_query->join('LEFT', '#__te_points_posts ON post_article_point_id = photo_post');
      $points_query->select('m.title as menutitle, m.id as menuid'); $points_query->join('LEFT', '#__menu AS m ON m.id = post_menuitem');
      $points_query->select('c.title as articletitle, c.id as articleid'); $points_query->join('LEFT', '#__content AS c ON c.id = post_article');
      
      $points_query->order('photo_post,point_datetime');
      $db->setQuery($points_query);
      $this->item['photos_arr'] = $db->loadAssocList();
      
      // print_r($this->item['photos_arr']) ;
      
      // «аполн€ем мета-данные
      $document=&JFactory::getDocument();
      $document->setTitle($this->item['data']['trip_name']." - ".$this->item['labs']['sitename_label']);
      
      // —тили дл€ горизонтального расположени€ фото
      $style =  '.column {float: left; padding: 5px; }' ;
      $document->addStyleDeclaration( $style );
      $style =  '.row::after { content: ""; clear: both; display: table; }' ;
      $document->addStyleDeclaration( $style );
      
      $style =  'img {height: 180px; }' ;
      $document->addStyleDeclaration( $style );
      
    }
    return $this->item;
  }
}
?>