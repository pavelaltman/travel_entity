<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPointsPost extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.pointspost', 'pointspost', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
  }
 
  protected function loadFormData()
  {
    $app = JFactory::getApplication();
    $data = $app->getUserState('com_travelentity.edit.pointspost.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('post_point')) 
      {
       $data->set('post_point', JRequest::getInt('post_point', $app->getUserState('com_travelentity.pointsposts.filter.post_point')));
      }
    }

    
    return $data;
  }
 
  public function getTable($name = 'PointsPosts', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}