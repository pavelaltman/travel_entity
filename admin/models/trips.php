<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelTrips extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'trip_id', 'trip_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   // List state information.
   parent::populateState('trip_id', 'asc');
  }

  protected function getStoreId($id = '')
  {
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();


    $query = new TEQuery($db) ;
    $query->select('trip_id,trip_name');
    $query->from('#__te_trips');

    return $query;
  }
}
?>
