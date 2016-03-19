<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelSubRegions extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'subregion_region', 'subregion_region',
				'subregion_id', 'subregion_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $region_id = $this->getUserStateFromRequest('com_travelentity.subregions.filter.subregion_region', 'filter_subregion_region');
   $this->setState('filter.subregion_region', $region_id);

   // List state information.
   parent::populateState('subregion_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.subregion_region');
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();

    $region_id=JRequest::getInt('region_id') ;
    if ($region_id)
    {
     $this->setState('filter.subregion_region', $region_id);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.subregions.filter.subregion_region',$region_id);
    }


    $p_query = new TEQuery($db) ;
    $p_query->select("region_id AS value, region_name AS text") ;
    $p_query->from("#__te_regions");
    $db->setQuery($p_query);
    $this->aux_arrays['regionlist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('subregion_id,subregion_name');
    $query->from('#__te_subregions');
    $query->order('subregion_name');

    if ($region_id = $this->getState('filter.subregion_region')) 
      $query->where('subregion_region='.$region_id);

    return $query;
  }
}
?>
