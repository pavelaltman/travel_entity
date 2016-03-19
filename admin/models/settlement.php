<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelSettlement extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.settlement', 'settlement', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.settlement.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('settlement_subregion')) 
      {
       $data->set('settlement_subregion', JRequest::getInt('settlemen_subregion', $app->getUserState('com_travelentity.settlements.filter.settlement_subregion')));
      }
    }

    return $data;
  }
 
  public function getTable($name = 'Settlements', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}