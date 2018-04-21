<?php
// No direct access to this file
defined('_JEXEC') or die;

global $glt ;

// Хлебные крошки
echo "<table><tr><td>";
echo "<a href=\"".JRoute::_('index.php? option=com_travelentity&view=pointclass&class_id='.$this->item['data']['point_class_id'])."\">".$this->item['data']['point_class_name_pl'.$glt]."</a>"." --> ";
echo "<a href=\"".JRoute::_('index.php? option=com_travelentity&view=pointclass&class_id='.$this->item['data']['point_class_id'].'&country_id='.$this->item['data']['country_id'])."\">".$this->item['data']['point_class_name_pl'.$glt]." ".$this->item['data']['country_name_rod'.$glt]."</a>";
echo "</td><td valign=\"top\">";
echo "--> <a href=\"".JRoute::_('index.php? option=com_travelentity&view=pointclass&class_id='.$this->item['data']['point_class_id'].'&country_id='.$this->item['data']['country_id'].'&region_id='.$this->item['data']['region_id'])."\">".$this->item['data']['point_class_name_pl'.$glt]." ".$this->item['data']['region_name_rod'.$glt]."</a> --></br>" ;
echo "</td><td>";
echo "--> <a href=\"".JRoute::_('index.php? option=com_travelentity&view=pointclass&class_id='.$this->item['data']['point_class_id'].'&country_id='.$this->item['data']['country_id'].'&region_id='.$this->item['data']['region_id'].'&type_id='.$this->item['data']['point_type_id'])."\">".$this->item['data']['point_type_name_pl'.$glt]." ".$this->item['data']['region_name_rod'.$glt]."</a> --></br>" ;
echo "</td></tr><tr><td></td><td>";
echo "--> <a href=\"".JRoute::_('index.php? option=com_travelentity&view=pointclass&class_id='.$this->item['data']['point_class_id'].'&country_id='.$this->item['data']['country_id'].'&type_id='.$this->item['data']['point_type_id'])."\">".$this->item['data']['point_type_name_pl'.$glt]." ".$this->item['data']['country_name_rod'+$glt]."</a> --></br>" ;
echo "</td></tr></table>";

?>


<h3><?php echo $this->item['data']['point_id'].' '.$this->item['data']['point_name'.$glt] ; ?></h3>

<table width="100%"><tr><td>
<b><?php echo $this->item['labs']['this_label']; ?><?php echo $this->item['data']['point_class_name'.$glt]; ?></b></br>
<?php echo $this->item['labs']['type_label']; ?><?php echo $this->item['data']['point_type_name'.$glt]; ?></br>
<?php echo $this->item['labs']['subtype_label']; ?><?php echo $this->item['data']['point_subtype_name'.$glt]; ?>
</td>
<?php

 if (strlen($this->item['username']))
 {
  for ($j=1 ; $j<=2 ; $j++)
  {
   echo "<td>" ;

   // Цикл по оценкам
   foreach($this->item['gradeslist'] as $i =>$grade)
   {
    $gn= ($j==1 ? 'grade_name_before'.$glt : 'grade_name_after'.$glt) ;
    if ($grade['grade_id']==$this->item['usergrade'][$j]['grade_id'])
       echo "<b>(*) ".$grade[$gn]."</b></br>" ;
    else
       echo "<a href=\"".JRoute::_('index.php? option=com_travelentity&task=point.setgrade&Itemid='.GetPointsMenuItem().'&id='.$this->item['data']['point_id'].'&grade_id='.$grade['grade_id'].'&before_after='.$j)."\">( ) ".$grade[$gn]."</a></br>" ;
   }

   echo "</td>" ;
  }
 }
 else
 {
  echo "<td>".$this->item['labs']['login_label']."</td>" ;
 }
?>
</tr></table>



<?php
// Цикл по своим фотографиям
foreach($this->item['photos_arr'] as $i =>$photos)
{
 echo "<p>".$this->item['labs']['trip_photos_label'].": "."<a href=\"".JRoute::_('index.php?Itemid=1068&option=com_travelentity&view=trips&page=photos&id='.$photos["photo_trip"])."\">".$photos['trip_name']."</a><br>" ;
 echo "<img src=\"images/".$photos['photo_path']."\" alt=\"".$photos['photo_name']."\" </img></p>" ;
} 

// Цикл по внешним фотографиям и другим визуальным объектам 
foreach($this->item['link_photos_arr'] as $i =>$link_photos)
{
 // выводим заголовок над фотографией откуда она
 echo "</br>".$link_photos['content_type_name'] ;

 echo $link_photos['link_class_post_label']; 
 if (strlen($link_photos['link_class_link_label']))
 {
  echo "<a href=\"".$link_photos['link_class_sitelink']."\">".$link_photos['link_class_link_label']."</a>" ;
 }
 echo $link_photos['link_type_post_label'] ;
 if (strlen($link_photos['link_type_link_label']))
    echo "<a href=\"".$link_photos['link_type_sitelink']."\">".$link_photos['link_type_link_label']."</a>" ; 
 echo "</br>";

 if (strlen($link_photos['link_iframe_src']))
   echo "<iframe src=\"".$link_photos['link_iframe_src']."\" width=\"670\" height=\"450\" marginheight=\"0\" framespacing=\"0\" marginwidth=\"0\" border=\"0\"></iframe>" ;
 else
   echo "<img src=\"".$link_photos['link_photo_path']."\" alt=\"".$link_photos['link_photo_name']."\" </img>" ;
 echo "</br>";
}
?>

