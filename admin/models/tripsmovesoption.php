<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelTripsMovesOption extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.tripsmovesoption', 'tripsmovesoption', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.tripsmovesoption.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('trip_move')) 
      {
       $data->set('trip_move', JRequest::getInt('trip_move', $app->getUserState('com_travelentity.tripsmovesoptions.filter.trip_move')));
      }
    }
    return $data;
  }
 
  public function getTable($name = 'TripsMovesOptions', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}