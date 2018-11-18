<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPointPhoto extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.pointphoto', 'pointphoto', array('control' => 'jform', 'load_data' => $loadData));


    // building query for point posts list 
    $query = new TEQuery($db) ;
    $query->select('post_article_point_id as value');
    $query->from('#__te_points_posts');
    
    if ($point_id = $form->getData()['photo_point'])
        $query->where('post_point= '.$point_id);
        
    // $query->select('m.title as menutitle');
    // $query->join('LEFT', '#__menu AS m ON m.id = post_menuitem');
        
    $query->select('c.title as photo_post');
    $query->join('LEFT', '#__content AS c ON c.id = post_article');
        
    $qtext="(select NULL AS value, 'NULL' as photo_post from dollsfun_points.#__te_points_posts) union (".$query->__toString().")" ;
    
    // print_r($form->getData()) ;
    
    $form->setFieldAttribute('photo_post',"query",$qtext) ;
    
    return $form;
  }
 
  protected function loadFormData()
  {
    $app = JFactory::getApplication();
    $data = $app->getUserState('com_travelentity.edit.pointphoto.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('photo_point')) 
      {
       $data->set('photo_point', JRequest::getInt('point', $app->getUserState('com_travelentity.pointphotos.filter.point')));
      }
    }
   
    return $data;
  }
 
  public function getTable($name = 'PointPhotos', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
  
  protected function prepareTable($form)
  {
  	$path=JURI::root()."/images/".$form->photo_path ;
  	$exif_arr=exif_read_data($path) ; 
  	// $arrstring=print_r($exif_arr['DateTimeOriginal'],TRUE);
  	// JFactory::getApplication()->enqueueMessage($arrstring);
  	$form->point_datetime=$exif_arr['DateTimeOriginal'] ;
  }
}