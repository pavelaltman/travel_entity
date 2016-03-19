<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelSubRegion extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.subregion', 'subregion', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.subregion.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('subregion_region')) 
      {
       $data->set('subregion_region', JRequest::getInt('subregion_region', $app->getUserState('com_travelentity.subregions.filter.subregion_region')));
      }
    }
    return $data;
  }
 
  public function getTable($name = 'SubRegions', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}