<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelLinkType extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.linktype', 'linktype', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.linktype.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('link_type_class')) 
      {
       $data->set('link_type_class', JRequest::getInt('link_type_class', $app->getUserState('com_travelentity.linktypes.filter.link_type_class')));
      }
    }
    return $data;
  }
 
  public function getTable($name = 'LinkTypes', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}