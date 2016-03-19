drop table if exists `#__te_textlabels`;
drop table if exists `#__te_trips_moves_options_points`;
drop table if exists `#__te_trips_moves_options`;
drop table if exists `#__te_trips_move_options_types`;
drop table if exists `#__te_trips_moves`;
drop table if exists `#__te_trips_stay_points`;
drop table if exists `#__te_points_trips_plan`;
drop table if exists `#__te_points_trips`;
drop table if exists `#__te_travelers_trips`;
drop table if exists `#__te_travelers`;
drop table if exists `#__te_trips`;
drop table if exists `#__te_trip_stages`;
drop table if exists `#__te_class_type_country_region`;
drop table if exists `#__te_points_link_photos`;
drop table if exists `#__te_points_photos`;
drop table if exists `#__te_photos`;
drop table if exists `#__te_points_posts`;
drop table if exists `#__te_points_links`;
drop table if exists `#__te_points_link_types`;
drop table if exists `#__te_visual_content_types`;
drop table if exists `#__te_points_link_classes`;
drop table if exists `#__te_points`;
drop table if exists `#__te_settlements_region_capitals`;
drop table if exists `#__te_settlements_country_capitals`;
drop table if exists `#__te_settlements_subregions`;
drop table if exists `#__te_settlements`;
drop table if exists `#__te_settlement_types`;
drop table if exists `#__te_subregiongroups_subregions`;
drop table if exists `#__te_subregiongroups`;
drop table if exists `#__te_regiongroups_regions`;
drop table if exists `#__te_regiongroups`;
drop table if exists `#__te_region_names`;
drop table if exists `#__te_subregions`;
drop table if exists `#__te_regions`;
drop table if exists `#__te_areas_countries`;
drop table if exists `#__te_areas`;
drop table if exists `#__te_countries`;
drop table if exists `#__te_continents`;
drop table if exists `#__te_point_subtypes`;
drop table if exists `#__te_point_types`;
drop table if exists `#__te_point_classes` ;


-- -------------------------------------------
-- ���� ������ ������� ����� � �������� �����

