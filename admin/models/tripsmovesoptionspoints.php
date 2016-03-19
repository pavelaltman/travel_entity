<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.modellist');
require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."tequery.php";

class TravelEntityModelTripsMovesOptionsPoints extends JModelList
{
  public function __construct($config = array())
  {
   if (empty($config['filter_fields'])) {
      $config['filter_fields'] = array(
				'trip_move_option', 'trip_move_option',
				'trip_move_option_point_id', 'trip_move_option_point_id',
			);
   }
   parent::__construct($config);
  }

  protected function populateState($ordering = null, $direction = null)
  {
   $app = JFactory::getApplication();
   $session = JFactory::getSession();

   $trip_move_option = $this->getUserStateFromRequest('com_travelentity.tripsmovesoptionspoints.filter.trip_move_option', 'filter_trip_move_option');
   $this->setState('filter.trip_move_option', $trip_move_option);

   // List state information.
   parent::populateState('trip_move_option', 'asc');
  }

  protected function getStoreId($id = '')
  {
   $id	.= ':'.$this->getState('filter.trip_move_option');
   return parent::getStoreId($id);
  }


  protected function getListQuery()
  {
    $db = JFactory::getDBO();

    $trip_move_option=JRequest::getInt('trip_move_option_id') ;
    if ($trip_move_option)
    {
     $this->setState('filter.trip_move_option', $trip_move_option);

     $app = JFactory::getApplication();
     $app->setUserState('com_travelentity.tripsmovesoptionspoints.filter.trip_move_option',$trip_move_option);
    }


    $p_query = new TEQuery($db) ;
    $p_query->select("trip_move_option_id AS value, trip_move_option_comment AS text") ;
    $p_query->from("#__te_trips_moves_options") ;
    $db->setQuery($p_query);
    $this->aux_arrays['movesoptionslist'] = $db->loadObjectList();


    $query = new TEQuery($db) ;
    $query->select('trip_move_option_point_id,option_point_id');
    $query->from('#__te_trips_moves_options_points');

    if ($trip_move_option = $this->getState('filter.trip_move_option')) 
      $query->where('trip_move_option='.$trip_move_option);

    return $query;
  }
}
?>
