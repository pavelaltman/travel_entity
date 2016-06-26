<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPointPostPhoto extends JModelAdmin
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
       $data->set('photo_point', JRequest::getInt('point', $app->getUserState('com_travelentity.pointpostphotos.filter.point')));
      }
    }

    return $data;
  }
 
  public function getTable($name = 'PointPhotos', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}