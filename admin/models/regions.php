<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelRegions extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'region_country', 'region_country',
				'region_id', 'region_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $country_id = $this->getUserStateFromRequest('com_travelentity.regions.filter.region_country', 'filter_region_country');
   $this->setState('filter.region_country', $country_id);

   // List state information.
   parent::populateState('region_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.region_country');
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();

    $country_id=JRequest::getInt('country_id') ;
    if ($country_id)
    {
     $this->setState('filter.region_country', $country_id);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.regions.filter.region_country',$country_id);
    }


    $p_query = new TEQuery($db) ;
    $p_query->select("country_id AS value, country_name AS text") ;
    $p_query->from("#__te_countries");
    $db->setQuery($p_query);
    $this->aux_arrays['countrylist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('region_id,region_name');
    $query->from('#__te_regions');
    $query->order('region_name');

    if ($country_id = $this->getState('filter.region_country')) 
      $query->where('region_country='.$country_id);

    return $query;
  }
}
?>
