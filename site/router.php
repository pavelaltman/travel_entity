<?php

require_once JPATH_SITE.DS."components".DS."com_travelentity".DS."common_functions.php";

function TravelEntityBuildRoute( &$query )
{
       $segments = array();


       //print_r($query) ;

       if (($query['Itemid']=='765') OR ($query['Itemid']=='2151'))
       {
        if (isset($query['id']))
        {
         $data=TravelEntityGetPointDataById($query['id']) ;

         $segments[] = $data['point_class_alias'];
         $segments[] = $data['point_type_alias'];
         $segments[] = $data['point_subtype_alias'];
         $segments[] = $data['point_alias'];


         // print_r($segments) ;

         unset( $query['id'] );
         // if (isset($query['grade_id'])) 
         //   unset( $query['grade_id'] );
        }
        else
        {
         $data=TravelEntityGetCountryDataById(isset($query['class_id']) ? $query['class_id'] : 0,isset($query['country_id']) ? $query['country_id'] : 0,isset($query['type_id']) ? $query['type_id'] : 0,isset($query['region_id']) ? $query['region_id'] : 0) ;
 

         if (isset($query['class_id']))
         {
          $segments[] = $data['point_class_alias_pl'];
         }

         if (isset($query['country_id']))
         {
          if (!isset($query['class_id']))
            $segments[] = 'countries';

          $segments[] = $data['country_alias'];
         }

         if (isset($query['region_id']))
         {
          $segments[] = 'region' ;
          $segments[] = $data['region_alias'];
         }

         if (isset($query['type_id']))
         {
          $segments[] = $data['point_type_alias'];
         }

         unset( $query['class_id'] );
         unset( $query['country_id'] );
         unset( $query['type_id'] );
         unset( $query['region_id'] );
        }

        //print_r($segments) ;


       };


       if (($query['Itemid']=='1068') OR ($query['Itemid']=='2158')) // Поездки
       {
         $data=TravelEntityGetTripDataById($query['id']) ;

         $segments[] = $data['trip_alias'];

         unset( $query['id'] );
         
         if (isset($query['page']))
         {
          $segments[] = $query['page'];
          unset($query['page']);
         }
       };


       $from_class_menu= ($query['Itemid']=='1149' || $query['Itemid']=='1168' || $query['Itemid']=='1169' || $query['Itemid']=='1605' || $query['Itemid']=='1606' || $query['Itemid']=='2153' || $query['Itemid']=='2154' || $query['Itemid']=='2155' || $query['Itemid']=='2156' || $query['Itemid']=='2157') ;
       if (($from_class_menu || ($query['view']=='pointclass')) && $query['Itemid']!='765' && $query['Itemid']!='2151')
       {
         $data=TravelEntityGetCountryDataById(isset($query['class_id']) ? $query['class_id'] : 0,isset($query['country_id']) ? $query['country_id'] : 0,isset($query['type_id']) ? $query['type_id'] : 0,isset($query['region_id']) ? $query['region_id'] : 0) ;
         
 
         if ((($query['view']=='pointclass') && !$from_class_menu) || (($query['view']=='country') && isset($query['class_id'])))
         {
          // $segments[] = $data['point_class_alias_pl'];
         }

         unset( $query['class_id'] );

         if (isset($query['country_id']))
         {
          $segments[] = $data['country_alias'];
          unset( $query['country_id'] );
         }

         if (isset($query['region_id']))
         {
          $segments[] = 'region' ;
          $segments[] = $data['region_alias'];
          unset( $query['region_id'] );
         }

         if (isset($query['type_id']))
         {
          $segments[] = $data['point_type_alias'];
          unset( $query['type_id'] );
         }
       };


       unset( $query['view'] );


//       print_r(2222);
//       print_r($query);


//       print_r($segments);

       return $segments;
}


