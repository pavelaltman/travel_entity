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
      if (!$data->get('point_id')) 
      {
       $data->set('point_id', JRequest::getInt('point_id', $app->getUserState('com_travelentity.pointlinkphotos.filter.point_id')));
      }
    }

    return $data;
  }
 
  public function getTable($name = 'PointLinkPhotos', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}