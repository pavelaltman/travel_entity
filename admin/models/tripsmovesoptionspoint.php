<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelTripsMovesOptionsPoint extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.tripsmovesoptionspoint', 'tripsmovesoptionspoint', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.tripsmovesoptionspoint.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('trip_move_option')) 
      {
       $data->set('trip_move_option', JRequest::getInt('trip_move_option', $app->getUserState('com_travelentity.tripsmovesoptionspoints.filter.trip_move_option')));
      }
    }
    return $data;
  }
 
  public function getTable($name = 'TripsMovesOptionsPoints', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}