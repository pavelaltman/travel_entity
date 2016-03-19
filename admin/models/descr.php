<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelDescr extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.descr', 'descr', array('control' => 'jform', 'load_data' => $loadData));
    print_r($form) ;
    return $form;
  }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.descr.data', array());

    if(empty($data))
    {
     $data = $this->getItem();
    }

    return $data;
  }
 
  public function getTable($name = 'Descrs', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}