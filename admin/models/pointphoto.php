<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPointPhoto extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.pointphoto', 'pointphoto', array('control' => 'jform', 'load_data' => $loadData));
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