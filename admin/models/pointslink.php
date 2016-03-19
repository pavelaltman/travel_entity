<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPointsLink extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    // Get the form.
    $form = $this->loadForm('com_travelentity.pointslink', 'pointslink', array('control' => 'jform', 'load_data' => $loadData));

    return $form;
 }
 
  protected function loadFormData()
  {
    // Check the session for previously entered form data.
    $app = JFactory::getApplication();
    $data = $app->getUserState('com_travelentity.edit.pointslink.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('points_links_id')) 
      {
       $data->set('link_point', JRequest::getInt('link_point', $app->getUserState('com_travelentity.pointslinks.filter.link_point')));
      }
    }

    return $data;
  }
 
  public function getTable($name = 'PointsLinks', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}