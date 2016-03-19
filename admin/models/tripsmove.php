<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelTripsMove extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.tripsmove', 'tripsmove', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.tripsmove.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('trip_id')) 
      {
       $data->set('trip_id', JRequest::getInt('trip_id', $app->getUserState('com_travelentity.tripsmoves.filter.trip_id')));
      }
    }
    return $data;
  }
 
  public function getTable($name = 'TripsMoves', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}