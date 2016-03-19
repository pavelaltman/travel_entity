<?php

abstract class TEMap
{
 protected $document ;

 public function Init($name)
 {
  $this->document=&JFactory::getDocument();

  $style =  'html { height: 100% }'
          . 'body { height: 100%; margin: 0px; padding: 0px }'
          . '#'.$name.' { height: 100% }' ;
  $this->document->addStyleDeclaration( $style );
 }
}

class TESingleMap extends TEMap
{
 protected $lat,$lon,$z ;

 public function Init($name,$lat,$lon,$z)
 {
  $this->lat=$lat;
  $this->lon=$lon;
  $this->z=$z;

  parent::Init($name) ;

  $script= 'function initialize() {'
         . ' var latlng = new google.maps.LatLng('.$lat.','.$lon.');'
         . ' var myOptions = { '
         . '     zoom: '.$z.', '
         . '     center: latlng, '
         . '     disableDefaultUI: true, '
         . '     mapTypeControl: true, '
         . '     rotateControl: false, '
         . '     scaleControl: true, '
         . '     overviewMapControl: true, '
         . '     zoomControlOptions: { style: google.maps.ZoomControlStyle.SMALL }, '
         . '     mapTypeId: google.maps.MapTypeId.HYBRID '
         . ' }; '
         . ' var map = new google.maps.Map(document.getElementById("'.$name.'"),myOptions); '
         . ' var marker = new google.maps.Marker({ '
         . '   position: latlng, '
         . '   map: map '
         . ' }); '
         . '} ' 
         . 'google.maps.event.addDomListener(window, "load", initialize);' ;

  $this->document->addScriptDeclaration( $script );
 }

 public function Draw($name)
 {
  echo '<div id="'.$name.'" style="width:100%; height:470px"></div>' ;
 }
}

class TEArrayMap extends TEMap
{
 public function Init($name,&$point_array,$lat_str,$lon_str,$title_str='',$link_str='',$descr_str='',$marker_str='')
 {
  parent::Init($name) ;

  $script= 'function initialize() {'
         . ' var latlng1 = new google.maps.LatLng('.$point_array[0]->$lat_str.','.$point_array[0]->$lon_str.');'
         . ' var myOptions = { '
         . '     zoom: 10, '
         . '     center: latlng1, '
         . '     disableDefaultUI: true, '
         . '     mapTypeControl: true, '
         . '     rotateControl: false, '
         . '     scaleControl: true, '
         . '     overviewMapControl: true, '
         . '     zoomControlOptions: { style: google.maps.ZoomControlStyle.SMALL }, '
         . '     mapTypeId: google.maps.MapTypeId.HYBRID '
         . ' }; '
         . ' var map = new google.maps.Map(document.getElementById("'.$name.'"),myOptions); '
         . ' var latlng ; ' 
         . ' var bounds= new google.maps.LatLngBounds(latlng1,latlng1) ; ' ;

  foreach($point_array as $i => $point) 
  {
   $script=$script
         . ' latlng = new google.maps.LatLng('.$point->$lat_str.','.$point->$lon_str.');'
         . ' bounds.extend(latlng);' 
         . ' var marker'.$i.' = new google.maps.Marker({icon: \''.$point->$marker_str.'\',position: latlng, map: map '.(strlen($point->$title_str) ? ',title: \''.$point->$title_str.'\'' : '').'}); ';

   if (strlen($link_str))
    if (strlen($point->$link_str))
      $script=$script
         . ' var infowindow'.$i.' = new google.maps.InfoWindow({ content: \'<div id="content">'.$point->$link_str.'</div>\'}); '
         . ' google.maps.event.addListener(marker'.$i.', "click", function() { infowindow'.$i.'.open(map,marker'.$i.');}); ' ;


  }

  $script=$script
         . 'map.fitBounds(bounds); ' 
         . '} ' 
         . 'google.maps.event.addDomListener(window, "load", initialize);' ;

  $this->document->addScriptDeclaration( $script );
 }

 public function Draw($name)
 {
  echo '<div id="'.$name.'" style="width:100%; height:650px"></div>' ;
 }
}

class TEMapSystem
{
 protected $maps ;

 function __construct() 
 { 
  $this->maps=array() ; 

  $document=&JFactory::getDocument();
  $document->addScript('https://maps.google.com/maps/api/js?sensor=false') ;
 }
 
 function AddMap($mapname,$lat,$lon,$z)
 {
  $this->maps[$mapname]= new TESingleMap ;
  $this->maps[$mapname]->Init($mapname,$lat,$lon,$z) ;
 }

 function AddArrayMap($mapname,&$point_array,$lat_str,$lon_str,$title_str='',$link_str='',$descr_str='',$marker_str='')
 {
  $this->maps[$mapname]= new TEArrayMap ;
  $this->maps[$mapname]->Init($mapname,$point_array,$lat_str,$lon_str,$title_str,$link_str,$descr_str,$marker_str) ;
 }

 function DrawMap($mapname) 
 {
  $this->maps[$mapname]->Draw($mapname) ;
 }

 function CheckMap($mapname) 
 {
  if (!is_array($this->maps)) return 0 ;
  return array_key_exists($mapname,$this->maps) ;
 }
}