create table `#__te_point_classes`
(
   `point_class_id`       int(11) not null,
   `point_class_name`     varchar(255) not null,
   `point_class_name_pl`  varchar(255) not null, -- �������� ������ �� ������������� �����
   `point_class_alias`    varchar(255) not null unique,
   `point_class_alias_pl` varchar(255) not null unique,
   `point_class_descr`    varchar(255),
   primary key (`point_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

create table `#__te_point_types`
(
   `point_type_id`        int not null,
   `point_class`          int not null,
   `point_type_name`      varchar(255) not null,
   `point_type_name_pl`   varchar(255) not null,
   `point_type_alias`     varchar(255) not null unique,
   `point_type_descr`     varchar(255),
   primary key (`point_type_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_point_types` add constraint `#__te_FK_Reference_1` foreign key (`point_class`)
      references `#__te_point_classes` (`point_class_id`) on delete restrict on update restrict;


create table `#__te_point_subtypes`
(
   `point_subtype_id`     int not null,
   `point_type`           int not null,
   `point_subtype_name`   varchar(255) not null,
   `point_subtype_alias`  varchar(255) not null unique,
   `point_subtype_descr`  varchar(255),
   primary key (`point_subtype_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_point_subtypes` add constraint `#__te_FK_Reference_2` foreign key (`point_type`)
      references `#__te_point_types` (`point_type_id`) on delete restrict on update restrict;


-- ----------------------------------------------------
-- ���� ������ ��������������, �� ���������� �� ������

create table `#__te_continents`
(
   `continent_id`         int not null,
   `continent_name`       varchar(255) not null,
   `continent_alias`      varchar(255) not null unique,
   `continent_descr`      varchar(255),
   primary key (`continent_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


create table `#__te_countries`
(
   `country_id`        int not null auto_increment,
   `country_continent` int not null,
   `country_name`      varchar(255) not null,
   `country_name_rod`  varchar(255) not null,
   `country_alias`     varchar(255) not null unique,
   `country_descr`     varchar(255),
   `country_longdescr` mediumtext,
   primary key (`country_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_countries` add constraint `#__te_FK_country_continent` foreign key (`country_continent`)
      references `#__te_continents` (`continent_id`) on delete restrict on update restrict;

-- area - ���������� - ��������� ����� � �������� ������ ����������, ��������, "���-��������� ����" ��� "�������� ������"
create table `#__te_areas`
(
   `area_id`         int not null,
   `area_name`       varchar(255) not null,
   `area_alias`      varchar(255) not null unique,
   `area_descr`      varchar(255),
   primary key (`area_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- ������� ��������� ����� � ����������
create table `#__te_areas_countries`
(
   `area_country_id` int not null auto_increment,
   `area_id`         int not null,
   `country_id`      int not null,
   primary key (`area_country_id`),
   unique (`area_id`,`country_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_areas_countries` add constraint `#__te_FK_areas_countries_area` foreign key (`area_id`)
      references `#__te_areas` (`area_id`) on delete restrict on update restrict;

alter table `#__te_areas_countries` add constraint `#__te_FK_areas_countries_country` foreign key (`country_id`)
      references `#__te_countries` (`country_id`) on delete restrict on update restrict;


-- region - ����� ������� �����. ������� ������ ������, ��� ������ ��� ���������� � ��������� ������ ����� ���������� � ��������� �������. � ������� ��� �������
create table `#__te_regions`
(
   `region_id`       int not null,
   `region_country`  int not null,
   `region_name`     varchar(255) not null,
   `region_name_rod`  varchar(255) not null,
   `region_alias`    varchar(255) not null unique,
   `region_descr`    varchar(255),
   primary key (`region_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_regions` add constraint `#__te_FK_region_country` foreign key (`region_country`)
      references `#__te_countries` (`country_id`) on delete restrict on update restrict;

-- subregion - ��������� ������� ������ ������, ��� ������ ��� ���������� � ��������� ������ ����� ���������� � ��������� �������. � ������� ��� ������
create table `#__te_subregions`
(
   `subregion_id`       int not null,
   `subregion_region`   int not null,
   `subregion_name`     varchar(255) not null,
   `subregion_alias`    varchar(255) not null unique,
   `subregion_descr`    varchar(255),
   primary key (`subregion_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_subregions` add constraint `#__te_FK_subregion_region` foreign key (`subregion_region`)
      references `#__te_regions` (`region_id`) on delete restrict on update restrict;


-- �������� ������ ����������������� ������� ��� ������ �����
create table `#__te_region_names`
(
   `country_id`             int not null,
   `region_nikname`         varchar(255) not null,
   `region_nikname_rod`     varchar(255) default null,
   `subregion_nikname`      varchar(255) not null,
   `regiongroup_nikname`    varchar(255) not null,
   `subregiongroup_nikname` varchar(255) not null
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_region_names` add constraint `#__te_FK_region_names` foreign key (`country_id`)
      references `#__te_countries` (`country_id`) on delete restrict on update restrict;


-- regiongroup - ���������� � �������� ������, ������������ ��������� ��������, ��������, "����� ��������" ��� "�������� �������"
create table `#__te_regiongroups`
(
   `regiongroup_id`         int not null,
   `regiongroup_name`       varchar(255) not null,
   `regiongroup_alias`      varchar(255) not null unique,
   `regiongroup_descr`      varchar(255),
   primary key (`regiongroup_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- ������� ��������� �������� � ������
create table `#__te_regiongroups_regions`
(
   `regiongroup_region_id`  int not null auto_increment,
   `regiongroup_id`         int not null,
   `region_id`              int not null,
    primary key (`regiongroup_region_id`),
    unique (`regiongroup_id`,`region_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_regiongroups_regions` add constraint `#__te_FK_regiongroups_regions_regiongroup` foreign key (`regiongroup_id`)
      references `#__te_regiongroups` (`regiongroup_id`) on delete restrict on update restrict;

alter table `#__te_regiongroups_regions` add constraint `#__te_FK_regiongroups_regions_region` foreign key (`region_id`)
      references `#__te_regions` (`region_id`) on delete restrict on update restrict;


-- subregiongroup - ���������� � �������� �������, ������������ ��������� �����������, ��������, "������� ���������" � "�������"
create table `#__te_subregiongroups`
(
   `subregiongroup_id`         int not null,
   `subregiongroup_name`       varchar(255) not null,
   `subregiongroup_alias`      varchar(255) not null unique,
   `subregiongroup_descr`      varchar(255),
   primary key (`subregiongroup_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- ������� ��������� ����������� � ������
create table `#__te_subregiongroups_subregions`
(
   `subregiongroup_subregion_id` int not null,
   `subregiongroup_id`           int not null,
   `subregion_id`                int not null,
    primary key (`subregiongroup_subregion_id`),
    unique (`subregiongroup_id`,`subregion_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_subregiongroups_subregions` add constraint `#__te_FK_subregiongroups_subregions_subregiongroup` foreign key (`subregiongroup_id`)
      references `#__te_subregiongroups` (`subregiongroup_id`) on delete restrict on update restrict;

alter table `#__te_subregiongroups_subregions` add constraint `#__te_FK_subregiongroups_subregions_subregion` foreign key (`subregion_id`)
      references `#__te_subregions` (`subregion_id`) on delete restrict on update restrict;



-- ���� ���������� �������
create table `#__te_settlement_types`
(
   `settlement_type_id`         int not null,
   `settlement_type_name`       varchar(255) not null,
   `settlement_type_alias`      varchar(255) not null unique,
   `settlement_type_descr`      varchar(255),
   primary key (`settlement_type_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- ���������� ������
create table `#__te_settlements`
(
   `settlement_id`         int not null,
   `settlement_type`       int not null,
   `settlement_name`       varchar(255) not null,
   `settlement_alias`      varchar(255) not null unique,
   `settlement_descr`      varchar(255),
   primary key (`settlement_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_settlements` add constraint `#__te_FK_settlements_settlement_types` foreign key (`settlement_type`)
      references `#__te_settlement_types` (`settlement_type_id`) on delete restrict on update restrict;


-- ��������� ���������� ������� � �����������. ����� ���� "����� � ������", ��������� ��������� ������ ���������� ����������, � ������� �������� ������� �� ���
create table `#__te_settlements_subregions`
(
   `settlement_subregion_id`  int not null,
   `settlement_id`            int not null,
   `subregion_id`             int not null,
   `subregion_is_capital`     int not null, -- 1- ���� ����� - ������� ����������, 0 - �����.
   primary key (`settlement_subregion_id`),
   unique (`settlement_id`,`subregion_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_settlements_subregions` add constraint `#__te_FK_settlements_subregion_settlement` foreign key (`settlement_id`)
      references `#__te_settlements` (`settlement_id`) on delete restrict on update restrict;

alter table `#__te_settlements_subregions` add constraint `#__te_FK_settlements_subregion_subregions` foreign key (`subregion_id`)
      references `#__te_subregions` (`subregion_id`) on delete restrict on update restrict;


-- ������� �����
create table `#__te_settlements_country_capitals`
(
   `settlement_country_id` int not null auto_increment,
   `settlement_id`         int not null,
   `country_id`            int not null,
   primary key (`settlement_country_id`),
   unique (`settlement_id`,`country_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_settlements_country_capitals` add constraint `#__te_FK_settlements_country_capitals_settlement` foreign key (`settlement_id`)
      references `#__te_settlements` (`settlement_id`) on delete restrict on update restrict;

alter table `#__te_settlements_country_capitals` add constraint `#__te_FK_settlements__country_capitals_country` foreign key (`country_id`)
      references `#__te_countries` (`country_id`) on delete restrict on update restrict;


-- ������� ��������
create table `#__te_settlements_region_capitals`
(
   `settlement_region_id`  int not null auto_increment,
   `settlement_id`         int not null,
   `region_id`             int not null,
   `settlement_is_region`  int not null, -- 1, ���� ����� � ���� ��� ������ �������� ������, �������� ������ 
   primary key (`settlement_region_id`),
   unique (`settlement_id`,`region_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_settlements_country_capitals` add constraint `#__te_FK_settlements_country_capitals_settlement` foreign key (`settlement_id`)
      references `#__te_settlements` (`settlement_id`) on delete restrict on update restrict;

alter table `#__te_settlements_country_capitals` add constraint `#__te_FK_settlements__country_capitals_country` foreign key (`country_id`)
      references `#__te_countries` (`country_id`) on delete restrict on update restrict;



-- ----------------------------------------------------
-- ������� ����� (����)

create table `#__te_points`
(
   `point_id`              int not null,
   `point_subtype`         int not null,
   `point_subregion`       int not null,
   `point_settlement`      int not null,
   `point_settlement_dist` int not null,  -- ���������� �� ����������� ������ � ��, 0 ���� �� ��� ���������� 
   `point_name`            varchar(255) not null,
   `point_name_rod`        varchar(255) not null, -- �������� � ����������� ������
   `point_alias`           varchar(255) not null unique,
   `point_lat`             double(10,6) not null, -- ������
   `point_lon`             double(10,6) not null, -- �������
   `point_descr`           mediumtext,
   `point_parent`          int default null,
   primary key (`point_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_points` add constraint `#__te_FK_Reference_3` foreign key (`point_subtype`)
      references `#__te_point_subtypes` (`point_subtype_id`) on delete restrict on update restrict;

alter table `#__te_points` add constraint `#__te_FK_points_subregions` foreign key (`point_subregion`)
      references `#__te_subregions` (`subregion_id`) on delete restrict on update restrict;

alter table `#__te_points` add constraint `#__te_FK_points_settlements` foreign key (`point_settlement`)
      references `#__te_settlements` (`settlement_id`) on delete restrict on update restrict;

alter table `#__te_points` add constraint `#__te_FK_points_parent` foreign key (`point_parent`)
      references `#__te_points` (`point_id`) on delete restrict on update restrict;



-- ������ ����� ������ ����� ("������ ������", "����� � ��")
create table `#__te_points_link_classes`
(
   `link_class_id`          int not null,
   `link_class_pre_label`    varchar(255) not null,
   `link_class_link_label`   varchar(255) not null,
   `link_class_post_label`   varchar(255) not null,
   `link_class_incl_point`  int not null, -- 0 - �� �������� �������� �����, 1 - �������� � ������������ ������, 2 - � ����������� 
   `link_class_sitelink`    varchar(255) not null, -- ����������� ����, �������� "��"
   `link_class_alias`       varchar(255) not null unique,
   primary key (`link_class_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- ���� ����������� �������� (����������, �����, ��������,...)
create table `#__te_visual_content_types`
(
   `content_type_id`         int not null,
   `content_type_name`       varchar(255) not null,
   `content_type_descr`      varchar(511) not null,
   `content_type_alias`      varchar(255) not null,
   primary key (`content_type_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;



-- ���� ������ ����� ("���. ����", "�������� � ���������", "���� � �� ������� �������")
create table `#__te_points_link_types`
(
   `link_type_id`           int not null,
   `link_type_class`        int not null,
   `link_type_pre_label`    varchar(255) not null,
   `link_type_link_label`   varchar(255) not null,
   `link_type_post_label`   varchar(255) not null,
   `link_type_incl_point`   int not null, -- 0 - �� �������� �������� �����, 1 - �������� � ������������ ������, 2 - � ����������� 
   `link_type_sitelink`     varchar(255) not null, -- ����� ���� ��� ����� ���� ������, �������� ���������, ����� �� �������
   `link_type_alias`        varchar(255) not null unique,
   `link_type_content_type` int not null default 1, -- ��� ����������� ��������, ��� ������ �����������, �� ��������� 1 - ����
   primary key (`link_type_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_points_link_types` add constraint `#__te_points_link_types_classes` foreign key (`link_type_class`)
      references `#__te_points_link_classes` (`link_class_id`) on delete restrict on update restrict;

alter table `#__te_points_link_types` add constraint `#__te_points_link_types_content` foreign key (`link_type_content_type`)
      references `#__te_visual_content_types` (`content_type_id`) on delete restrict on update restrict;



-- ������ �����
create table `#__te_points_links`
(
   `points_links_id`      int not null auto_increment,
   `link_type`            int not null,
   `link_point`           int not null,
   `link_label`           varchar(255) not null,
   `link_link`            varchar(255) not null,
   primary key (`points_links_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_points_links` add constraint `#__te_points_links_type` foreign key (`link_type`)
      references `#__te_points_link_types` (`link_type_id`) on delete restrict on update restrict;

alter table `#__te_points_links` add constraint `#__te_points_links_point` foreign key (`link_point`)
      references `#__te_points` (`point_id`) on delete restrict on update restrict;


-- ����� �� "������" ����� � �������
create table `#__te_points_posts`
(
   `post_article_point_id` int(10) unsigned not null auto_increment,
   `post_article`          int(10) unsigned not null,
   `post_menuitem`         int(10) unsigned not null,
   `post_point`            int not null,
   primary key (`post_article_point_id`),
   unique (`post_article`,`post_point`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_points_posts` add constraint `#__te_points_posts_article` foreign key (`post_article`)
      references `#__content` (`id`) on delete restrict on update restrict;

alter table `#__te_points_posts` add constraint `#__te_points_posts_point` foreign key (`post_point`)
      references `#__te_points` (`point_id`) on delete restrict on update restrict;


-- ����� ���� ���� ���������� �����
create table `#__te_photos`
(
   `photo_id`           int not null,
   `photo_name`         varchar(255) not null,
   `photo_path`         varchar(255) not null, 
   `photo_lat`          double(10,6) not null, -- ������
   `photo_lon`          double(10,6) not null, -- �������
   primary key (`photo_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- ���� �� "������" ����� � �������
create table `#__te_points_photos`
(
   `point_order_id`     int not null auto_increment,
   `point_id`           int not null,
   `photo_order`        int not null, -- ���������� ����� ����� ���������� ����� �����
   `photo_id`           int not null,
   primary key (`point_order_id`),
   unique (`point_id`,`photo_order`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_points_photos` add constraint `#__te_points_photos_photo` foreign key (`photo_id`)
      references `#__te_photos` (`photo_id`) on delete restrict on update restrict;

alter table `#__te_points_photos` add constraint `#__te_points_photos_point` foreign key (`point_id`)
      references `#__te_points` (`point_id`) on delete restrict on update restrict;


-- ���� (��� ������ ���������� �������) �� ������� ����� (��� ������) � �������
create table `#__te_points_link_photos`
(
   `point_link_photo_id` int not null auto_increment,
   `point_id`            int not null,
   `link_photo_order`    int not null, -- ���������� ����� ����� ���������� ����� �����
   `link_type`           int not null,
   `link_photo_name`     varchar(255) not null, 
   `link_photo_path`     varchar(255) not null, 
   `link_iframe_src`     varchar(255) not null, 
   primary key (`point_link_photo_id`),
   unique (`point_id`,`link_photo_order`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_points_link_photos` add constraint `#__te_points_link_photos_type` foreign key (`link_type`)
      references `#__te_points_link_types` (`link_type_id`) on delete restrict on update restrict;

alter table `#__te_points_link_photos` add constraint `#__te_points_link_photos_point` foreign key (`point_id`)
      references `#__te_points` (`point_id`) on delete restrict on update restrict;


-- ������� ��� �������� ��������� �������-����� ���������������������� � �����-��������
create table `#__te_class_type_country_region`
(
   `mix_id`             int not null auto_increment,
   `class_id`           int not null,
   `country_id`         int not null,
   `region_id`          int not null,
   `type_id`            int not null,
   `short_descr`        varchar(255) not null,
   `long_descr`         mediumtext not null,
   primary key (`mix_id`),
   unique (`class_id`,`country_id`,`region_id`,`type_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;




-- ----------------------------------------------------
-- ���� ������, ����������� ���������������� � ������� (������� � �������)

-- ������ �������
create table `#__te_trip_stages`
(
   `trip_stage_id`              int not null,
   `trip_stage_name`            varchar(255) not null, 
   `trip_stage_points_label`    varchar(255) not null, 
   primary key (`trip_stage_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- �������
create table `#__te_trips`
(
   `trip_id`           int not null,
   `trip_stage`        int not null,
   `trip_name`         varchar(255) not null, 
   `trip_alias`        varchar(255) not null, 
   `trip_descr`        varchar(511) not null, 
   `trip_start_date`   date default null, 
   primary key (`trip_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_trips` add constraint `#__te_trips_stages` foreign key (`trip_stage`)
      references `#__te_trip_stages` (`trip_stage_id`) on delete restrict on update restrict;

-- ���������������
create table `#__te_travelers`
(
   `traveler_id`      int not null,
   `traveler_name`    varchar(255) not null, 
   primary key (`traveler_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- ��������������� � ��������
create table `#__te_travelers_trips`
(
   `trip_traveler_id`  int not null auto_increment,
   `trip_id`           int not null,
   `traveler_id`       int not null,
   primary key (`trip_traveler_id`),
   unique (`trip_id`,`traveler_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_travelers_trips` add constraint `#__te_travelers_trips_trip` foreign key (`trip_id`)
      references `#__te_trips` (`trip_id`) on delete restrict on update restrict;

alter table `#__te_travelers_trips` add constraint `#__te_travelers_trips_traveler` foreign key (`traveler_id`)
      references `#__te_travelers` (`traveler_id`) on delete restrict on update restrict;


-- ����� ������� (��� �������� ������� � ��� - ��� ������ ����)
create table `#__te_points_trips`
(
   `trip_point_id` int not null auto_increment,
   `trip_id`       int not null,
   `point_id`      int not null,
   primary key (`trip_point_id`),
   unique (`trip_id`,`point_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_points_trips` add constraint `#__te_points_trips_trip` foreign key (`trip_id`)
      references `#__te_trips` (`trip_id`) on delete restrict on update restrict;

alter table `#__te_points_trips` add constraint `#__te_points_trips_point` foreign key (`point_id`)
      references `#__te_points` (`point_id`) on delete restrict on update restrict;


-- ����� ������� � �������� � ������
create table `#__te_points_trips_plan`
(
   `trip_point_order_id` int not null auto_increment,
   `trip_id`             int not null,
   `point_id`            int not null,
   `point_order`         int not null,
   `day_number`          int not null,
   `arrival_date`        datetime default null,
   `depature_date`       datetime default null,
   `point_comment`       varchar(511) default null,
   primary key (`trip_point_order_id`),
   unique (`trip_id`,`point_id`,`point_order`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_points_trips_plan` add constraint `#__te_points_trips_pt` foreign key (`trip_id`, `point_id`)
      references `#__te_points_trips` (`trip_id`, `point_id`) on delete restrict on update restrict;

-- ����� ���������� � ��������
create table `#__te_trips_stay_points`
(
   `trip_stay_point_id` int not null auto_increment,
   `trip_id`            int not null,
   `stay_point_order`   int not null, -- from '1'
   `stay_point_id`      int not null,
   `nights_to_stay`     int not null,
   `arrival_date`       datetime default null,
   `depature_date`      datetime default null,
   `stay_point_comment` varchar(511) default null,
   primary key (`trip_stay_point_id`),
   unique (`trip_id`,`stay_point_order`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_trips_stay_points` add constraint `#__te_trips_stay_points_trip` foreign key (`trip_id`)
      references `#__te_trips` (`trip_id`) on delete restrict on update restrict;

alter table `#__te_trips_stay_points` add constraint `#__te_trips_stay_points_point` foreign key (`stay_point_id`)
      references `#__te_points` (`point_id`) on delete restrict on update restrict;


-- ����������� � ��������. ����������� - �����������
create table `#__te_trips_moves`
(
   `trip_trip_move_id`       int not null auto_increment,
   `trip_id`                 int not null,
   `trip_move_id`            int not null,
   `start_stay_point_order`  int not null,
   `end_stay_point_order`    int not null,
   `trip_move_name`          varchar(255) not null,
   `trip_move_comment`       varchar(511) default null,
   primary key (`trip_trip_move_id`),
   unique (`trip_id`,`trip_move_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ���� ����� ����� (���������) ����������� � ��������
create table `#__te_trips_move_options_types`
(
   `move_option_type_id`    int not null,
   `move_option_type_name`  varchar(255) default null,
   `move_option_type_descr` varchar(511) default null,
   primary key (`move_option_type_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- ������ ����� (��������) ����������� � ��������
create table `#__te_trips_moves_options`
(
   `trip_trip_move_option_id`  int not null auto_increment,
   `trip_id`                   int not null,
   `trip_move_id`              int not null,
   `trip_move_option_id`       int not null,
   `trip_move_option_type_id`  int not null,
   `trip_move_option_comment`  varchar(511) default null,
   primary key (`trip_trip_move_option_id`),
   unique (`trip_id`,`trip_move_id`,`trip_move_option_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ����� � ������� (���������) ����������� � ��������
create table `#__te_trips_moves_options_points`
(
   `trip_move_option_point_id` int not null auto_increment,
   `trip_id`                   int not null,
   `trip_move_id`              int not null,
   `trip_move_option_id`       int not null,
   `trip_move_point_id`        int not null,
   `trip_move_point_comment`   varchar(511) default null,
   primary key (`trip_move_option_point_id`),
   unique (`trip_id`,`trip_move_id`,`trip_move_option_id`,`trip_move_point_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;


-- ��������� �����
create table `#__te_textlabels`
(
   `sitename_label`        varchar(255) not null,
   `settlement_label`      varchar(255) not null,
   `settlement_near_label` varchar(255) not null,
   `km_label`              varchar(255) not null,
   `settlement_type_label` varchar(255) not null,
   `country_label`         varchar(255) not null,
   `countries_label`       varchar(255) not null,
   `place_label`           varchar(255) not null,
   `this_label`            varchar(255) not null,
   `type_label`            varchar(255) not null,
   `subtype_label`         varchar(255) not null,
   `posts_label`           varchar(255) not null,
   `links_label`           varchar(255) not null,
   `coord_label`           varchar(255) not null,
   `onmap_label`           varchar(255) not null,
   `parentpoint_label`     varchar(255) not null,
   `childpoints_label`     varchar(255) not null,
   `sisterpoints_label`    varchar(255) not null,
   `start_date_label`      varchar(255) not null,
   `stage_label`           varchar(255) not null,
   `bytypes_label`         varchar(255) not null,
   `byclasses_label`       varchar(255) not null,
   `byregions_label`       varchar(255) not null,
   `bycountries_label`     varchar(255) not null,
   `fulllist_label`        varchar(255) not null,
   `on_label`              varchar(255) not null
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

SET NAMES cp1251 ;

-- ��������� ��������� �����
INSERT INTO `#__te_textlabels` (`sitename_label`,`km_label`,`settlement_label`,  `settlement_near_label`,       `country_label`,`countries_label`,`place_label`,   `this_label`,`type_label`,`subtype_label`,`links_label`,`posts_label`,`coord_label`, `onmap_label`, `parentpoint_label`,                  `childpoints_label`,                   `sisterpoints_label`,                        `start_date_label`,`stage_label`,`byclasses_label`,`bytypes_label`,`byregions_label`,`bycountries_label`,`fulllist_label`,`on_label`) 
                        VALUES ('altman.kiev.ua','��',      '���������� �����: ','��������� ���������� �����: ','������: ',     '������',         '��������������','',          '���: ',     '������ ���: ', '������',     '����� �� ',  '����������',' �� �����',     '��� ����� ��������� �� ����������: ','�� ���������� ����� ����� ���������:','����� �� ���� �� ���������� ��� ���������:','���� ������',     '������',     '�� �����'       ,'�� �����'     ,'�� ��������'    ,'�� �������'       ,'������ ������' ,' �� ');

-- ���� ����������� ��������
INSERT INTO `#__te_visual_content_types` (`content_type_id`,`content_type_name`,`content_type_descr`,`content_type_alias`) VALUES (1,'����','','photo') ;
INSERT INTO `#__te_visual_content_types` (`content_type_id`,`content_type_name`,`content_type_descr`,`content_type_alias`) VALUES (2,'��������','','panorama') ;
INSERT INTO `#__te_visual_content_types` (`content_type_id`,`content_type_name`,`content_type_descr`,`content_type_alias`) VALUES (3,'�����','','video') ;

-- ��������� ����� "�������� �������" � ��� ����������� ����-������
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (1,'���������������������','���������������������','attraction','attractions') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (1,1,'�����, ������, ��������, ���������','�����, ������, �������� � ���������','castle');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (1,1,'��������','fortress');
INSERT INTO `#__te_continents`(`continent_id`,`continent_name`,`continent_alias`) VALUES (1,'������','europe') ;
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (1,1,'��������','��������','germany') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (1,'����������� �����','���������������� �����','�������','���������������� �����') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (1,1,'������','�������','berlin') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (1,1,'�������','spandau') ;
INSERT INTO `#__te_settlement_types`(`settlement_type_id`,`settlement_type_name`,`settlement_type_alias`) VALUES (1,'�����','town') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (1,1,'������','berlin') ;
INSERT INTO `#__te_settlements_country_capitals`(`settlement_id`,`country_id`) VALUES (1,1) ;
INSERT INTO `#__te_settlements_region_capitals`(`settlement_id`,`region_id`,`settlement_is_region`) VALUES (1,1,1) ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,      `point_name_rod`,  `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (1,          1,              1,                1,                 0,                     '�������� �������','�������� �������','spandaufortress','52.540984','13.213581','������� ��������, ������ ������������� � ������ �������, � ����� ������������� ������� � ������� ������ �������� ��������� ���������������������� ������������ ������ �������');
INSERT INTO `#__te_points_link_classes` (`link_class_id`,`link_class_pre_label`,`link_class_link_label`,`link_class_post_label`,`link_class_incl_point`,`link_class_sitelink`,`link_class_alias`) VALUES (1,'����� ��� ','����� �������',' � ',1,'http://livejournal.com','ljlinks') ;
INSERT INTO `#__te_points_link_classes` (`link_class_id`,`link_class_pre_label`,`link_class_link_label`,`link_class_post_label`,`link_class_incl_point`,`link_class_sitelink`,`link_class_alias`) VALUES (2,'���������� � ','Flickr',' �� ',1,'http://www.flickr.com','flickrlinks') ;
INSERT INTO `#__te_points_link_classes` (`link_class_id`,`link_class_pre_label`,`link_class_link_label`,`link_class_post_label`,`link_class_incl_point`,`link_class_sitelink`,`link_class_alias`) VALUES (3,'����� ��� ','���������� �������.��',' � ',1,'http://turbina.ru','turbinalinks') ;
INSERT INTO `#__te_points_link_classes` (`link_class_id`,`link_class_pre_label`,`link_class_link_label`,`link_class_post_label`,`link_class_incl_point`,`link_class_sitelink`,`link_class_alias`) VALUES (100,'������ ������','','',0,'','otherlinks') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (1,1,'���� ','�� "���������� �������" tanya_abramova',' � ',0,'http://tanya-abramova.livejournal.com/','lj_abramova') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (2,100,'����������� ���� ','','',2,'','official') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (3,100,'�������� ','',' � ���������',2,'','wikipedia') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (4,1,'���� ','�� "� ���� ������ � �� ������" jjvs',' � ',0,'http://jjvs.livejournal.com/','lj_jjvs') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (5,1,'���� ','�� "�������������� �����������. ��������� ���� ������� ���������" gavailer',' � ',0,'http://gavailer.livejournal.com/','lj_gavailer') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (6,1,'���� ','�� "Frank Booth" f_booth',' � ',0,'http://f_booth.livejournal.com/','lj_f_booth') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (7,100,'','allcastle',' �� ',1,'http://allcastle.info/','allcastle') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (1,1,'"������� � ��������"','http://tanya-abramova.livejournal.com/222504.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,1,'','http://www.zitadelle-spandau.de/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,1,'','http://ru.wikipedia.org/wiki/%D0%A6%D0%B8%D1%82%D0%B0%D0%B4%D0%B5%D0%BB%D1%8C_%D0%A8%D0%BF%D0%B0%D0%BD%D0%B4%D0%B0%D1%83') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (4,1,'"�������� �������, ������"','http://jjvs.livejournal.com/1852.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (5,1,'"��� �������� ��������"','http://gavailer.livejournal.com/154269.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (6,1,'"��������-�������� �������"','http://f-booth.livejournal.com/80652.html') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (117,603,1) ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (1,'������ �������� ������� � �������','2011_08_14_germany/citadel/IMG_6555_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (1,0,1) ;

-- ������������
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (2,1,'�����','castle');
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (2,1,'�������','�������','bayern') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (2,2,'��������� ������','ostallgau') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (2,1,'������','fussen') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,  `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (2,          2,              2,                2,                 4,                     '������������','����� ������������','neuschwanstein','47.557994','10.749875','����� ���������� �� ������, ����������� "�������� �������" �������� ������ ���������. ��������� ������������ ������������� �����, ����� �� ������ ���� (�� ������ �������, �������)');
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (138,603,2) ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,2,'','http://ru.wikipedia.org/wiki/%D0%9D%D0%BE%D0%B9%D1%88%D0%B2%D0%B0%D0%BD%D1%88%D1%82%D0%B0%D0%B9%D0%BD') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,2,'','http://www.neuschwanstein.de/index.htm') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (7,2,'','http://allcastle.info/europe/germany/001') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (8,1,'���� ','�� "���� ��� ����� - 2" masterok',' � ',0,'http://masterok.livejournal.com/','lj_masterok') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (8,2,'"������ � ����� ��������: ������������ (Neuschwanstein Castle)"','http://masterok.livejournal.com/210510.html') ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (2,'����� ������������ ��� � ����� �����������','2011_08_14_germany/neuschwanstein/IMG_7852_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (2,0,2) ;

-- ���������� �����
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (2,1,'���������','���������','swiss') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`region_nikname_rod`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (2,'������','�������','�����','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (3,2,'��','��','vaud') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (3,3,'����','vevey') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (3,1,'�����','montreux') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,`point_lat`, `point_lon`,   `point_descr`) 
                    VALUES (3,          2,              3,                3,                 3,                     '���������� �����','����������� �����','chillon',  '46.414196','6.927513','��������� ����������� ����� �� ��������� �����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,3,'','http://ru.wikipedia.org/wiki/%D0%A8%D0%B8%D0%BB%D1%8C%D0%BE%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%B7%D0%B0%D0%BC%D0%BE%D0%BA') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,3,'','http://www.chillon.ch/en/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (7,3,'','http://allcastle.info/europe/swiss/001') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (3,0,7,'���������� �����','http://allcastle.info/assets/images/foto/81-1.jpg') ;

-- ���-���-������
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (3,1,'�������','�������','france') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (3,'������','�����������','������������ �������','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (4,3,'������ ���������','������ ���������','bassenormandie') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (4,4,'����','manche') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (4,1,'������','avranches') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (4,          1,              4,                4,                 26,                    '���-���-������','���-���-������','montsaintmichel',  '48.635561','-1.510611',  '��������-��������� �� ������ ������� �� �������-�����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,4,'','http://ru.wikipedia.org/wiki/%D0%9C%D0%BE%D0%BD-%D0%A1%D0%B5%D0%BD-%D0%9C%D0%B8%D1%88%D0%B5%D0%BB%D1%8C') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,4,'','http://www.au-mont-saint-michel.com/en/mont_st_michel.htm') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (7,4,'','http://allcastle.info/europe/france/007') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (9,1,'���� ','�� "Andreev.org - ������������ �����������"',' � ',0,'http://andreev-org.livejournal.com/','lj_andreevorg') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (9,4,'"�������: ����� ���-���-������. ������������"','http://andreev-org.livejournal.com/63705.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (4,0,9,'������� ��� �� ���-���-������','http://www.andreev.org/engine/uploaded/images//2012/06/238FRA.jpg') ;

-- ���������
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (5,3,'��-�������','��-�������','midipyrenees') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (5,5,'���','lot') ;
INSERT INTO `#__te_settlement_types`(`settlement_type_id`,`settlement_type_name`,`settlement_type_alias`) VALUES (2,'�������','hamlet') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (5,2,'���������','rocamadour') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (2,1,'������ �����, ������������ �����, ������ �������', '������ ������, ������������ ������, ������ �������','oldtown');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (3,2,'������ �������','oldhamlet');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (5,          3,              5,                5,                 0,                      '���������','����������','rocamadour',  '44.799191','1.617694',  '������������ ���� ������� �� ��� �������. ����� ��� �����, ���� ����������� �� �������� �����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,5,'','http://uk.wikipedia.org/wiki/%D0%A0%D0%BE%D0%BA%D0%B0%D0%BC%D0%B0%D0%B4%D1%83%D1%80') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,5,'','http://www.rocamadour.com/en') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (10,100,'','panoramix.ru',' �� ',1,'http://www.panoramix.ru/','panoramixru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (10,5,'','http://www.panoramix.ru/france/rocamadour/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (11,1,'���� ','�� "������ �������, ��������" fotografersha',' � ',0,'http://fotografersha.livejournal.com/','lj_fotografersha') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (11,5,'"���������"','http://fotografersha.livejournal.com/236893.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (5,0,11,'���������, ����� ���','http://img-fotki.yandex.ru/get/6106/414616.c0/0_8a951_fbd8d545_XXL') ;

-- ���������
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (6,3,'�����������������','�����������������','languedocroussillon') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (6,6,'��','aude') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (6,1,'���������','�arcassonne') ;
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (4,2,'������ �����','oldtown');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (6,          4,              6,                6,                 0,                     '���������','����������','carcassonne',  '43.206568','2.36485',  '������ ����������� ����� �� �������������, ���������� ����� ������ ����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,6,'','http://ru.wikipedia.org/wiki/%D0%9A%D0%B0%D1%80%D0%BA%D0%B0%D1%81%D0%BE%D0%BD') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,6,'','http://www.carcassonne-tourisme.com/carcassonne_EN.nsf/vuetitre/docpgeIntroVisiter') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (12,1,'���� ','�� "�����" jengibre',' � ',0,'http://jengibre.livejournal.com/','lj_jengibre') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (12,6,'"�������-2012, ���������"','http://jengibre.livejournal.com/272933.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (19,2,'���������� ','Jaume CP BCN\'s photostream',' � ����� ',1,'http://www.flickr.com/photos/jaumebcn','flickr_jaumebcn') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,6,'El Conflent i el Rosello','http://www.flickr.com/photos/jaumebcn/sets/72157631620572211/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (20,2,'�������� ����� ','Flickr places',' �� ',1,'http://www.flickr.com/places','flickr_places') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (20,6,'Carcassonne','http://www.flickr.com/places/France/Languedoc-Roussillon/Carcassonne') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (6,0,19,'Carcassonne','http://farm9.staticflickr.com/8182/8025875831_d90b988556_b.jpg') ;


-- �����
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (7,3,'�������','�������','bretagne') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (7,7,'���-������','cotesdarmor') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (7,1,'�����','Dinan') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (7,          4,              7,                7,                 0,                     '�����','������','dinan',  '48.450304','-2.043511',  '��������� ������������� �����, �����, ������� ���������� �����, ����, ������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,7,'','http://ru.wikipedia.org/wiki/%D0%94%D0%B8%D0%BD%D0%B0%D0%BD_%28%D0%A4%D1%80%D0%B0%D0%BD%D1%86%D0%B8%D1%8F%29') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,7,'','http://www.mairie-dinan.com/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (12,7,'"�������-2009, �����"','http://jengibre.livejournal.com/271114.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (13,1,'���� ','�� "� � ����� ������� ���� �� ����," yuljok',' � ',0,'http://yuljok.livejournal.com/','lj_yuljok') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (13,7,'"�������-2008. �����."','http://yuljok.livejournal.com/78270.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (14,1,'���� ','�� "��������� ��������������� �� ������� � �� ������" dona-anna',' � ',0,'http://dona-anna.livejournal.com/','lj_donaanna') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (14,7,'"�����: ����������� ����:)"','http://dona-anna.livejournal.com/615788.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (7,0,14,'�����, ��� �� ���� � ��������� �����','http://images54.fotki.com/v627/photos/6/869496/9765840/IMGP1205-vi.jpg') ;

-- �����
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (8,7,'��� � �����','illeetvilaine') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (8,1,'�����','fougeres') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (8,          2,              8,                8,                 0,                     '����� �����','����� �����','fougeres',  '48.354053','-1.209306',  '������� ������������� �������� � ��������� ������ ����� (��� � �������� � ������������ �������� "����������", ��� ��� ������ ����� ����� � �������� ��� ���� ����)');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,8,'','http://ru.wikipedia.org/wiki/%D0%A4%D1%83%D0%B6%D0%B5%D1%80_%28%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%29') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,8,'','http://www.chateau-fougeres.com/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (15,1,'���� ','�� "������� �� ������" smarty-yulia',' � ',0,'http://smarty-yulia.livejournal.com/','lj_smartyyulia') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (15,8,'"�������: �������, �����"','http://smarty-yulia.livejournal.com/172671.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (8,0,15,'����� �����, ��� �������','http://i632.photobucket.com/albums/uu41/Smartyyulia/Paris/2011/2011_04_01_Vitre_Fuger/IMG_2732.jpg') ;

-- ������
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (4,1,'��������','��������','croatia') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`region_nikname_rod`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (4,'�������','�������','����� ��� ������','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (8,4,'����������','����������','istriana') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (9,8,'������','rovinge') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (9,1,'������','rovinge') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (9,          4,              9,                9,                 0,                    '������','������','rovinge',  '45.082847','13.632081',  '����� �� ��������� � �������� �� ���������� ����������� ������. ������ ����� ������ ����������� �� ����������� �������� �����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,9,'','http://ru.wikipedia.org/wiki/%D0%A0%D0%BE%D0%B2%D0%B8%D0%BD%D1%8C') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,9,'','http://www.rovinj.hr/rovinj/index.php') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (16,1,'���� ','�� "���������������" powerk',' � ',0,'http://powerk.livejournal.com/','lj_powerk') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (16,9,'"������."','http://powerk.livejournal.com/38454.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (9,0,16,'��� �� ������','http://ic.pics.livejournal.com/powerk/11024191/636284/original.jpg') ;

-- ��������
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (5,1,'���������','monastery');
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (9,3,'����� �����','������ �����','paysdelaloire') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (10,9,'��� � �����','maineetloire') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (10,1,'��������-�\'����','fontevraudlabbaye') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (10,         5,              10,               10,                0,                     '��������� ��������','��������� ��������','fontevraud',  '47.181334','0.051069',  '����������� ��������� ��������, �������� ������������ ��������, ���� �� ����� ���������� �� ���� �������. �������� ������������� ���������, ���� ���������� ��� iOS � Android');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,10,'','http://ru.wikipedia.org/wiki/%D0%A4%D0%BE%D0%BD%D1%82%D0%B5%D0%B2%D1%80%D0%BE') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,10,'','http://www.abbayedefontevraud.com/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (17,100,'','����� ������ ����� loire-chateaux.ru',' �� ����� ',1,'http://loire-chateaux.ru/','loirechateaux') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (17,10,'','http://loire-chateaux.ru/19-Zamkov-/Abbatstvo-Fontevraud.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (18,2,'���������� ','marc.alhadeff\'s photostream',' �� ����� ',1,'http://www.flickr.com/photos/alhadeff/','flickr_alhadeff') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (18,10,'2012-04 Abbaye de Fontevraud','http://www.flickr.com/photos/alhadeff/sets/72157629464262770/with/6937116850/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (10,0,18,'Abbaye de Fontevraud-023-Modifier','http://farm8.staticflickr.com/7179/6937116850_a9375eac89_b.jpg') ;

-- ��������� ������� ������� � ������
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (11,6,'��������� �������','pyreneesorientales') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (11,2,'������','�asteil') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                        `point_name_rod`,                    `point_alias`,      `point_lat`,`point_lon`, `point_descr`) 
                    VALUES (11,         5,              11,               11,                1,                     '��������� ������� ������� � ������','��������� ������� ������� � ������','stmartinducanigou','42.52814', '2.400979',  '��������� � ����� �� ������� �� ������� � ��������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,11,'','http://en.wikipedia.org/wiki/Martin-du-Canigou') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,11,'','http://stmartinducanigou.org/index_UK.php') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,11,'El Conflent i el Rosello','http://www.flickr.com/photos/jaumebcn/sets/72157631620572211/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (11,0,19,'Abadia de Sant Marti del Canigo','http://farm9.staticflickr.com/8042/8029125032_ee52b55b7b_h.jpg') ;


-- ��-���-�����
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (10,3,'���������','���������','aquitania') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (12,10,'�������','dordogne') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (12,2,'��-���-�����','laroquegageac') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                        `point_name_rod`,                    `point_alias`,      `point_lat`,`point_lon`, `point_descr`) 
                    VALUES (12,         3,              12,               12,                0,                     '��-���-�����','��-���-�����','laroquegageac','44.826649', '1.181599',  '�������, ��������� �� ����� �����, � ����� ������ �������� �����, � ������ - ����. ���������� �������, ����� ��������� �� �������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,12,'','http://en.wikipedia.org/wiki/La_Roque-Gageac') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,12,' � ����� laroquegageac','http://www.flickr.com/photos/jaumebcn/tags/laroquegageac/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (14,12,'������� la Roque Gageac - ���� ����� � ��� ���:)','http://dona-anna.livejournal.com/34819.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (21,100,'','����� ���������� �������������� ����������� ��������',' �� ',1,'http://www.france-beautiful-villages.org','francebeautifulvillages') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (21,12,'','http://www.france-beautiful-villages.org/en/la-roque-gageac') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (12,0,19,'La Roque-Gageac','http://farm9.staticflickr.com/8462/8022609750_8eb30cb3e8_b.jpg') ;

-- ������-�-�������
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (13,2,'������-�-�������','beynacetcazenac') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                        `point_name_rod`,                    `point_alias`,      `point_lat`,`point_lon`, `point_descr`) 
                    VALUES (13,         3,              12,               13,                0,                     '������-�-�������','������-�-�������','beynacetcazenac','44.839712', '1.143748',  '�������� ������� � �������� ����� ������ �� ���� �������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,13,'','http://en.wikipedia.org/wiki/Beynac-et-Cazenac') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,13,' � ����� beynacetcazenac','http://www.flickr.com/photos/jaumebcn/tags/beynacetcazenac/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (21,13,'','http://www.france-beautiful-villages.org/en/beynac-et-cazenac') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (22,1,'���� ','�� "����� � ����" alla-hobbit',' � ',0,'http://alla-hobbit.livejournal.com/','lj_allahobbit') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (22,13,'������� - ������� - ����� ������-��-������� (Chateau de Beynac-et-Cazenac)','http://alla-hobbit.livejournal.com/331174.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (13,0,19,'Beynac-et-Cazenac','http://farm9.staticflickr.com/8172/7995241293_0936d8d365_b.jpg') ;

-- ����� ������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                        `point_name_rod`,                    `point_alias`,      `point_lat`,`point_lon`, `point_descr`, `point_parent`) 
                    VALUES (14,         2,              12,               13,                0,                     '����� ������','����� ������','beynaccastle','44.839712', '1.143748',  '���� �� ����� ���������� ������ �������. ��������� � �������� ��������� ������-�-�������. � ��� �������� �������� ����������� ����� "���������" � ����� ���� � ���������� ������',13);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,14,'','http://ru.wikipedia.org/wiki/%D0%97%D0%B0%D0%BC%D0%BE%D0%BA_%D0%91%D0%B5%D0%B9%D0%BD%D0%B0%D0%BA') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,14,' � ����� chateaudebeynac','http://www.flickr.com/photos/jaumebcn/tags/ch%C3%A2teaudebeynac/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (22,14,'������� - ������� - ����� ������-��-������� (Chateau de Beynac-et-Cazenac)','http://alla-hobbit.livejournal.com/331174.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (14,0,19,'Chateau de Beynac','http://farm9.staticflickr.com/8302/7984941121_4c48fe54d9_b.jpg') ;

-- ����� �������� ���
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (2,'����� ��� ����������','�����, ��������, �������','livingplace','livingplaces') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (3,2,'�����','�����','hotel');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (6,3,'���-�����, ��������� �����','spahotel');
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (5,1,'�������','�������','hungary') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (5,'������','�����','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (11,5,'�������-����������� ����','�������-������������ ����','nyugatdunantul') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (13,11,'���','vas') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (14,1,'���','buk') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (15,         6,              13,               14,                0,                     'Danubius Health Spa Resort Buk','Danubius Health Spa Resort Buk','danubiusbuk','47.38452','16.78565','��������� ���-����� �� ������ ������� � ��������� ������ ���');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,15,'','http://www.danubiushotels.com/en/our_hotels/hungary/bukfurdo/danubius_health_spa_resort_buk') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (23,100,'','booking.com',' �� ',1,'http://booking.com/','booking') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,15,'','http://www.booking.com/hotel/hu/buk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (15,0,23,'��� �� ����� Danubius Health Spa Resort Buk','http://r.bstatic.com/images/hotel/max600/113/11301254.jpg') ;

-- �������� (��������)
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (6,1,'��������','��������','slovakia') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`region_nikname_rod`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (6,'����','����','�����','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (12,6,'����������','�����������','presovsky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (14,12,'��������','bardejov') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (15,1,'��������','bardejov') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (16,         4,              14,               15,                0,                     '��������','��������','bardejov','49.292382','21.276226','��������� ����� �� ������ �������� �������� �� ������� � �������. �������� ��������� ����������� �������. ������ � ������ ���������� �������� ������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,16,'','http://www.bardejov.sk/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (24,100,'','������ �������� �������� �������� ������',' � ',1,'http://whc.unesco.org/en/list','unesco') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (24,16,'','http://whc.unesco.org/en/list/973') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (25,2,'���������� ','Miroslav Petrasko ',' � ����� ',1,'http://www.flickr.com/photos/theodevil/','flickr_theodevil') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (25,16,' � ����� bardejov','http://www.flickr.com/photos/theodevil/tags/bardejov/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`,`link_type_content_type`) VALUES (34,100,'�������� ','virtualtravel.sk',' �� ',1,'http://www.virtualtravel.sk/','virtualtravel_sk',2) ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (34,16,'','http://www.virtualtravel.sk/ru/preshov/bardejov/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (16,0,25,'Center of Bardejov','http://farm7.staticflickr.com/6141/5939590794_64f1f6856b_b.jpg') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (16,1,34,'By the Statue of St. Florian','http://www.virtualtravel.sk/ru/panorama/preshov/bardejov/historic-centre/by-the-statue-of-st-florian/','http://www.virtualtravel.sk/embed.php?pid=1602&lang=ru&x=670&y=450') ;

-- ���������� �����
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (15,12,'��������','kezmarok') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (16,1,'��������','kezmarok') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (17,         2,              15,               16,                0,                     '���������� �����','����������� �����','kezmarskyzamok','49.139906','20.433213','����������� ����� �� ������-������ �������� � ������� �������� (��� � �������� � ��������� �������� "������ �����")');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,17,'','http://www.kezmarok.com') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,17,'','http://ru.wikipedia.org/wiki/%D0%9A%D0%B5%D0%B6%D0%BC%D0%B0%D1%80%D1%81%D0%BA%D0%B8%D0%B9_%D0%B7%D0%B0%D0%BC%D0%BE%D0%BA') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (26,3,'���� ','���������� Nokola',' � ',1,'http://turbina.ru/authors/Nokola/','turbina_nokola') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (26,17,'���������� ����� �����','http://turbina.ru/guide/Kezhmarok-Slovakiya-125932/Zametki/Kezhmarskiy-zamok-zimoy-58033') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (17,0,26,'���������� �����','http://img4.tourbina.ru/photos.4/5/1/7/1/6/1461715/big.photo/Kezhmarskiy-zamok-zimoy.jpg') ;

-- �������� ����
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (13,6,'���������','����������','zilinsky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (16,13,'����� �����','dolnykubin') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (17,1,'����� �����','dolnykubin') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (18,         2,              16,               17,                8,                     '�������� ����','��������� �����','oravskyhrad','49.261717','19.359042','������� ����� ��������� ����� �� ���� ��������. �������, �� ������� �����, �����-�������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,18,'','http://www.oravamuzeum.sk/index.php/oravsky-hrad/fotogaleria') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,18,'','http://ru.wikipedia.org/wiki/%D0%9E%D1%80%D0%B0%D0%B2%D1%81%D0%BA%D0%B8%D0%B9_%D0%93%D1%80%D0%B0%D0%B4') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (27,100,'','���������.��',' �� ',1,'http://www.���������.��','zamkimira') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (27,18,'','http://www.���������.��/blog/oravskij_zamok/2012-09-20-110') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (18,0,27,'�������� �����','http://www.���������.��/foto/Slovensko/Oravsky/zamok_oravskij.jpg') ;

-- �������� ����
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (17,12,'������','levoca') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (18,1,'������� ���������','spisskepodhradie') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (19,         2,              17,               18,                1,                     '�������� ����','��������� �����','spisskyhrad','49.000021','20.768334','����� ������� ����� ��������, ������� � ������ ������. �������� ����������� �� ��� ���� ����� ����������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,19,'','http://www.spisskyhrad.sk/en.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,19,'','http://ru.wikipedia.org/wiki/%D0%A1%D0%BF%D0%B8%D1%88%D1%81%D0%BA%D0%B8%D0%B9_%D0%93%D1%80%D0%B0%D0%B4') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (19,0,3,'Spissky Hrad in Slovakia','http://upload.wikimedia.org/wikipedia/commons/8/8b/Spisska_nova_ves...castle.jpg') ;


-- ������ ��������
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (14,6,'����������������','�����������������','banskobystricky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (18,14,'������-��������','banskabystrica') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (19,1,'������-��������','banskabystrica') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (20,         4,              18,               19,                0,                     '������-��������','������-��������','banskabystrica','48.735531','19.146574','��������� ����� � ����� ������ ��������. ��������� ����� � ����� ������ ���������� �����. ���� ���� ���� �������� �����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,20,'','http://www.banskabystrica.sk/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,20,'','http://ru.wikipedia.org/wiki/%D0%91%D0%B0%D0%BD%D1%81%D0%BA%D0%B0-%D0%91%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%86%D0%B0') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (28,2,'���������� ','Robert.BlueSky\'s photostream',' � ����� ',1,'http://www.flickr.com/photos/robert-bluesky/','flickr_robertbluesky') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (28,20,' Slovakia - Banska Bystrica','http://www.flickr.com/photos/robert-bluesky/sets/72157605973673966') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (29,100,'','����������� �� ����� ����� all-voyage.ru',' �� ',1,'http://all-voyage.ru','allvoyageru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (29,20,'��������������������� ������ ��������','http://all-voyage.ru/dostoprimechatelnosti-banskoy-bystritcy.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (20,0,28,'vyhlad z Hodinovej Veze - nzmestie','http://farm4.staticflickr.com/3034/2686179330_4252dfcb89_b.jpg') ;

-- ��������� ����� � ������ ��������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (21,         2,              18,               19,                0,                     '��������� ����� "��������" � ������-��������','���������� ����� "��������" � ������-��������','banskabystricabarbakan','48.737272','19.147212','����� � ������ ������ ������ �������� � ����������� ����� ��������. ���������� ������ ���� IV, � ����� ������������. ������-�� "��������" - ��� �������� ���������� ����� � ����� ��� ��������, � ��-�� ��������� ��������� ������� ����� ������ ��� � ��������: ��������. ����� ���������� ���� ���������  � ������������ ������ ������� �������� � �������� ��� ������������ ������. ��� ��������� ���������, ������� ���������� ����� 13-�� ����, ���� ��������� � �������������� � 15-�� ��������. ����� ��������� ��������� ����� �����: ��� ��������, ��������� ������ � ��������� ����. �������� ������, ������ � ����������, ��������� � 1512-�� ����.  ����� ������ � 1761-��, ���� ����������� � ����� �������. ���������� "��������" ������, ����������� ������ �������, ��������� �������� ������ �� ������, ��� ������ �� ����. ������ ��� ����� ������� � ������ ������ ��������� ������, ����������� ��������� ������������ �������, ��� ���� � ��� �� ���������',20);
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (21,0,28,'vyhlad z Hodinovej Veze - barbakan','http://farm4.staticflickr.com/3076/2685384679_67490a3c57_b.jpg') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (21,1,34,'Mestsky hrad Barbakan','http://www.virtualtravel.sk/sk/panorama/banskobystricky-kraj/banska-bystrica/zaujimavosti-mesta/mestsky-hrad-barbakan/','http://www.virtualtravel.sk/embed.php?pid=1083&lang=ru&x=670&y=450') ;

-- �������� �������� � ��
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (3,'��������, ���, ����','��������� � ����','rbc','restaurants') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (4,3,'��������','���������','restaurant');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (7,4,'�������� ��������-����������� �����','easteuroperestaurant');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (22,         7,              18,               19,                0,                     '�������� "Barbakan" � ������-��������','��������� "Barbakan" � ������-��������','banskabystricabarbakanrestaurant','48.737272','19.147212','�������� ����� � ����� ��������� ����� "��������" � ������ ������ ������ ��������',21);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,22,'','http://www.bystrickybarbakan.sk/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (22,0,28,'vyhlad z Hodinovej Veze - barbakan','http://farm4.staticflickr.com/3076/2685384679_67490a3c57_b.jpg') ;

-- �������� ����� � ������ ��������
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (8,1,'�����','tower');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (23,         8,              18,               19,                0,                     '�������� ����� � ������ ��������','�������� �����  � ������-��������','leaningtowerbb','48.735959','19.146423','�� ����������� ������� ������ ������ �������� ("������ �������") ���� ���� �������� �����. ���, ������� ��, �� ��� �������� ��� ���������. ����������� �� ��������� ������ ����� �� 70��.',20);
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (23,0,28,'�������� ����� ������ �������� ��������','http://farm4.staticflickr.com/3185/2636571406_1a15544b31_b.jpg') ;

-- ����� Kuria � ������ ��������
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (9,3,'��������� �����','cityhotel');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (24,         9,              18,               19,                0,                     '����� "Kuria" � ������-��������','����� "Kuria"  � ������-��������','banskabystricakuria','48.737965','19.145372','�������������� ����� � ����� ������ ������ ��������, � ����� ��������� ��������, 100� �� ���������� ����',20);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,24,'','http://www.kuria.sk/index.php/en/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,24,'','http://www.booking.com/hotel/sk/penzion-kuria.ru.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (24,0,2,'����� kuria ������ �������� ��������','http://www.kuria.sk/images/phocagallery/exterier/thumbs/phoca_thumb_l_kuria_leto_den.jpg') ;


-- ���������� �����
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (19,14,'������','Zvolen') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (20,1,'������','Zvolen') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (25,         2,              19,               20,                0,                     '���������� �����','����������� �����','zvolencastle','48.573022','19.12739','����� � ������ ������ � ����������� ����� ��������. �������� ������� ������ ��������� I �������. ������� �� ��� ����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,25,'','http://ru.wikipedia.org/wiki/%D0%97%D0%B2%D0%BE%D0%BB%D0%B5%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%B7%D0%B0%D0%BC%D0%BE%D0%BA') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (30,100,'','����� ������ castlesguide.ru',' �� ����� ',1,'http://www.castlesguide.ru','castlesguideru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (30,25,'','http://www.castlesguide.ru/slovakia/zvolensky.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (31,2,'���������� ','Peter Fenda\'s photostream',' � ����� ',1,'http://www.flickr.com/photos/peterfenda/','flickr_peterfenda') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (25,0,31,'Zvolen Castle (Zvolensky zamok)','http://farm5.staticflickr.com/4132/5173783351_1d6b10f6fb_b.jpg') ;


-- ������ "��� ������" ��������
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (7,1,'�������','�������','ukraine') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`region_nikname_rod`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (7,'�������','�������','�����','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (15,7,'������������','������������','zakarpatskaya') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (20,15,'�����������','uzhgorodsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (21,2,'��������','nevitskoe') ;
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (10,3,'������','motel');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (26,         10,             20,               21,                0,                     '������ "��� ������"','������ "��� ������"','podzamkommotel','48.685089','22.403634','����������� ������ ��� ��������� � ���� ��������. ����� �������� ����� (���������������). ��������� �� ������ �� �������� � ����������� �������� "����� �������� - ����", ������ ���������� ����� ��������� �������');
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (32,100,'','doroga.ua',' �� ',1,'http://www.doroga.ua','dorogaua') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (32,26,'','http://www.doroga.ua/hotel/Zakarpatskaya/Nevickoe/Pod_zamkom/3399') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (26,0,32,'������ ��� ������ ��������','http://www.doroga.ua/Handlers/ContentImageHandler.ashx?CatalogHotelPhotoCatalogHotelID=3399&Size=Big') ;


-- ������������� ����
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (21,12,'����� �������','staralubovna') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (22,1,'����� �������','staralubovna') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (27,         2,             21,               22,                 0,                     '������������� ����','�������������� �����','lubovnianskyhrad','49.314775','20.698897','����� �� ����� ������ �������� � ������ ����� �������. ����� � ������ ���� ��� ����� ��� �������� �����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,27,'','http://www.muzeumsl.sk/en/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,27,'','http://ru.wikipedia.org/wiki/%D0%9B%D1%8E%D0%B1%D0%BE%D0%B2%D0%BD%D1%8C%D1%8F%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%93%D1%80%D0%B0%D0%B4') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (27,0,2,'������������� ���� �������� �����','http://files.muzeumsl.sk/200000633-101f61118d-public/03.jpg') ;

-- �������
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (22,12,'�������','humenne') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (23,1,'�������','humenne') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (28,         4,             22,               23,                 0,                     '�������','�������','humenne','48.933806','21.909893','��������� ����� �� ������� �������� �������� (50��) �� ������� � ��������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,28,'','http://www.humenne.sk/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,28,'','http://ru.wikipedia.org/wiki/%D0%93%D1%83%D0%BC%D0%B5%D0%BD%D0%BD%D0%B5') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (28,0,3,'������� �������� �����','http://upload.wikimedia.org/wikipedia/commons/d/d6/Humenn%C3%A9.castle.jpg') ;


-- �������� (������)
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (8,1,'������','������','turkey') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (8,'��','�����','������','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (16,8,'�����','�����','mugla') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (23,16,'��������','marmaris') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES ( 24,1,'��������','marmaris') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (29,         4,              23,               24,                0,                     '��������','���������',       'marmaris',     '36.852239','28.274893','�������������� ��������� ������� �� ���-������ ������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,29,'','http://ru.wikipedia.org/wiki/%D0%9C%D0%B0%D1%80%D0%BC%D0%B0%D1%80%D0%B8%D1%81') ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (3,'��� �� ����� ��������� � ��������','2012_04_29_turkey/marmaris/IMG_1490_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (29,0,3) ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (149,594,29) ;


-- �������
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (25,1,'�������','icmeler') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (30,         4,              23,               25,                0,                     '�������','��������','icmeler', '36.805299','28.232106','��������� ������� �� ���-������� ������ ����� � ����������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,30,'','http://en.wikipedia.org/wiki/%C4%B0%C3%A7meler') ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (4,'����� ��������','2012_04_29_turkey/ichmeler/IMG_0413_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (30,0,4) ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (153,594,30) ;


-- �������� �����
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (31,         6,              23,               24,                6,                     'Grand Yazici Marmaris Palace','Grand Yazici Marmaris Palace','marmarispalace',     '36.818583','28.243355','�������� ����� � ������� ����������� ����� ���������� � ���������',29);
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (33,100,'�������� ','turtess.com',' �� ',1,'http://turtess.com','turtess') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,31,'','http://www.turtess.com/ru/hotel/364') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,31,'','http://www.grandyazicihotels.com/palace/en/index.php') ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (5,'��� �� ������� ������ Marmaris Palace �� ��������','2012_04_29_turkey/marmarispalace/IMG_0331_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (31,0,5) ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (148,594,31) ;

-- �����
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (32,         6,              23,               24,                5,                     'Grand Yazici Mares Hotel','Grand Yazici Mares Hotel','marmarismares',     '36.823654','28.242867','�������� ����� � ������� ����������� ����� ���������� � ���������',29);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,32,'','http://www.turtess.com/ru/hotel/342') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,32,'','http://www.grandyazicihotels.com/mares/en/index.php') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (32,0,33,'��� � ���� �� ����� ����� �������� ������','http://www.turtess.com/images_p2/342/big/grand_yazici_mares_1.jpg') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (151,594,32) ;

-- ���� ������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (33,         6,              23,               24,                4,                     'Grand Yazici Club Turban','Grand Yazici Club Turban','marmaristurban',     '36.829309','28.24291','�������� ����� � ������� ����������� ����� ���������� � ���������',29);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,33,'','http://www.turtess.com/ru/hotel/695') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,33,'','http://www.grandyazicihotels.com/turban/en/index.php') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (33,0,33,'��� � ���� �� ����� ���� ������ �������� ������','http://www.turtess.com/images_p2/695/big/grand_yazici_club_turban_1.jpg') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (151,594,33) ;

-- ������ ���������
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (24,14,'������-���������','banskastiavnica') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (26,1,'������-���������','banskastiavnica') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (34,         4,              24,               26,                0,                     '������-���������','������-���������','banskastiavnica','48.458964','18.892128','��������� ������� � ������ ��������. ��� �����, ����� ������ ���������� �����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,34,'','http://www.banskastiavnica.sk/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,34,'','http://ru.wikipedia.org/wiki/%D0%91%D0%B0%D0%BD%D1%81%D0%BA%D0%B0-%D0%A8%D1%82%D1%8C%D1%8F%D0%B2%D0%BD%D0%B8%D1%86%D0%B0') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (34,0,3,'Main place of Banska Stiavnica','http://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Bansk%C3%A1_%C5%A0tiavnica_40326.jpg/1024px-Bansk%C3%A1_%C5%A0tiavnica_40326.jpg') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (35,100,'','������� � ������������ - Rina Rina',' �� ',1,'http://rina-rina.ru/','rinarina') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (35,34,'�������� ��������. ���� � ������ ���������','http://rina-rina.ru/2012/05/slovakiya-proezdom-den-v-banska-shtyavnice/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (24,34,'','http://whc.unesco.org/en/list/618') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (34,1,34,'Town Hall Square, Historic City Core','http://www.virtualtravel.sk/ru/panorama/banska-bystrica/banska-stiavnica/historic-city-core/town-hall-square/','http://www.virtualtravel.sk/embed.php?pid=1061&lang=ru&x=670&y=450') ;

-- ������ ��������� ������ �����
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                   `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (35,         2,              24,               26,                0,                     '������ ����� � ������-���������','������� ����� � ������-���������','banskastiavnicaoldcastle','48.45959','18.890664','��������� �����, ������ �������� ��������� ��������������  �������� � ��������� ����� � ����� ������, ����������� � ������ �������� 13-�� ����. � ���� �������, � 15-�� � 16-�� ����� �������� ����������� � ���������� �����, ������� ����� �������� ��������� ������� � ����������. � �������� 16-�� ���� ���� �������� �������� ����� �����������,  �� ���� ��� ��� �������� ��� ������ �� ������. ������ � �������� ���������� ��������� ��������� �������� ������ ��������������. ������ � ����� �����, ����������� �������� � ��������� ������ �������������� � ������������, �������� � ������ ���������� �������� ������',34);
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (35,1,34,'Cannon Bastion, Old Castle, Banska Stiavnica','http://www.virtualtravel.sk/ru/panorama/banska-bystrica/banska-stiavnica/old-castle/cannon-bastion/','http://www.virtualtravel.sk/embed.php?pid=1056&lang=ru&x=670&y=450') ;

-- ������ ��������� ����� �����
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                   `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (36,         2,              24,               26,                0,                     '����� ����� � ������-���������','������ ����� � ������-���������','banskastiavnicanewcastle','48.455822','18.895953','����� ����� ��� �������� ����� 1564-1571 ������ � ��������� �������� ��� ������ �� ������, ��� ��������� ��� ����������, � ��� ����� ������� ���������� ����������� ��������. ����� ������� �� ������� ���������� ����� �  �������� �������� ���������� ������� �����. ������ ��� ������������ ����� ������ ������ ���������. � ����� ����� ������� ��������, ����������� ������ ������ � �������. ������ � ����� �����, ����������� �������� � ��������� ������ �������������� � ������������, �������� � ������ ���������� �������� ������',34);
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (36,1,34,'New Castle, Historic City Core, Banska Stiavnica','http://www.virtualtravel.sk/ru/panorama/banska-bystrica/banska-stiavnica/historic-city-core/new-castle/','http://www.virtualtravel.sk/embed.php?pid=1051&lang=ru&x=670&y=450') ;


-- ��������� �����
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (17,6,'�����������','������������','trenciansky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (25,17,'���������','prievidza') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (27,1,'�������','bojnice') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (37,         2,              25,               27,                0,                     '��������� �����','���������� �����','bojnickyzamok','48.779935','18.577736','����� ������� - ���� �� ����� ������ � ������������ ��������� ������. �������������� ���������� ����� ��� �������� ����� 1300 ����. ��������, ��� ������ ��������� ����� ����  ��������� ������� ��������, ����� �� ����������� ����� ����-�������. ����� �� ��� �������� ������� ����� ������������. ����� ��� ������ ����� ���� ����������� ��������������, �   ��������� �������� ��������� ���. �� ��� �������� ���������� ������ �� ������ ������ �������, ����� ���������, ������� �������� � ��������� ����� � 16-�� ��������. �� ����������� ��� ����� ������� �� �����, ������� ������������� ��� (1889 ���), �� ������� �������� ������ ����������� ������������� ������. �� ���������� � ������������ �������� ������� �������� ������ ��������������. � ��������������� ����� ���� ������� �������� ���� �� ����������  ����� - ����� ������ ����. ����� ������ � �������� ������ - �����  ����� �����. ����� ��������� � ����� � ����� ��������� ���������� � ���������� ������. ����� ��������� ������ �������� ������������ ������. ������ ����������� ������������ ��������������� ������������ ���� � ������ � ������������ ���������� ���������� � ������ ��������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,37,'','http://www.bojnicecastle.sk/index-en.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,37,'','http://ru.wikipedia.org/wiki/%D0%91%D0%BE%D0%B9%D0%BD%D0%B8%D1%86%D0%BA%D0%B8%D0%B9_%D0%B7%D0%B0%D0%BC%D0%BE%D0%BA') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (37,0,2,'�������� ��������� �����','http://www.bojnicecastle.sk/foto/02-7.jpg') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (36,1,'���� ','�� "������� ����" horoshiyblog',' � ',0,'http://horoshiyblog.livejournal.com/','lj_horoshiyblog') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (36,37,'"�������. �������� ����������� � ��������-2"','http://horoshiyblog.livejournal.com/76807.html') ;


-- �������� ���������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,        `point_name_rod`,    `point_alias`,   `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (38,         1,              23,               24,                0,                     '�������� ���������','�������� ���������','marmariscastle','36.850578','28.274367','�������� � ������ ���������� ������ �������� �� ���-������� ������, ����������� ����� ���������� ������������',29);
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (150,594,38) ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (6,'������ �������� � ��������� ������','2012_04_29_turkey/marmariscastle/IMG_1493_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (38,0,6) ;


-- ������������� ����
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (18,6,'�������������','��������������','bratislavsky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (26,18,'���������� 1','bratislava1') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (28,1,'����������','bratislava') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (39,         2,              26,               28,                0,                     '������������� ����','�������������� �����','bratislavskyhrad','48.142322','17.10000','����� � ���������� ����������� ���������� ����� ��������� ������������ ���������������������� ��������. ������� ��� �������� ��� �������������� ���� � ���������� ���������� 907 ����. ����� �������� � �������������� �����, � ��������� ������ � ����� ������� ��������� �������.  � 9-�� �������� ����������� ������������� ������ �  �������� �� ���������� �����. ����� 1245 ���� ���� ��������� ���������� � �������� �� �������� ����, ����� ���������� ��������� �������, � ��� ����� �� �� ���-��������� ������� ���� ��������� ��������, ��������� ��� ������������� ��������. � ������ �������� 15-�� ���� ������������ ����������� ���� ��������� ��� �������� ������ ���������� � ����� � ����������� �������� ������������ ���������� ������ ������ �������. �� ����� ������� ����� ��� �������� ����������� ���������� ������. � �������� 16-�� ����, ����� ���������� ����� �������� ���������� ������, ����� ��� ������������� � ������������ �����. � ������ �������� 17-�� ���� ������� ����� �������� ��� ���� ���� ������, � �������� �������������� ���������� ����� ��� �����.  �� ����������� ��� ����� ������ ������������� ����� �����������, ����������� ������ ������� � 18-�� ��������. ����� ����������� ���� �������� � ����, ����� II ������� ��������� � ����� � 1784 ����, � ������ ������ ���� ���� ������� ��������� ������ ���. � 1811-�� ����� ��� ������, � ����������� ��������� ������� �����, � 60-�� ����� 20-�� ��������. ������ ��� ��������� ��������������� ������� ���������� � ���������� ��������� ���������� ������ � ���������� ���������� ������������� �����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,39,'','http://www.bratislava-hrad.sk/en') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,39,'','http://ru.wikipedia.org/wiki/%D0%91%D1%80%D0%B0%D1%82%D0%B8%D1%81%D0%BB%D0%B0%D0%B2%D1%81%D0%BA%D0%B8%D0%B9_%D0%93%D1%80%D0%B0%D0%B4') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (39,0,3,'Sloven�ina: Bratislava, hrad, Slovensko','http://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Bratislava%2C_Hrad%2C_Slovensko.jpg/1024px-Bratislava%2C_Hrad%2C_Slovensko.jpg') ;


-- ����� ������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (40,         6,              23,               25,                0,                     'Marti Resort Deluxe','Marti Resort Deluxe','martiresort',     '36.805943','28.231956','������ ����� � �������� (������) ���� �� ������� � ��������� ���������',30);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,40,'','http://www.turtess.com/ru/hotel/222') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,40,'','http://www.marti.com.tr/Tesis.aspx') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (153,594,40) ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (40,0,33,'��� � ���� �� ����� ����� ������ ������� ������','http://www.turtess.com/images_p2/222/big/1_marti_resort_deluxe-23.jpg') ;

-- ����� �� �����
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (41,         6,              23,               25,                0,                     'Marti La Perla','Marti La Perla','martilaperla','36.804436','28.232203','���� �� ������ ������ �������� (������) ���� �� �������� ���� � ��������',30);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,41,'','http://www.turtess.com/ru/hotel/220') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,41,'','http://www.marti.com.tr/Tesis.aspx') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (153,594,41) ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (41,0,33,'��� � ���� �� ����� ����� �� ����� ������� ������','http://www.turtess.com/images_p2/220/big/1_marti_la_perla-12.jpg') ;


-- ������
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (27,16,'�������','ortaca') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (29,1,'������','dalyan') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (42,         4,              27,               29,                0,                     '������','�������','dalyan', '36.834294','28.642387','����� �� ���-������� ������, ����������� � ����� ����������� ����, ���������� � �������� ��������� ������������� ����� ����������������������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,42,'','http://ru.wikipedia.org/wiki/%D0%94%D0%B0%D0%BB%D1%8C%D1%8F%D0%BD') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,42,'','http://www.dalyan.bel.tr/') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,42) ;

-- ��������� ��������
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (11,1,'��������','tomb');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (43,         11,             27,               29,                0,                     '��������� ��������','��������� �������','dalyantombs', '36.830619','28.634588','������� ��������� ��������, ���������� � ����� ��� ����� ������, ����� � �������, ������ ���� ��������� ������, �� ���-������� ������');
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,43) ;


-- ���� ������
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (5,1,'��������� ���������������������','��������� ���������������������','naturepoint');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (12,5,'����','beach');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (44,         12,             27,               29,                7,                     '���� ������','����� ������','istuzubeach', '36.79621','28.617282','�������� ��������� ���� �������������� 4,5 ��. ��������� � ���������� ���������� �� ������ ������ ���� �� ���� ������. �������� ��� ���� �� �������� ����, ��� ����������� ���� ������� �������� ������� ���� Caretta caretta');
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,44) ;

-- ��������������
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (6,1,'����� ������ � �����������','����� ������ � �����������','relaxpoint');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (13,6,'��������, �������, �����','aquapark');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (45,         13,             27,               29,                1,                     '��������������','��������������','mudcure', '36.844049','28.63043','�������� � ��������� ������� � ���������� ���������� ����� ��������� ������ ������');
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,45) ;


-- �������� ������
INSERT INTO `ixjun_te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                       VALUES (46,         7,              27,               29,                1,                     '�������� ������','��������� ������','kaunos', '36.827588','28.630924','�������� �� ������ ���� ������ �������� �� ������������ ���������� ������ � ������. ����������� ������������ �� ������ ��������');
INSERT INTO `ixjun_te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,46) ;


-- �����
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (19,7,'���������','���������','lvovskaya') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (28,19,'�����','lvov') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (30,1,'�����','lvov') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (47,         4,              28,               30,                0,                     '�����','������','lvov','49.841899','24.031649','����� ��������� �������������� ����� �������. ��������� ����������� �����, �������� ���������� ����������������������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,47,'','http://city-adm.lviv.ua/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,47,'','http://ru.wikipedia.org/wiki/%D0%9B%D1%8C%D0%B2%D0%BE%D0%B2') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (47,0,3,'�������� ������','http://upload.wikimedia.org/wikipedia/commons/c/c7/Lemberg_Panorama_20.JPG') ;

-- �����-�����
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (48,         9,              28,               30,                0,                     '"�����-�����" �� ������','"�����-�����" �� ������','grandhotellvov','49.84075','24.027121','����������������� ����� � ������ ������ �� ������� �������',47);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,48,'','http://grandhotel.lviv.ua/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,48,'','http://www.booking.com/hotel/ua/grand-lviv.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (48,0,2,'�����. �����-�����','http://grandhotel.lviv.ua/gallery/full/hotel20.jpg') ;

-- ����� ����
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (49,         9,              28,               30,                0,                     '����� "����" �� ������','����� "����" �� ������','hotelgeorgelvov','49.838809','24.030527','�������������� ����� � ������ ������ �� ������� �������, ����� ����� ��������� ����� ���������. ��� ����� ������ �� ����������� ������ ������ �� ������ ������, �� � ���� �������',47);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,49,'','http://www.georgehotel.com.ua/ua/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,49,'','http://www.booking.com/hotel/ua/george.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (49,0,2,'�����. ����� ����','http://img-fotki.yandex.ru/get/4409/13341501.8/0_69b23_f407b5f5_XXXL') ;

-- ����� ��������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (50,         9,              28,               30,                0,                     '����� "Reikartz ��������" �� ������','����� "Reikartz ��������" �� ������','hotelreikartzlvov','49.843559','24.03185','����������������� ����� � ������ ������, �������� �� ������',47);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,50,'','http://www.reikartz.com/ru/hotels/medievale-lvov') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,50,'','http://www.booking.com/hotel/ua/reikartz-medievale-lviv.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (50,0,2,'�����. ����� Reikartz ��������','http://www.reikartz.com/files/_thumbs/244_700x500_dim1.jpg') ;

-- �������� ���� �����
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (4,'������ ��������������','������� ��������������','infrastructure','infrastructures') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (7,4,'������������ ��������������','������� ������������ ��������������','autoinfrastructure');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (14,7,'��������','gasstation');
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (29,19,'����������','brodovsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (31,1,'�����','brody') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (51,         14,             29,               31,                0,                     '�������� ���� � ������','�������� ���� � ������','okkobrody','50.067938','25.163863','�������� ���� ���� � �. ����� ����� ����� � �������. ���� "La Minute"');

-- �������� ���� �����
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (30,19,'���������','strysky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (32,1,'�����','stry') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (52,         14,             30,               32,                0,                     '�������� ���� � �����','�������� ���� � �����','okkostry','49.247638','23.856677','�������� ���� ���� � �. ����� �� ������ �� ������ �� �������. ���� "La Minute"');

-- �������� ���� �����
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (31,19,'����������','skolevsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (33,1,'�����','skole') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (53,         14,             31,               33,                0,                     '�������� ���� � �����','�������� ���� � �����','okkoskole','49.043639','23.510946','�������� ���� ���� � �. ����� �� ������ �� ������ �� �������. ���� "La Minute"');


-- ����������� ������� ����� �������� - ����
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (15,7,'����������� �������','borderpass');
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (32,15,'������������������','velikobereznjansky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (34,2,'����� ��������','malyberezny') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (54,         15,             32,               34,                3,                     '����������� ������� ����� �������� - ����','������������ �������� ����� �������� - ����','mbereznyubla','48.883944','22.420558','����������� ������� ����� �������� - ���� ����� �������� � ���������. ����� ������� �� ���������� ��� �����������, �� ������ ����� �����������. ���������� ���������');

-- ����������� ������� ������� - ����� �������
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (35,1,'�������','uzhgorod') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (55,         15,             20,               35,                1,                     '����������� ������� ������� - ����� �������','������������ �������� ������� - ����� �������','uzhgorodvysnenenecke','48.654927','22.265103','����������� ������� ������� - ����� �������  - �������� ������� ����� �������� � ���������. ��������� ����������� � ����� ��������. ������ ��������');

-- ����������� ������� ���-������
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (36,1,'���','chop') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (56,         15,             20,               36,                7,                     '����������� ������� ���-������','������������ �������� ���-������','chopzahon','48.417567','22.17056','����������� ������� ���-������ - �������� ������� ����� �������� � ��������. ���� �� ����� ������� ����������� ��������� � ������, ����� ���� ����������� ��� - "����"');

-- ����������� ������� ��������-�����������
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (33,15,'�����������','beregovsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (37,1,'��������','beregovo') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                              `point_name_rod`,                            `point_alias`, `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (57,         15,             33,               37,                5,                     '����������� ������� ��������-�����������','������������ �������� ��������-�����������','beregovoberegshurani',   '48.164969','22.573192','����������� ������� ��������-����������� - ���� �� ��������� ����� �������� � ��������');

-- ����������� ������� �����-�������
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (34,15,'��������������','vinogradovsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (38,2,'�����','vilok') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                              `point_name_rod`,                            `point_alias`, `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (58,         15,             34,               38,                2,                     '����������� ������� �����-�������','������������ �������� �����-�������','viloktysabech',   '48.093216','22.834568','����������� ������� �����-������� - ���� �� ����������� ��������� ����� �������� � ��������');


-- ����� ������ 
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (20,5,'�������� ��������','��������� ���������','eszakalfold') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (35,20,'�������-������-�����','szabolcsszatmarbereg') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (39,1,'�����������','nyiregyhaza') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (59,         9,              35,               39,                0,                     'Korona Hotel','Korona Hotel','koronahotelnyiregyhaza','47.956281','21.717181','�������������� ����� � ����� ������ ����������� ���������� �� ����������� ������� � ������������ ������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,59,'','http://www.korona-hotel.hu') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,59,'','http://www.booking.com/hotel/hu/korona-nyiregyhaza.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (59,0,23,'��� �� ����� Danubius Health Spa Resort Buk','http://q.bstatic.com/images/hotel/max600/145/1452579.jpg') ;


-- ����� ������� 
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (21,5,'�������� �������','�������� �������','eszakmagyarorszag') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (36,21,'�����','heves') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (40,1,'���������','egerszalok') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (60,         6,              36,               40,                0,                     'Saliris Resort Spa Hotel','Saliris Resort Spa Hotel','salirisegersalok','47.854955','20.335286','����������������� ���������� ���-�����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,60,'','http://www.salirisresort.hu/ru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,60,'','http://www.booking.com/hotel/hu/saliris-resort.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (60,0,2,'��� �� ����� Saliris Resort Spa Hotel','http://upload.wikimedia.org/wikipedia/commons/a/aa/Egerszal%C3%B3k.jpg') ;


-- ������� telenor � �����������
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (5,'�������','��������','shop','shops') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (8,5,'������������������ �������','������������������ ��������','specialshop');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (16,8,'����� ��������� �����','mobileshop');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (61,         16,             35,               39,                0,                     'Telenor. 4400 Nyiregyhaza Rakoczi utca 18','Telenor. 4400 Nyiregyhaza Rakoczi utca 18','telenornyiregyhaza','47.9588','21.71186','����� ��������� Telenor');

-- �������� ����� korzo � �����������
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (9,5,'�������� �����','�������� ������','shoppingcenters');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (17,9,'�������� �����','shoppingcenter');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (62,         17,             35,               39,                0,                     '�������� ����� Korzo','��������� ������ Korzo','korzonyiregyhaza','47.958178','21.717626','�������� ����� � ������ ����������� ������ �����������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,62,'','http://korzo.hu/english') ;

-- ������ outlet
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (18,9,'������-�����','outletcenter');
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (37,20,'�����-�����','hajdubihar') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (41,1,'������','polgar') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (63,         18,             37,               41,                2,                     '������-����� "������"','������-������ "������"','polgaroutlet','47.843615','21.14336','������-����� � ������ ����������� ������ ������ �� �������� M3');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,63,'','http://www.m3outlet.hu/en') ;

-- ʸ���
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (42,1,'ʸ���','koszeg') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (64,         4,              13,               42,                0,                     'ʸ���','ʸ����','koszeg','47.389852','16.540368','������ ������������� �� ������������� ������ ����� �� ������ �������, �������� �� ������� � ��������. ������� ������������ ������������ ����� � ����������� ��������� ������. ������� ��������������������� - �������� �������, ����������� ���������� ����� �������� �����. ���� ����������� �������� �������� ʸ��� �������� �� ���� ���');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,64,'','http://www.koszeg.hu/nyelvek/en/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,64,'','http://ru.wikipedia.org/wiki/%D0%9A%D1%91%D1%81%D0%B5%D0%B3') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (64,0,3,'����������� ������� ����������� ������ �����','http://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Koszeg_fo_ter.JPG/1024px-Koszeg_fo_ter.JPG') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (37,1,'���� ','�� "���������" evelevich',' � ',0,'http://evelevich.livejournal.com/','lj_evelevich') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (37,64,'�������-2006: ʸ��, ����� � ������','http://evelevich.livejournal.com/21121.html') ;


-- ʸ��� - �������� �������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (65,         1,              13,               42,                0,                     '�������� ������� � ʸ����','�������� ������� � ʸ����','koszegfortress','47.389648','16.538672','�������� � ������ ʸ��� ������� � ����� ��������� ��������� ������� �������, ��� ������������� �������� �������� ��������� ���������� ����� ������',64);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,65,'','http://www.koszeg.hu/nyelvek/en/sightseeing/content.php?id=1475') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (65,0,2,'�������� ������� � ���������� ������ �����','http://www.koszeg.hu/pictures/fotoalbumok/1/2/fotobigpic811.jpg') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (38,100,'','����� �������',' �� ����� ',1,'http://www.zamkivengrii.ru','zamkivengrii') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (38,65,'','http://www.zamkivengrii.ru/keseg-krepost-krepostnoy-muzey-miklosha-yurishicha.html') ;


-- ������
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (43,1,'������','sarvar') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (66,         4,              13,               43,                0,                     '������','�������','sarvar','47.254082','16.93521','����� �� ������ �������. �� ���������������������� ���� ��������� ���������� ������� � �������, � ����� �������� � ������. ����� ���� ������� ����������� ���-��������. � �������� � ����������� �������� ������ Sarvar ������ ��� "������� ��������"');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,66,'','http://www.sarvar.hu/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,66,'','http://en.wikipedia.org/wiki/S%C3%A1rv%C3%A1r') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (66,0,3,'��� �� ����� ������ (�������) � ��������','http://farm8.staticflickr.com/7078/7294065228_450d016cd1_b.jpg') ;

-- ������ - �������� �������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (67,         1,              13,               43,                0,                     '�������� ������� � �������','�������� ������� � �������','sarvarfortress','47.252458','16.936777','�������� � ������ ������, ������������� � 13-�� ����',66);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,67,'','http://nadasdymuzeum.hu/index.php') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (67,0,2,'�������� ������� � ���������� ������ ������','http://nadasdymuzeum.hu/images/nfm51.jpg') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (38,67,'','http://www.zamkivengrii.ru/sharvar-krepost-muzey-ferentsa-nadashdi.html') ;


-- ����
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (44,1,'����','eger') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (68,         4,              36,               44,                0,                     '����','�����','eger','47.902843','20.375894','����� �� ������-������� �������. ����� ����������������������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,68,'','http://www.eger.hu/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,68,'','http://ru.wikipedia.org/wiki/%D0%AD%D0%B3%D0%B5%D1%80_%28%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%29') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (68,0,3,'��� ������ ���� (�������)','http://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Eger_a_v%C3%A1rb%C3%B3l.jpg/1024px-Eger_a_v%C3%A1rb%C3%B3l.jpg') ;

-- ���� - ��������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (69,         1,              36,               44,                0,                     '�������� ��������','�������� ��������','egerfortress','47.90439','20.379059','�������� � ����� - ��������� � ��� ���� �������� �� ��������������������� ������. ���������� ������������� ���������� ����� ������� � 1552 �., � ������ ����� 44 ���� ���� ���-���� �����',68);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,69,'','http://www.egrivar.hu/en/index.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (69,0,3,'�������� �����','http://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Eger_-_Dob%C3%B3_Square.JPG/1024px-Eger_-_Dob%C3%B3_Square.JPG') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (38,69,'','http://www.zamkivengrii.ru/eger-krepost-krepostnoy-muzey-ishtvana-dobo.html') ;


-- ��������
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (22,5,'����������� �������','����������� �������','kozepgyarorszag') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (38,22,'��������','budapest') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (45,1,'��������','budapest') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (70,         4,              38,               45,                0,                     '��������','���������','budapest','47.498358','19.040422','������� ������� � ����� ������� �� �����. �������� ���������� ���������������������� � ������ ����� �������� �� ��� �����. ���� �� ������� ������, ������� ����������� ���� ������� ������ �������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,70,'','http://budapest.hu/sites/english/Lapok/default.aspx') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,70,'','http://ru.wikipedia.org/wiki/%D0%91%D1%83%D0%B4%D0%B0%D0%BF%D0%B5%D1%88%D1%82') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (70,0,3,'��� �� ��������','http://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Budape%C5%A1%C5%A5_0753.jpg/1024px-Budape%C5%A1%C5%A5_0753.jpg') ;

-- ����
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (9,1,'�������','�������','austria') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (9,'����������� �����','���������������� �����','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (23,9,'����','����','wien') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (39,23,'����','wien') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (46,1,'����','wien') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (71,         4,              39,               46,                0,                     '����','����','wien','48.210254','16.372225','������� �������, � ������� ������� ������� ������-���������� �������. ���� �� ����� �������� ������� ����');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,71,'','http://www.wien.gv.at/english/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,71,'','http://ru.wikipedia.org/wiki/%D0%92%D0%B5%D0%BD%D0%B0') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (71,0,3,'��� �� ����� ����','http://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Panorama_vom_burgthdach.JPG/1024px-Panorama_vom_burgthdach.JPG') ;


-- ������ ��������
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (19,1,'������','palace');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (72,         19,             39,               46,                0,                     '������ ��������','������ ��������','schonbrunn','48.185732','16.312723','���� �� ������������ ���������������������� ����, ���������� ����������� �����������. ��������� � ������ ������� ���������� � ������ � ������� ����������� ������������',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (24,72,'','http://whc.unesco.org/en/list/786') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,72,'','http://ru.wikipedia.org/wiki/%D0%A8%D1%91%D0%BD%D0%B1%D1%80%D1%83%D0%BD%D0%BD') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (72,0,3,'������ �������� ���� �������','http://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Schloss_Schoenbrunn_August_2006_406.jpg/1024px-Schloss_Schoenbrunn_August_2006_406.jpg') ;


-- ����� ������� �������
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (10,1,'����������� ����������', '����������� ����������','religion');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (20,10,'�������, �����','church');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (73,         20,             39,               46,                0,                     '����� ������� �������','������ ������� �������','stephansdom','48.208459','16.373148','Stephansdom - ������ ���� � ���� ������������ �������� �������. � �������� ���� ��������� � 1511 ����',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,73,'','http://www.stephansdom.at/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,73,'','http://ru.wikipedia.org/wiki/%D0%A1%D0%BE%D0%B1%D0%BE%D1%80_%D0%A1%D0%B2%D1%8F%D1%82%D0%BE%D0%B3%D0%BE_%D0%A1%D1%82%D0%B5%D1%84%D0%B0%D0%BD%D0%B0') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (73,0,3,'����� ������� ������� ���� �������','http://niistali.narod.ru/cities/Wien/Stephansdom_23.jpg') ;

-- ������ �������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (74,         19,             39,               46,                0,                     '�������','��������','hofburg','48.205506','16.364769','������ ���������� ����������, ����� ����������� ���������� ������������ �����, � ��������� ����� - ����������� ���������� ���������� �������',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,74,'','http://ru.wikipedia.org/wiki/%D0%A5%D0%BE%D1%84%D0%B1%D1%83%D1%80%D0%B3') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (74,0,3,'������ ������� ���� �������','http://upload.wikimedia.org/wikipedia/commons/0/01/Wien_Hofburg_Neue_Burg_Heldenplatz.jpg') ;


-- ������� �����
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (11,1,'������������� ���������������������', '������������� ���������������������','architecture');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (21,11,'������ ������','theatre');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (75,         21,             39,               46,                0,                     '������� �����','������� �����','wieneroper','48.203197','16.36906','���������� ����� � �������. ���� �� ����� �������� ����������� ���������� � ����',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,75,'','http://www.wiener-staatsoper.at/Content.Node/home/Startseite-Content.en.php') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,75,'','http://ru.wikipedia.org/wiki/%D0%92%D0%B5%D0%BD%D1%81%D0%BA%D0%B0%D1%8F_%D0%B3%D0%BE%D1%81%D1%83%D0%B4%D0%B0%D1%80%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%B0%D1%8F_%D0%BE%D0%BF%D0%B5%D1%80%D0%B0') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (75,0,3,'����� ���� �������','http://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Vienna_Opera.jpg/1024px-Vienna_Opera.jpg') ;


-- ���� �����
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (12,3,'����', '����','cafe');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (22,12,'�������','coffe');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (76,         22,             39,               46,                0,                     '���� �����','���� �����','sachercafe','48.203933','16.369489','���������� ���� "�����" (Sacher). ����������� ����, ������������ �����, �������� � ���� � ������������ ����� ����. � ������ ���������� ����� �����, � ����� �������� "���� �����"',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,76,'','http://www.sacher.com/en-cafe-vienna.htm') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (76,0,3,'���� ����� ���� �������','http://venagid.ru/wp-content/uploads/2010/05/Sacher4.jpg') ;

-- ���� ������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (77,         22,             39,               46,                0,                     '���� ������','���� ������','mozartcafe','48.204298','16.369328','���� "������" (Mozart). ��������, ��� ����� ������ ����� ������ �������� �������� � ����',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,77,'','http://www.cafe-mozart.at/en/the-cafe/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (39,1,'���� ','�� "���������������" andreykomov',' � ',0,'http://andreykomov.livejournal.com/','lj_andreykomov') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (39,77,'����������� �� ����. ����� ������: ������, �������, �����','http://andreykomov.livejournal.com/5524.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (77,0,39,'���� ������ ���� �������','http://pics.livejournal.com/andreykomov/pic/0009g2q6') ;


-- ������� ������
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (23,11,'������ ������','rathaus');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (78,         23,             39,               46,                0,                     '����� ������ ����','����� ������ ����','wienerrathaus','48.210883','16.35743','��� ����������, "�����" ������ ���� ��������� � 1883 ���� �� ����� ����������� � ������������� (� ������� �������������) �����',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,78,'','http://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D1%82%D1%83%D1%88%D0%B0_%28%D0%92%D0%B5%D0%BD%D0%B0%29') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (78,0,3,'������ ���� �������','http://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Wienerrathaus.jpg/1024px-Wienerrathaus.jpg') ;


-- ���� ��������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (79,         22,             39,               46,                0,                     '���� ��������','���� ��������','einsteincafe','48.212356','16.358492','���� "��������" (Einstein). ������� � �������� ������������ � ������������ �������',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,79,'','http://einstein.at/cms/uk/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (79,0,2,'���� �������� ���� �������','http://media-cdn.tripadvisor.com/media/photo-s/01/e9/07/5b/cafe-einstein.jpg') ;

-- ���� ������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (80,         22,             39,               46,                0,                     '���� ������','���� ������','demelcafe','48.208616','16.367183','���� "������" (Demel). ���� �� ������� ��������� � ����, � ����� "���������� �����"(!)',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,80,'','http://www.demel.at/en/frames/index_wien.htm') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (80,0,2,'���� ������ ���� �������','http://venagid.ru/wp-content/uploads/2012/05/Demel3.jpg') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (40,100,'','allfun allmoldova',' �� ����� ',1,'http://www.allfun.md','allfunmd') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (40,80,'','http://www.allfun.md/index.php?page=projects&id=1297081443&sid=1297081443&pid=23840') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (80,1,40,'���� ������ ���� �������','http://www.allmoldova.com/uimg/blog/blogeda200711_8.jpg') ;

-- ���� ��������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (81,         22,             39,               46,                0,                     '���� ��������','���� ��������','imperialcafe','48.201259','16.373094','���� "��������" (Imperial). ���� � ����� ��������. �� �������������: ��������� ������ "��������"',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,81,'','http://www.imperialvienna.com/ru/cafe_ru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (40,81,'','http://www.allfun.md/index.php?page=projects&id=1297081443&sid=1297081443&pid=23840') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (81,0,2,'���� �������� ���� �������','http://3cats.ru/wp-content/uploads/images/4613/681274125_w800.jpg') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (81,1,40,'���� �������� ���� �������','http://www.allmoldova.com/uimg/blog/blogeda200711_4.jpg') ;

-- ���� ��������
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (82,         22,             39,               46,                0,                     '���� ��������','���� ��������','centralcafe','48.210361','16.365412','���� "��������" (Central). ���� "��������". ��������� �����. ����� ���������� ��������� ��������� �����, �������� ������� ����������. � ��� ������� ��� ���������� ������ ��������� ��� ������, ����� �������� � ���� � ���������',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,82,'','http://www.palaisevents.at/en/cafecentral.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,82,'','http://ru.wikipedia.org/wiki/%D0%A6%D0%B5%D0%BD%D1%82%D1%80%D0%B0%D0%BB%D1%8C') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (40,82,'','http://www.allfun.md/index.php?page=projects&id=1297081443&sid=1297081443&pid=23840') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (82,0,40,'���� �������� ���� �������','http://www.allmoldova.com/uimg/blog/blogeda200711_2.jpg') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (82,1,40,'���� �������� ���� �������','http://www.allmoldova.com/uimg/blog/blogeda200711_1.jpg') ;


-- Carlton Hotel Budapest 
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (83,         9,              38,               45,                0,                     'Carlton Hotel Budapest','Carlton Hotel Budapest','carltonhotelbudapest','47.499409','19.039285','����������������� ����� � ����� ������ ��������� ����� ������� ����� �� ������� ����',70);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,83,'','http://www.carltonhotel.hu/index_ru.htm') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,83,'','http://www.booking.com/hotel/hu/carltonhotelbudapest.ru.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (83,0,2,'��� �� ����� Carlton Hotel Budapest','http://www.carltonhotel.hu/galeria/ch_utca03.jpg') ;


-- Nyerges Hotel Termal es Etterem  
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (40,22,'����','pest') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (47,1,'�����','monor') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (84,         6,              40,               47,                0,                     'Nyerges Hotel Termal es Etterem','Nyerges Hotel Termal es Etterem','nyergeshotelmonor','47.333562','19.439079','���������� ���-����� � �. ����� �������� �� ���������. 20 ��� ���� �� ��������� ���������');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,84,'','http://monor.utisugo.hu/szallasok/nyerges-hotel-3070.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,84,'','http://www.booking.com/hotel/hu/nyerges-terma-l-a-c-s-atterem.ru.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (84,0,23,'��� �� ����� Nyerges Hotel Termal es Etterem � Monor','http://q.bstatic.com/images/hotel/max600/119/11999449.jpg') ;

ALTER TABLE `#__te_points` CHANGE `point_id` `point_id` INT AUTO_INCREMENT ;

-- �������� ���������
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,0,'','��� ��������� �������� ��� ���� ���� ����������������������. ��������������������� ������������� �� �������, � ����� �� ����� ����������������������. �������� ����, ��������������������� ����� ������, ��� ������ ����, ��� ���������� � ������ �������');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,6,0,1,'����� ���� �������� ������ ������������� ������������� ������ � ��������� ������ �������� ����� ���� ��������������� ������� ��� ��������� ������������ ����������������������','�������� ��������� ������ ��������. � ����� ���������, ����������� �������, �������� � ����������. � ����������� ������ ������ � ������� �������� ��� ����������� �� ���� � �� ��������������� ������. ����� � �������� ����� �������. ������ � ��� ��� ����������� ��� ���� ������������� ������ - ����� ���� ��������, ��� ������ �������� ����� ���� ��������������� ������� ��� ��������� ������������ ����������������������');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,1,'','������������� ����� ���������� �������� � ��������� ��������������������� ����� ����. ����� ������, � ���� �� ������ ���������������������� ��������� ������������� ��������, ������ � ���������. ���������� �� ���� ��, ��� ��� ��� ���������� � ��� ��� ���� ������� ����� �������� �������. ����� ������� ����� � ��������� �������, �������� ������� ��������� ����������� � �������� ���� ��������, ��������� ������� ������� � ��� �������. ������ �������� � ���� �� ��� ����������������������, ������ ��� �������� ����� ����� �������� �������� � ����������, � ����� ����� ��������� �� ����� ������, ��� ���� ����������� �� ������ ������. ������� � ���� ����������� ���� ���� �������� ����������, ������������� �� ����� ����, ������ �� ������ ��������� ������� ���������');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,2,'','� ���� ������ ������� ���������� ������, ������� ���� �� ���� �������� �����������������������. ����� ����� ���������������� ���������� �� �����-�� ���������� ������ ��� �����, � ����� �����, ��� ����� ������, ��� ���������������������. ����� ������ ������������ � � ������ �������� �������� �������� ������, ���� �������, ��������, ���������� ��������� (�������), ����������� ����� ���� (�������), ����� �������� (��������) � �.�.. ����� ������� � ������� ��������������������� ���� ��������� � �������, ����� ������ ���� - ������� ��������� �� �������');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,10,'','���������� ������������ ��������� - ���� �� ������� ����� ���������������������� �� ���� ����. ��� ���������� ������ � ������ ����������� ������� ��������� ������, ������, �����, ������. ��� ������ ������� � ����������� ����������� ���������� - ��� ������������, ��� ����������� �� ���� ����. �������, ��� ���������, ���� � �������� � �����-�� ������� ������������ ������������, ��������� � ������ � ���������');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,11,'','� ����� ���� ��������� ������������� ���������������������, �� �������� � ������ �������, ����� ��� "�����, ��������, ������ � ���������" � "����������� ���������������������". ���� �������� ��������� �������� ������, ��������� ������, ������ ������� � �.�.');



-- ------------------------
-- ������ ��������� �������

-- ������ �������
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (1,'����, ������ �����','�����, ���� �������� �� �������') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (2,'���� ������� - ������������������ ����� �� ����','���� ������� �� ����') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (3,'���� ������� - �� ������ ������� � ������������','���������� ������� �� ����') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (4,'������','���������� �������') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (5,'���������','���������� �������') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (6,'������ ������','���������� �������') ;

-- ���������������
INSERT INTO `#__te_travelers`(`traveler_id`,`traveler_name`) VALUES (1,'�����') ;
INSERT INTO `#__te_travelers`(`traveler_id`,`traveler_name`) VALUES (2,'�����') ;
INSERT INTO `#__te_travelers`(`traveler_id`,`traveler_name`) VALUES (3,'������') ;

-- ������� � �������� ������� 2012
INSERT INTO `#__te_trips`(`trip_id`,`trip_stage`,`trip_name`,`trip_alias`,`trip_descr`,`trip_start_date`) VALUES (1,2,'�������� �� 3 ��� ������� 2012','slovakia2012','','2012-10-18') ;

-- � ������� ���� ����:)
INSERT INTO `#__te_travelers_trips`(`trip_id`,`traveler_id`) VALUES (1,1) ;
INSERT INTO `#__te_travelers_trips`(`trip_id`,`traveler_id`) VALUES (1,2) ;
INSERT INTO `#__te_travelers_trips`(`trip_id`,`traveler_id`) VALUES (1,3) ;

-- ����� ������� �� �������� - ���� �����������
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,26) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,16) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,17) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,18) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,19) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,20) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,21) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,22) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,23) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,24) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,25) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,27) ;
INSERT INTO `#__te_points_trips`(`trip_id`,`point_id`) VALUES (1,28) ;

-- ����� ������� �� �������� - ���� ������������
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,26,1,1,'2012-10-18 22:00','2012-10-19 07:00','�� ����� �������� � 14:00, �� ����� ����� �������� ������ � ������ ������ � 10 ������') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,16,2,2,'2012-10-19 10:00','2012-10-19 11:30','������ � 7, �� ���� ����� �������� �������, ���� ���� � ���������') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,27,3,2,'2012-10-19 12:30','2012-10-19 13:30','����� �� ������, �������� ���� ����� �����') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,17,4,2,'2012-10-19 14:30','2012-10-19 16:00','����������') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,24,5,2,'2012-10-19 18:00','2012-10-20 10:00','������� �� 2 ����') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,18,6,3,'2012-10-20 11:00','2012-10-20 13:00','� ���� ������� � ���� � �����') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,25,7,3,'2012-10-20 14:30','2012-10-20 16:00','���� ��������') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,20,8,3,'2012-10-20 17:00','2012-10-20 18:00','������ �� ������ ������') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,23,9,3,'2012-10-20 18:00','2012-10-20 18:00','������� "��������� �����"') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,21,10,3,'2012-10-20 18:30','2012-10-20 18:30','��������� ��������') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,22,11,3,'2012-10-20 19:00','2012-10-20 20:00','��� � �������') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,24,12,3,'2012-10-20 21:00','2012-10-21 08:00','������ ����') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,19,13,4,'2012-10-21 10:00','2012-10-21 11:00','���� �������� ����� ������ ����') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,28,14,4,'2012-10-21 12:00','2012-10-21 13:00','����������� ��� � ��������, � ����� �����') ;


-- ������� � ������� ������ 2013
INSERT INTO `#__te_trips`(`trip_id`,`trip_stage`,`trip_name`,`trip_alias`,`trip_descr`,`trip_start_date`) VALUES (2,3,'������� - ��� + ��������� - ������ 2013','hungary2013','','2013-01-02') ;

-- ����� �������
INSERT INTO `#__te_trips_stay_points` (`trip_id`,`stay_point_order`,`stay_point_id`,`nights_to_stay`,`arrival_date`,    `depature_date`,`stay_point_comment`) 
                               VALUES ( 2       , 1                , 83            , 1              ,'2013-01-02 15:00','2013-01-03 10:00','������ ���� ������ � ���������') ;
INSERT INTO `#__te_trips_stay_points` (`trip_id`,`stay_point_order`,`stay_point_id`,`nights_to_stay`,`arrival_date`,    `depature_date`,`stay_point_comment`) 
                               VALUES ( 2       , 2                , 15            , 4              ,'2013-01-03 17:00','2013-01-07 10:00','������ ���� � "�������� ���". ��������, ��������� ���������, ����� �� ������������ � � ����') ;
INSERT INTO `#__te_trips_stay_points` (`trip_id`,`stay_point_order`,`stay_point_id`,`nights_to_stay`,`arrival_date`,    `depature_date`,`stay_point_comment`) 
                               VALUES ( 2       , 3                , 60            , 3              ,'2013-01-07 17:00','2013-01-10 10:00','��� ���� � "��������" (���������). ��������, ��������� ���������, ������� ����� �� ������������') ;
INSERT INTO `#__te_trips_stay_points` (`trip_id`,`stay_point_order`,`stay_point_id`,`nights_to_stay`,`arrival_date`,    `depature_date`,`stay_point_comment`) 
                               VALUES ( 2       , 4                , 84            , 1              ,'2013-01-10 17:00','2013-01-11 07:30','��������� ���� � ������, ������� � ���������. ��������, ��������� ���������') ;


