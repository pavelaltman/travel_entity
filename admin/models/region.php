<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelRegion extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.region', 'region', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.region.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('region_country')) 
      {
       $data->set('region_country', JRequest::getInt('region_country', $app->getUserState('com_travelentity.regions.filter.region_country')));
      }
    }
    return $data;
  }
 
  public function getTable($name = 'Regions', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}