<?php
// No direct access to this file
defined('_JEXEC') or die;
jimport('joomla.application.component.controlleradmin');

class TravelEntityControllerRegions extends JControllerAdmin
{
  public function getModel($name = 'Regions', $prefix = 'TravelEntityModel')         {
    $model = parent::getModel($name, $prefix, array('ignore_request' => true));
    return $model;
  }
}