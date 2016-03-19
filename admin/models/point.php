<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPoint extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    // Get the form.
    $form = $this->loadForm('com_travelentity.point', 'point', array('control' => 'jform', 'load_data' => $loadData));

    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app = JFactory::getApplication();
    $data = $app->getUserState('com_travelentity.edit.point.data', array());
    if(empty($data))
    {
     $data = $this->getItem();

     if (!$data->get('point_settlement')) 
       $data->set('point_settlement', JRequest::getInt('point_settlement', $app->getUserState('com_travelentity.points.filter.settlement_id')));
     if (!$data->get('point_subtype')) 
       $data->set('point_subtype', JRequest::getInt('point_subtype', $app->getUserState('com_travelentity.points.filter.point_subtype_id')));
    }

//    print_r($data) ;

    return $data;
  }
 
  public function getTable($name = 'Points', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}