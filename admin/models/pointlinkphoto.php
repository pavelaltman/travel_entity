<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPointLinkPhoto extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    // Get the form.
    $form = $this->loadForm('com_travelentity.pointlinkphoto', 'pointlinkphoto', array('control' => 'jform', 'load_data' => $loadData));

    return $form;
  }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app = JFactory::getApplication();
    $data = $app->getUserState('com_travelentity.edit.pointlinkphoto.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('point_link_photo_id')) 
      {
       $data->set('link_photo_point', JRequest::getInt('link_photo_point', $app->getUserState('com_travelentity.pointlinkphotos.filter.link_photo_point')));
      }
    }

    return $data;
  }
 
  public function getTable($name = 'PointLinkPhotos', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}