function TravelEntityParseRoute( $segments )
{
       $vars = array();
       $app =& JFactory::getApplication();
       $menu =& $app->getMenu();
       $item =& $menu->getActive();

       // print_r($segments);
       // print_r($item->query);

       // Count segments
       $count = count( $segments );
//     print_r($count);


       //Handle View and Identifier
       switch( $item->query['view'] )
       {
               case 'point':
               case 'points':
               case 'maincountry':
                       if ($count==5)
                       {
                        $vars['view'] = 'regiontype';
                        $country_alias = $segments[$count-4];
                        $region_alias = $segments[$count-2];
                        $type_alias = $segments[$count-1];
                        $data=TravelEntityGetCountryDataByAlias(0,$country_alias,$type_alias,$region_alias) ;
                        $vars['type_id'] = $data['point_type_id'] ;
                        $vars['region_id'] = $data['region_id'] ;
                        $vars['country_id'] = $data['country_id'] ;
                        $vars['class_id'] = $item->query['class_id']  ;
                       }
                       if($count == 4) 
                       {
                        if ($segments[$count-2]=='region')
                        {
                         $vars['view'] = 'regioncountry';
                         $country_alias = $segments[$count-3];
                         // print_r($country_alias) ;
                         $region_alias = $segments[$count-1];
                         // print_r($region_alias) ;
                         $data=TravelEntityGetCountryDataByAlias(0,$country_alias,'',$region_alias) ;
                         // print_r($data) ;
                         $vars['region_id'] = $data['region_id'] ;
                         $vars['country_id'] = $data['country_id'] ;
                         $vars['class_id'] = $item->query['class_id']  ;
                        }
                        else // then point
                        {
                         $vars['view'] = 'point';
                         $alias = $segments[$count-1];
                         // print_r($alias) ;
                         $data=TravelEntityGetPointDataByAlias($alias) ;
                         // print_r($data) ;
                         $vars['id'] = $data['point_id'];
                        }
                       }
                       if ($count==2)
                       {
                        $vars['view'] = 'maincountry';

                        $country_alias = $segments[$count-1];
  
                        $data=TravelEntityGetCountryDataByAlias(0,$country_alias) ;

                        $vars['country_id'] = $data['country_id'];
                       }
                       if ($count==3)
                       {
                        $vars['view'] = 'regioncountry';

                        $region_alias = $segments[$count-1];
                        $country_alias = $segments[$count-3];
  
                        $data=TravelEntityGetCountryDataByAlias(0,$country_alias,'',$region_alias) ;

                        $vars['country_id'] = $data['country_id'];
                        $vars['region_id'] = $data['region_id'];
                       }
                       break;

               case 'trip':
               case 'trips':
                       //print_r($count) ;
                       if ($count==1)
                       {
               	        $vars['view'] = 'trip';

                        $alias = $segments[$count-1];
  
                        $data=TravelEntityGetTripDataByAlias($alias) ;
                      
                        $vars['id'] = $data['trip_id'];
                       }
                       
                       elseif ($count==2)
                       {
                       	$vars['view'] = 'tripphotos';
                       
                       	$alias = $segments[$count-2];
                       
                       	$data=TravelEntityGetTripDataByAlias($alias) ;
                       
                       	$vars['id'] = $data['trip_id'];
                       }
                        
                       break;

               case 'pointclass':
                       if ($count==1)
                       {
                        $vars['view'] = 'country';
                        $country_alias = $segments[$count-1];
                        $data=TravelEntityGetCountryDataByAlias($item->query['class_id'],$country_alias) ;
                        if (isset($data['country_id']))
                        {
                         $vars['country_id'] = $data['country_id'] ;
                         $vars['class_id'] = $item->query['class_id']  ;
                        }
                        else // it is classtype, not country
                        {
                         $vars['view'] = 'classtype';
                         $type_alias = $segments[$count-1];
                         $data=TravelEntityGetCountryDataByAlias($item->query['class_id'],'',$type_alias) ;
                         $vars['type_id'] = $data['point_type_id'] ;
                         $vars['class_id'] = $item->query['class_id']  ;
                        }
                       }
                       if ($count==2)
                       {
                        $vars['view'] = 'pointtype';
                        $country_alias = $segments[$count-2];
                        $type_alias = $segments[$count-1];
                        //print_r($segments) ;
                        $data=TravelEntityGetCountryDataByAlias($item->query['class_id'],$country_alias,$type_alias) ;
                        $vars['type_id'] = $data['point_type_id'] ;
                        $vars['country_id'] = $data['country_id'] ;
                        $vars['class_id'] = $item->query['class_id']  ;
                       }
                       if ($count==3)
                       {
                        $vars['view'] = 'region';
                        $country_alias = $segments[$count-3];
                        $region_alias = $segments[$count-1];
                        $data=TravelEntityGetCountryDataByAlias($item->query['class_id'],$country_alias,'',$region_alias) ;
                        $vars['region_id'] = $data['region_id'] ;
                        $vars['country_id'] = $data['country_id'] ;
                        $vars['class_id'] = $item->query['class_id']  ;
                       }
                       if ($count==4)
                       {
                        $vars['view'] = 'regiontype';
                        $country_alias = $segments[$count-4];
                        $region_alias = $segments[$count-2];
                        $type_alias = $segments[$count-1];
                        $data=TravelEntityGetCountryDataByAlias($item->query['class_id'],$country_alias,$type_alias,$region_alias) ;
                        $vars['type_id'] = $data['point_type_id'] ;
                        $vars['region_id'] = $data['region_id'] ;
                        $vars['country_id'] = $data['country_id'] ;
                        $vars['class_id'] = $item->query['class_id']  ;
                       }
                       break;

       }
       return $vars;
}

