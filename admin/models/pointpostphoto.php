<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modeladmin');

class TravelEntityModelPointPostPhoto extends JModelAdmin
{
  public function getForm($data = array(), $loadData = true)
  {
    $form = $this->loadForm('com_travelentity.pointpostphoto', 'pointpostphoto', array('control' => 'jform', 'load_data' => $loadData));
    return $form;
  }
 
  protected function loadFormData()
  {
    $app = JFactory::getApplication();
    $data = $app->getUserState('com_travelentity.edit.pointpostphoto.data', array());
    if(empty($data))
    {
      $data = $this->getItem();
      if (!$data->get('photo_article_point')) 
      {
       $data->set('photo_article_point', JRequest::getInt('article_point', $app->getUserState('com_travelentity.pointpostphotos.filter.article_point')));
      }
    }

    return $data;
  }
 
  public function getTable($name = 'PointPostPhotos', $prefix = 'TravelEntityTable', $options = array())
  {
    return parent::getTable($name, $prefix, $options);
  }
}