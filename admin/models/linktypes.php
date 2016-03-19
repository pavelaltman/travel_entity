<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelLinkTypes extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'link_type_class', 'link_type_class',
				'link_type_id', 'link_type_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $link_class_id = $this->getUserStateFromRequest('com_travelentity.linktypes.filter.link_type_class', 'filter_link_type_class');
   $this->setState('filter.link_type_class', $link_class_id);

   // List state information.
   parent::populateState('link_type_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.link_type_class');
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();

    $link_class_id=JRequest::getInt('link_class_id') ;
    if ($link_class_id)
    {
     $this->setState('filter.link_type_class', $link_class_id);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.linktypes.filter.link_type_class',$link_class_id);
    }


    $p_query = new TEQuery($db) ;
    $p_query->select('link_class_id AS value, link_class_name AS text') ;
    $p_query->from('#__te_points_link_classes') ;
    $db->setQuery($p_query);
    $this->aux_arrays['linkclasseslist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('link_type_id,link_type_name');
    $query->from('#__te_points_link_types');

    if ($link_class_id = $this->getState('filter.link_type_class')) 
      $query->where('link_type_class='.$link_class_id);

    return $query;
  }
}
?>
