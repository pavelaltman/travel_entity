<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelLinkClass extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.linkclass', 'linkclass', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $data = JFactory::getApplication()->getUserState('com_travelentity.edit.linkclass.data', array());
    if(empty($data)){
      $data = $this->getItem();
    }
    return $data;
  }
 
  public function getTable($name = 'LinkClasses', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}