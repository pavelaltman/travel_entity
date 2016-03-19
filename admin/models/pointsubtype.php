<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPointSubType extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.pointsubtype', 'pointsubtype', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app=JFactory::getApplication() ;
    $data = $app->getUserState('com_travelentity.edit.pointsubtype.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('point_type')) 
      {
       $data->set('point_type', JRequest::getInt('point_type', $app->getUserState('com_travelentity.pointsubtypes.filter.point_type')));
      }
    }
    return $data;
  }
 
  public function getTable($name = 'PointSubTypes', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}