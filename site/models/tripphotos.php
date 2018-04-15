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

      
      // Заполняем массив фотографий
      $db = JFactory::getDBO();
      $points_query = new TEQuery($db) ;
      $points_query->select('*');
      $points_query->from('#__te_photos');
      $points_query->where('photo_trip='.$id);
      $points_query->order('point_datetime');
      $db->setQuery($points_query);
      $this->item['photos_arr'] = $db->loadAssocList();
      
      // print_r($this->item['photos_arr']) ;
      
      // Заполняем мета-данные
      $document=&JFactory::getDocument();
      $document->setTitle($this->item['data']['trip_name']." - ".$this->item['labs']['sitename_label']);
    }
    return $this->item;
  }
}
?>