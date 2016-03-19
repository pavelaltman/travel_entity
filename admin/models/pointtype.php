<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPointType extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.pointtype', 'pointtype', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.pointtype.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('point_class')) 
      {
       $data->set('point_class', JRequest::getInt('point_class', $app->getUserState('com_travelentity.pointtypes.filter.point_class')));
      }
    }
    return $data;
  }
 
  public function getTable($name = 'PointTypes', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}