<p><b><?php echo $this->item['labs']['place_label']; ?></b></br>
<?php echo $this->item['labs']['country_label']; ?><?php echo $this->item['data']['country_name'.$glt]; ?></br>
<?php echo $this->item['data']['region_nikname'.$glt].': '; ?><?php echo $this->item['data']['region_name'.$glt]; ?></br>
<?php echo $this->item['data']['subregion_nikname'.$glt].': '; ?><?php echo $this->item['data']['subregion_name'.$glt]; ?></br>

<?php 
$km_str='' ;
if ($this->item['data']['point_settlement_dist']) { echo $this->item['labs']['settlement_near_label']; $km_str=' ('.(string)$this->item['data']['point_settlement_dist'].$this->item['labs']['km_label'].')' ; }
else
echo $this->item['labs']['settlement_label'];
?>
<?php echo $this->item['data']['settlement_name'].$km_str; ?></br>
</p>


<?php echo $this->item['labs']['coord_label'].": ".$this->item['data']['point_lat'].",".$this->item['data']['point_lon']; ?></br>
<?php echo $this->item['data']['point_name'.$glt].$this->item['labs']['onmap_label']; ?></br>
<?php $this->GetModel()->GetMaps()->DrawMap('localmap') ; ?>


</br></br><?php echo $this->item['data']['point_descr'.$glt]; ?></br>

<?php if (!empty($this->item['data']['point_parent'])): // Выводим информацию о родительской точке если она есть ?>
</br><?php  echo $this->item['labs']['parentpoint_label']."<a href=\"".GetPointNameRoute($this->item['parent_data']['point_id'])."\">".$this->item['parent_data']['point_subtype_name'.$glt]." ".$this->item['parent_data']['point_name'.$glt]."</a>" ; ?></br> 
<?php endif ; ?>

<?php if (count($this->item['children_data'])): // Выводим список дочерних точек, в том случае если они есть ?>

</br><?php echo $this->item['labs']['childpoints_label']; ?></br>
<?php foreach($this->item['children_data'] as $i => $child_item): ?>
 <?php echo "<a href=\"".GetPointNameRoute($child_item['point_id'])."\">".$child_item['point_subtype_name'.$glt]." ".$child_item['point_name'.$glt]."</a>"; ?></br>
<?php endforeach; ?>

<?php endif ; ?>

<?php if (count($this->item['sister_data'])): // Выводим список сестринских точек, в том случае если они есть ?>

</br><?php echo $this->item['labs']['sisterpoints_label']; ?></br>
<?php foreach($this->item['sister_data'] as $i => $sister_item): ?>
 <?php echo "<a href=\"".GetPointNameRoute($sister_item['point_id'])."\">".$sister_item['point_subtype_name'.$glt]." ".$sister_item['point_name'.$glt]."</a>"; ?></br>
<?php endforeach; ?>

<?php endif ; ?>


<?php if (count($this->item['posts_arr'])): // Выводим список постов на родном сайте, в том случае если они есть ?>

</br><b><?php echo $this->item['labs']['posts_label'].$this->item['labs']['sitename_label']; ?></b></br>
<?php foreach($this->item['posts_arr'] as $i => $post_item): ?>
 <?php echo "<a href=\"".JRoute::_('index.php?option=com_content&view=category&layout=blog&id='.$post_item['catid'].'&Itemid='.$post_item['post_menuitem'])."\">".$post_item['ctitle']."</a>"." -> <a href=\"".JRoute::_('index.php?option=com_content&view=article&id='.$post_item['id'].'&catid='.$post_item['catid'].'&Itemid='.$post_item['post_menuitem'])."\">".$post_item['title']."</a>"; ?></br>
<?php endforeach; ?>

<?php endif ; ?>

<?php // Цикл по классам ссылок
foreach($this->item['link_class_arr'] as $j => $link_class): ?>

</br><b>
<?php //Выводим заголовок класса ссылок
 echo $link_class['link_class_pre_label']; 
 
 //print_r($link_class);
 switch ($link_class['link_class_incl_point'])
 {
  case 1: echo $this->item['data']['point_name'.$glt]; break ;
  case 2: echo $this->item['data']['point_name_rod'.$glt]; break ;
 } 

 echo $link_class['link_class_post_label']; 

 if (strlen($link_class['link_class_link_label']))
 {
  echo "<a href=\"".$link_class['link_class_sitelink']."\">".$link_class['link_class_link_label']."</a>" ;
 }
?>
</b></br>

<?php foreach($link_class['links_arr'] as $i => $link_item): ?>
<?php // Выводим в одной строке ссылку и информацию о типе ссылки
 if (strlen($link_item['link_label']))
 {
  echo $link_item['link_type_pre_label'] ;
  echo "<a href=\"".$link_item['link_link']."\">".$link_item['link_label']."</a>" ; 
  echo $link_item['link_type_post_label'] ;

  if (strlen($link_item['link_type_link_label']))
    echo "<a href=\"".$link_item['link_type_sitelink']."\">".$link_item['link_type_link_label']."</a>" ; 
 }
 else
 {
  echo "<a href=\"".$link_item['link_link']."\">".$link_item['link_type_pre_label'] ;

  switch ($link_item['link_type_incl_point'])
  {
   case 1: echo $this->item['data']['point_name'.$glt]; break ;
   case 2: echo $this->item['data']['point_name_rod'.$glt]; break ;
  } 

  echo "</a>".$link_item['link_type_post_label'] ;

  if (strlen($link_item['link_type_link_label']))
    echo "<a href=\"".$link_item['link_type_sitelink']."\">".$link_item['link_type_link_label']."</a>" ; 

 }
?></br>

<?php endforeach; ?>

<?php endforeach; ?>

