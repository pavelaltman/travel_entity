<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelTrip extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.trip', 'trip', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
  }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.trip.data', array());

    if(empty($data))
    {
     $data = $this->getItem();
    }

//    print_r($data) ;

    return $data;
  }
 
  public function getTable($name = 'Trips', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}