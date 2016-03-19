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
-- Блок таблиц классов типов и подтипов точек

create table `#__te_point_classes`
(
   `point_class_id`       int(11) not null,
   `point_class_name`     varchar(255) not null,
   `point_class_name_pl`  varchar(255) not null, -- название класса во множественном числе
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
-- Блок таблиц местоположения, от континента до района

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

-- area - территория - несколько стран в пределах одного континента, например, "юго-восточная азия" или "западная европа"
create table `#__te_areas`
(
   `area_id`         int not null,
   `area_name`       varchar(255) not null,
   `area_alias`      varchar(255) not null unique,
   `area_descr`      varchar(255),
   primary key (`area_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- таблица вхождения стран в территории
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


-- region - самое крупное админ. деление внутри страны, как именно это называется в конретной стране будет задаваться в отдельной таблице. В Украине это области
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

-- subregion - следующее деление внутри страны, как именно это называется в конретной стране будет задаваться в отдельной таблице. В Украине это районы
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


-- Названия единиц административного деления для разных стран
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


-- regiongroup - территория в пределах страны, объединяющая несколько регионов, например, "южная германия" или "западная украина"
create table `#__te_regiongroups`
(
   `regiongroup_id`         int not null,
   `regiongroup_name`       varchar(255) not null,
   `regiongroup_alias`      varchar(255) not null unique,
   `regiongroup_descr`      varchar(255),
   primary key (`regiongroup_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- таблица вхождения регионов в группы
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


-- subregiongroup - территория в пределах региона, объединяющая несколько субрегионов, например, "Верхняя Франкония" в "Баварии"
create table `#__te_subregiongroups`
(
   `subregiongroup_id`         int not null,
   `subregiongroup_name`       varchar(255) not null,
   `subregiongroup_alias`      varchar(255) not null unique,
   `subregiongroup_descr`      varchar(255),
   primary key (`subregiongroup_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- таблица вхождения субрегионов в группы
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



-- Типы населенных пунктов
create table `#__te_settlement_types`
(
   `settlement_type_id`         int not null,
   `settlement_type_name`       varchar(255) not null,
   `settlement_type_alias`      varchar(255) not null unique,
   `settlement_type_descr`      varchar(255),
   primary key (`settlement_type_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- Населенные пункты
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


-- Отношение населенных пунктов и субрегионов. Может быть "много к многим", поскольку маленькие города принадлжат субрегиону, а большие наоборот состоят из них
create table `#__te_settlements_subregions`
(
   `settlement_subregion_id`  int not null,
   `settlement_id`            int not null,
   `subregion_id`             int not null,
   `subregion_is_capital`     int not null, -- 1- если город - столица субрегиона, 0 - иначе.
   primary key (`settlement_subregion_id`),
   unique (`settlement_id`,`subregion_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_settlements_subregions` add constraint `#__te_FK_settlements_subregion_settlement` foreign key (`settlement_id`)
      references `#__te_settlements` (`settlement_id`) on delete restrict on update restrict;

alter table `#__te_settlements_subregions` add constraint `#__te_FK_settlements_subregion_subregions` foreign key (`subregion_id`)
      references `#__te_subregions` (`subregion_id`) on delete restrict on update restrict;


-- Столицы стран
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


-- Столицы регионов
create table `#__te_settlements_region_capitals`
(
   `settlement_region_id`  int not null auto_increment,
   `settlement_id`         int not null,
   `region_id`             int not null,
   `settlement_is_region`  int not null, -- 1, если город и есть сам регион верхнего уровня, например Берлин 
   primary key (`settlement_region_id`),
   unique (`settlement_id`,`region_id`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_settlements_country_capitals` add constraint `#__te_FK_settlements_country_capitals_settlement` foreign key (`settlement_id`)
      references `#__te_settlements` (`settlement_id`) on delete restrict on update restrict;

alter table `#__te_settlements_country_capitals` add constraint `#__te_FK_settlements__country_capitals_country` foreign key (`country_id`)
      references `#__te_countries` (`country_id`) on delete restrict on update restrict;



-- ----------------------------------------------------
-- таблица точек (мест)

create table `#__te_points`
(
   `point_id`              int not null,
   `point_subtype`         int not null,
   `point_subregion`       int not null,
   `point_settlement`      int not null,
   `point_settlement_dist` int not null,  -- расстояние до населенного пункта в км, 0 если на его территории 
   `point_name`            varchar(255) not null,
   `point_name_rod`        varchar(255) not null, -- название в родительном падеже
   `point_alias`           varchar(255) not null unique,
   `point_lat`             double(10,6) not null, -- Широта
   `point_lon`             double(10,6) not null, -- Долгота
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



-- Классы типов ссылок точек ("Прочие ссылки", "Посты в ЖЖ")
create table `#__te_points_link_classes`
(
   `link_class_id`          int not null,
   `link_class_pre_label`    varchar(255) not null,
   `link_class_link_label`   varchar(255) not null,
   `link_class_post_label`   varchar(255) not null,
   `link_class_incl_point`  int not null, -- 0 - не включать название точки, 1 - включать в именительном падеже, 2 - в родительном 
   `link_class_sitelink`    varchar(255) not null, -- материнский сайт, например "ЖЖ"
   `link_class_alias`       varchar(255) not null unique,
   primary key (`link_class_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- Типы визуального контента (фотографии, видео, панорамы,...)
create table `#__te_visual_content_types`
(
   `content_type_id`         int not null,
   `content_type_name`       varchar(255) not null,
   `content_type_descr`      varchar(511) not null,
   `content_type_alias`      varchar(255) not null,
   primary key (`content_type_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;



-- Типы ссылок точек ("офф. сайт", "Страница в википедии", "Пост в ЖЖ журнале Иванова")
create table `#__te_points_link_types`
(
   `link_type_id`           int not null,
   `link_type_class`        int not null,
   `link_type_pre_label`    varchar(255) not null,
   `link_type_link_label`   varchar(255) not null,
   `link_type_post_label`   varchar(255) not null,
   `link_type_incl_point`   int not null, -- 0 - не включать название точки, 1 - включать в именительном падеже, 2 - в родительном 
   `link_type_sitelink`     varchar(255) not null, -- общий сайт для этого типа постов, например википедия, адрес ЖЖ Иванова
   `link_type_alias`        varchar(255) not null unique,
   `link_type_content_type` int not null default 1, -- Тип визуального контента, для ссылок изображений, по умолчанию 1 - фото
   primary key (`link_type_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_points_link_types` add constraint `#__te_points_link_types_classes` foreign key (`link_type_class`)
      references `#__te_points_link_classes` (`link_class_id`) on delete restrict on update restrict;

alter table `#__te_points_link_types` add constraint `#__te_points_link_types_content` foreign key (`link_type_content_type`)
      references `#__te_visual_content_types` (`content_type_id`) on delete restrict on update restrict;



-- Ссылки точек
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


-- Посты на "родном" сайте с точками
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


-- общая база всех фотографий сайта
create table `#__te_photos`
(
   `photo_id`           int not null,
   `photo_name`         varchar(255) not null,
   `photo_path`         varchar(255) not null, 
   `photo_lat`          double(10,6) not null, -- Широта
   `photo_lon`          double(10,6) not null, -- Долгота
   primary key (`photo_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- Фото на "родном" сайте с точками
create table `#__te_points_photos`
(
   `point_order_id`     int not null auto_increment,
   `point_id`           int not null,
   `photo_order`        int not null, -- порядковый номер среди фотографий одной точки
   `photo_id`           int not null,
   primary key (`point_order_id`),
   unique (`point_id`,`photo_order`)
) AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;

alter table `#__te_points_photos` add constraint `#__te_points_photos_photo` foreign key (`photo_id`)
      references `#__te_photos` (`photo_id`) on delete restrict on update restrict;

alter table `#__te_points_photos` add constraint `#__te_points_photos_point` foreign key (`point_id`)
      references `#__te_points` (`point_id`) on delete restrict on update restrict;


-- Фото (или другой визуальный контент) на внешнем сайте (тип ссылки) с точками
create table `#__te_points_link_photos`
(
   `point_link_photo_id` int not null auto_increment,
   `point_id`            int not null,
   `link_photo_order`    int not null, -- порядковый номер среди фотографий одной точки
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


-- таблица для описаний сочетаний классов-типов достопримечательностей и стран-регионов
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
-- Блок таблиц, описывающих путешественников и поездки (прошлые и будущие)

-- Стадии поездок
create table `#__te_trip_stages`
(
   `trip_stage_id`              int not null,
   `trip_stage_name`            varchar(255) not null, 
   `trip_stage_points_label`    varchar(255) not null, 
   primary key (`trip_stage_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

-- Поездки
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

-- Путешественники
create table `#__te_travelers`
(
   `traveler_id`      int not null,
   `traveler_name`    varchar(255) not null, 
   primary key (`traveler_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- Путешественники в поездках
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


-- Точки поездок (без указания порядка и дат - для стадии идеи)
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


-- Точки поездок с порядком и датами
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

-- Места проживания в поездках
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


-- Перемещения в поездках. Перемещение - однодневное
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


-- Типы групп точек (вариантов) перемещений в поездках
create table `#__te_trips_move_options_types`
(
   `move_option_type_id`    int not null,
   `move_option_type_name`  varchar(255) default null,
   `move_option_type_descr` varchar(511) default null,
   primary key (`move_option_type_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;


-- Группы точек (варианты) перемещений в поездках
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


-- Точки в группах (вариантах) перемещений в поездках
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


-- Текстовые метки
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

-- заполняем текстовые метки
INSERT INTO `#__te_textlabels` (`sitename_label`,`km_label`,`settlement_label`,  `settlement_near_label`,       `country_label`,`countries_label`,`place_label`,   `this_label`,`type_label`,`subtype_label`,`links_label`,`posts_label`,`coord_label`, `onmap_label`, `parentpoint_label`,                  `childpoints_label`,                   `sisterpoints_label`,                        `start_date_label`,`stage_label`,`byclasses_label`,`bytypes_label`,`byregions_label`,`bycountries_label`,`fulllist_label`,`on_label`) 
                        VALUES ('altman.kiev.ua','км',      'Населенный пункт: ','Ближайший населенный пункт: ','Страна: ',     'Страны',         'Местоположение','',          'Тип: ',     'Точный тип: ', 'Ссылки',     'Посты на ',  'Координаты',' на карте',     'Это место находится на территории: ','На территории этого места находится:','Рядом на этой же территории еще находится:','Дата начала',     'Стадия',     'по видам'       ,'по типам'     ,'по регионам'    ,'по странам'       ,'полный список' ,' на ');

-- типы визуального контента
INSERT INTO `#__te_visual_content_types` (`content_type_id`,`content_type_name`,`content_type_descr`,`content_type_alias`) VALUES (1,'Фото','','photo') ;
INSERT INTO `#__te_visual_content_types` (`content_type_id`,`content_type_name`,`content_type_descr`,`content_type_alias`) VALUES (2,'Панорама','','panorama') ;
INSERT INTO `#__te_visual_content_types` (`content_type_id`,`content_type_name`,`content_type_descr`,`content_type_alias`) VALUES (3,'Видео','','video') ;

-- добавляем точку "Крепость Шпандау" и все необходимые мета-данные
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (1,'Достопримечательность','Достопримечательности','attraction','attractions') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (1,1,'Замок, дворец, крепость, монастырь','Замки, дворцы, крепости и монастыри','castle');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (1,1,'Крепость','fortress');
INSERT INTO `#__te_continents`(`continent_id`,`continent_name`,`continent_alias`) VALUES (1,'Европа','europe') ;
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (1,1,'Германия','Германии','germany') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (1,'Федеральная земля','Административный район','Область','Административный округ') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (1,1,'Берлин','Берлина','berlin') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (1,1,'Шпандау','spandau') ;
INSERT INTO `#__te_settlement_types`(`settlement_type_id`,`settlement_type_name`,`settlement_type_alias`) VALUES (1,'Город','town') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (1,1,'Берлин','berlin') ;
INSERT INTO `#__te_settlements_country_capitals`(`settlement_id`,`country_id`) VALUES (1,1) ;
INSERT INTO `#__te_settlements_region_capitals`(`settlement_id`,`region_id`,`settlement_is_region`) VALUES (1,1,1) ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,      `point_name_rod`,  `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (1,          1,              1,                1,                 0,                     'Цитадель Шпандау','цитадели Шпандау','spandaufortress','52.540984','13.213581','Большая крепость, раньше располагалась в городе Шпандау, а после присоединения Шпандау к Берлину теперь является известной достопримечательностью одноименного района Берлина');
INSERT INTO `#__te_points_link_classes` (`link_class_id`,`link_class_pre_label`,`link_class_link_label`,`link_class_post_label`,`link_class_incl_point`,`link_class_sitelink`,`link_class_alias`) VALUES (1,'Посты про ','Живом Журнале',' в ',1,'http://livejournal.com','ljlinks') ;
INSERT INTO `#__te_points_link_classes` (`link_class_id`,`link_class_pre_label`,`link_class_link_label`,`link_class_post_label`,`link_class_incl_point`,`link_class_sitelink`,`link_class_alias`) VALUES (2,'Фотографии с ','Flickr',' на ',1,'http://www.flickr.com','flickrlinks') ;
INSERT INTO `#__te_points_link_classes` (`link_class_id`,`link_class_pre_label`,`link_class_link_label`,`link_class_post_label`,`link_class_incl_point`,`link_class_sitelink`,`link_class_alias`) VALUES (3,'Посты про ','сообществе Турбина.ру',' в ',1,'http://turbina.ru','turbinalinks') ;
INSERT INTO `#__te_points_link_classes` (`link_class_id`,`link_class_pre_label`,`link_class_link_label`,`link_class_post_label`,`link_class_incl_point`,`link_class_sitelink`,`link_class_alias`) VALUES (100,'Прочие ссылки','','',0,'','otherlinks') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (1,1,'Пост ','ЖЖ "Германские хроники" tanya_abramova',' в ',0,'http://tanya-abramova.livejournal.com/','lj_abramova') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (2,100,'Официальный сайт ','','',2,'','official') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (3,100,'Страница ','',' в Википедии',2,'','wikipedia') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (4,1,'Пост ','ЖЖ "О моем городе и не только" jjvs',' в ',0,'http://jjvs.livejournal.com/','lj_jjvs') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (5,1,'Пост ','ЖЖ "Познавательные путешествия. Авторский блог Эдуарда Гавайлера" gavailer',' в ',0,'http://gavailer.livejournal.com/','lj_gavailer') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (6,1,'Пост ','ЖЖ "Frank Booth" f_booth',' в ',0,'http://f_booth.livejournal.com/','lj_f_booth') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (7,100,'','allcastle',' на ',1,'http://allcastle.info/','allcastle') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (1,1,'"Шпандау и цитадель"','http://tanya-abramova.livejournal.com/222504.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,1,'','http://www.zitadelle-spandau.de/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,1,'','http://ru.wikipedia.org/wiki/%D0%A6%D0%B8%D1%82%D0%B0%D0%B4%D0%B5%D0%BB%D1%8C_%D0%A8%D0%BF%D0%B0%D0%BD%D0%B4%D0%B0%D1%83') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (4,1,'"Цитадель Шпандау, Берлин"','http://jjvs.livejournal.com/1852.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (5,1,'"Как устроена цитадель"','http://gavailer.livejournal.com/154269.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (6,1,'"Крепость-цитадель Шпандау"','http://f-booth.livejournal.com/80652.html') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (117,603,1) ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (1,'Ворота Цитадели Шпандау в Берлине','2011_08_14_germany/citadel/IMG_6555_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (1,0,1) ;

-- Нойшванштайн
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (2,1,'Замок','castle');
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (2,1,'Бавария','Баварии','bayern') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (2,2,'Восточный Альгой','ostallgau') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (2,1,'Фюссен','fussen') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,  `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (2,          2,              2,                2,                 4,                     'Нойшванштайн','замка Нойшванштайн','neuschwanstein','47.557994','10.749875','Самый знаменитый из замков, построенных "безумным королем" Людвигом Вторым Баварским. Идеальный романический средневековый замок, каким он должен быть (по мнению Людвига, конечно)');
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (138,603,2) ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,2,'','http://ru.wikipedia.org/wiki/%D0%9D%D0%BE%D0%B9%D1%88%D0%B2%D0%B0%D0%BD%D1%88%D1%82%D0%B0%D0%B9%D0%BD') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,2,'','http://www.neuschwanstein.de/index.htm') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (7,2,'','http://allcastle.info/europe/germany/001') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (8,1,'Пост ','ЖЖ "Хочу все знать - 2" masterok',' в ',0,'http://masterok.livejournal.com/','lj_masterok') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (8,2,'"Дворцы и замки Германии: Нойшванштайн (Neuschwanstein Castle)"','http://masterok.livejournal.com/210510.html') ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (2,'Замок Нойшванштайн вид с моста Мариенбрюке','2011_08_14_germany/neuschwanstein/IMG_7852_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (2,0,2) ;

-- Шильонский замок
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (2,1,'Швейцария','Швейцарии','swiss') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`region_nikname_rod`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (2,'Кантон','Кантона','Район','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (3,2,'Во','Во','vaud') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (3,3,'Веве','vevey') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (3,1,'Монтрё','montreux') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,`point_lat`, `point_lon`,   `point_descr`) 
                    VALUES (3,          2,              3,                3,                 3,                     'Шильонский замок','Шильонского замка','chillon',  '46.414196','6.927513','Известный швейцарский замок на Женевском озере');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,3,'','http://ru.wikipedia.org/wiki/%D0%A8%D0%B8%D0%BB%D1%8C%D0%BE%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%B7%D0%B0%D0%BC%D0%BE%D0%BA') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,3,'','http://www.chillon.ch/en/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (7,3,'','http://allcastle.info/europe/swiss/001') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (3,0,7,'Шильонский замок','http://allcastle.info/assets/images/foto/81-1.jpg') ;

-- Мон-Сен-Мишель
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (3,1,'Франция','Франции','france') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (3,'Регион','Департамент','Историческая область','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (4,3,'Нижняя Нормандия','Нижней Нормандии','bassenormandie') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (4,4,'Манш','manche') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (4,1,'Авранш','avranches') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (4,          1,              4,                4,                 26,                    'Мон-Сен-Мишель','Мон-Сен-Мишель','montsaintmichel',  '48.635561','-1.510611',  'Крепость-монастырь на севере Франции на острове-скале');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,4,'','http://ru.wikipedia.org/wiki/%D0%9C%D0%BE%D0%BD-%D0%A1%D0%B5%D0%BD-%D0%9C%D0%B8%D1%88%D0%B5%D0%BB%D1%8C') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,4,'','http://www.au-mont-saint-michel.com/en/mont_st_michel.htm') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (7,4,'','http://allcastle.info/europe/france/007') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (9,1,'Пост ','ЖЖ "Andreev.org - Фотодневники Путешествий"',' в ',0,'http://andreev-org.livejournal.com/','lj_andreevorg') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (9,4,'"Франция: скала Мон-Сен-Мишель. Фоторепортаж"','http://andreev-org.livejournal.com/63705.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (4,0,9,'Дневной вид на Мон-Сен-Мишель','http://www.andreev.org/engine/uploaded/images//2012/06/238FRA.jpg') ;

-- Рокамадур
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (5,3,'Юг-Пиренеи','Юг-Пиренеи','midipyrenees') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (5,5,'Лот','lot') ;
INSERT INTO `#__te_settlement_types`(`settlement_type_id`,`settlement_type_name`,`settlement_type_alias`) VALUES (2,'Деревня','hamlet') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (5,2,'Рокамадур','rocamadour') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (2,1,'Старый город, исторический центр, старая деревня', 'Старые города, исторические центры, старые деревни','oldtown');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (3,2,'Старая деревня','oldhamlet');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (5,          3,              5,                5,                 0,                      'Рокамадур','Рокамадура','rocamadour',  '44.799191','1.617694',  'Невероятного вида деревня на Юге Франции. Всего две улицы, дома расположены на отвесной скале');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,5,'','http://uk.wikipedia.org/wiki/%D0%A0%D0%BE%D0%BA%D0%B0%D0%BC%D0%B0%D0%B4%D1%83%D1%80') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,5,'','http://www.rocamadour.com/en') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (10,100,'','panoramix.ru',' на ',1,'http://www.panoramix.ru/','panoramixru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (10,5,'','http://www.panoramix.ru/france/rocamadour/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (11,1,'Пост ','ЖЖ "Марина Лысцева, фотограф" fotografersha',' в ',0,'http://fotografersha.livejournal.com/','lj_fotografersha') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (11,5,'"Рокамадур"','http://fotografersha.livejournal.com/236893.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (5,0,11,'Рокамадур, общий вид','http://img-fotki.yandex.ru/get/6106/414616.c0/0_8a951_fbd8d545_XXL') ;

-- Каркассон
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (6,3,'Лангедок—Руссильон','Лангедок—Руссильон','languedocroussillon') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (6,6,'Од','aude') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (6,1,'Каркассон','сarcassonne') ;
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (4,2,'Старый город','oldtown');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (6,          4,              6,                6,                 0,                     'Каркассон','Каркассона','carcassonne',  '43.206568','2.36485',  'Старый укрепленный город на возвышенности, окруженный двумя рядами стен');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,6,'','http://ru.wikipedia.org/wiki/%D0%9A%D0%B0%D1%80%D0%BA%D0%B0%D1%81%D0%BE%D0%BD') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,6,'','http://www.carcassonne-tourisme.com/carcassonne_EN.nsf/vuetitre/docpgeIntroVisiter') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (12,1,'Пост ','ЖЖ "Трямс" jengibre',' в ',0,'http://jengibre.livejournal.com/','lj_jengibre') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (12,6,'"Франция-2012, Каркассон"','http://jengibre.livejournal.com/272933.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (19,2,'Фотографии ','Jaume CP BCN\'s photostream',' в ленте ',1,'http://www.flickr.com/photos/jaumebcn','flickr_jaumebcn') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,6,'El Conflent i el Rosello','http://www.flickr.com/photos/jaumebcn/sets/72157631620572211/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (20,2,'Страница места ','Flickr places',' на ',1,'http://www.flickr.com/places','flickr_places') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (20,6,'Carcassonne','http://www.flickr.com/places/France/Languedoc-Roussillon/Carcassonne') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (6,0,19,'Carcassonne','http://farm9.staticflickr.com/8182/8025875831_d90b988556_b.jpg') ;


-- Динан
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (7,3,'Бретань','Бретани','bretagne') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (7,7,'Кот-д’Армор','cotesdarmor') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (7,1,'Динан','Dinan') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (7,          4,              7,                7,                 0,                     'Динан','Динана','dinan',  '48.450304','-2.043511',  'Старинный средневековый город, замок, высокие крепостные стены, река, виадук');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,7,'','http://ru.wikipedia.org/wiki/%D0%94%D0%B8%D0%BD%D0%B0%D0%BD_%28%D0%A4%D1%80%D0%B0%D0%BD%D1%86%D0%B8%D1%8F%29') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,7,'','http://www.mairie-dinan.com/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (12,7,'"Франция-2009, Динан"','http://jengibre.livejournal.com/271114.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (13,1,'Пост ','ЖЖ "Я в скуку дальних мест не верю," yuljok',' в ',0,'http://yuljok.livejournal.com/','lj_yuljok') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (13,7,'"Франция-2008. Динан."','http://yuljok.livejournal.com/78270.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (14,1,'Пост ','ЖЖ "Маленькие фотопутешествия по Израилю и не только" dona-anna',' в ',0,'http://dona-anna.livejournal.com/','lj_donaanna') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (14,7,'"Динан: собственный порт:)"','http://dona-anna.livejournal.com/615788.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (7,0,14,'Динан, вид на порт с городской стены','http://images54.fotki.com/v627/photos/6/869496/9765840/IMGP1205-vi.jpg') ;

-- Фужер
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (8,7,'Иль и Вилен','illeetvilaine') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (8,1,'Фужер','fougeres') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (8,          2,              8,                8,                 0,                     'замок Фужер','замка Фужер','fougeres',  '48.354053','-1.209306',  'Большая средневековая крепость в старинном городе Фужер (что в переводе с французского означает "папоротник", так что прямой связи замка с фужерами для вина нету)');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,8,'','http://ru.wikipedia.org/wiki/%D0%A4%D1%83%D0%B6%D0%B5%D1%80_%28%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%29') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,8,'','http://www.chateau-fougeres.com/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (15,1,'Пост ','ЖЖ "Бегущая по волнам" smarty-yulia',' в ',0,'http://smarty-yulia.livejournal.com/','lj_smartyyulia') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (15,8,'"Франция: Бретань, Фужер"','http://smarty-yulia.livejournal.com/172671.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (8,0,15,'Замок фужер, вид изнутри','http://i632.photobucket.com/albums/uu41/Smartyyulia/Paris/2011/2011_04_01_Vitre_Fuger/IMG_2732.jpg') ;

-- Ровинь
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (4,1,'Хорватия','Хорватии','croatia') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`region_nikname_rod`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (4,'Жупания','Жупании','Город или община','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (8,4,'Истрийская','Истрийской','istriana') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (9,8,'Ровинь','rovinge') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (9,1,'Ровинь','rovinge') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (9,          4,              9,                9,                 0,                    'Ровинь','Ровинь','rovinge',  '45.082847','13.632081',  'Город на побережье в Хорватии на территории полуострова Истрия. Старая часть города расположена на полуострове овальной формы');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,9,'','http://ru.wikipedia.org/wiki/%D0%A0%D0%BE%D0%B2%D0%B8%D0%BD%D1%8C') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,9,'','http://www.rovinj.hr/rovinj/index.php') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (16,1,'Пост ','ЖЖ "Фотопутешествия" powerk',' в ',0,'http://powerk.livejournal.com/','lj_powerk') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (16,9,'"Ровинь."','http://powerk.livejournal.com/38454.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (9,0,16,'Вид на Ровинь','http://ic.pics.livejournal.com/powerk/11024191/636284/original.jpg') ;

-- Фонтевро
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (5,1,'Монастырь','monastery');
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (9,3,'Земли Луары','Земель Луары','paysdelaloire') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (10,9,'Мен и Луара','maineetloire') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (10,1,'Фонтевро-л\'Абеи','fontevraudlabbaye') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,  `point_name_rod`,    `point_alias`,      `point_lat`, `point_lon`, `point_descr`) 
                    VALUES (10,         5,              10,               10,                0,                     'аббатство Фонтевро','аббатства Фонтевро','fontevraud',  '47.181334','0.051069',  'Королевское аббатство Фонтевро, огромный монастырский комплекс, один из самых знаменитых во всей Франции. Развитая экскурсионная программа, есть приложения для iOS и Android');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,10,'','http://ru.wikipedia.org/wiki/%D0%A4%D0%BE%D0%BD%D1%82%D0%B5%D0%B2%D1%80%D0%BE') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,10,'','http://www.abbayedefontevraud.com/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (17,100,'','Замки долины Луары loire-chateaux.ru',' на сайте ',1,'http://loire-chateaux.ru/','loirechateaux') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (17,10,'','http://loire-chateaux.ru/19-Zamkov-/Abbatstvo-Fontevraud.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (18,2,'Фотографии ','marc.alhadeff\'s photostream',' на сайте ',1,'http://www.flickr.com/photos/alhadeff/','flickr_alhadeff') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (18,10,'2012-04 Abbaye de Fontevraud','http://www.flickr.com/photos/alhadeff/sets/72157629464262770/with/6937116850/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (10,0,18,'Abbaye de Fontevraud-023-Modifier','http://farm8.staticflickr.com/7179/6937116850_a9375eac89_b.jpg') ;

-- Аббатство святого Мартина в Канигу
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (11,6,'Восточные Пиренеи','pyreneesorientales') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (11,2,'Кастей','сasteil') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                        `point_name_rod`,                    `point_alias`,      `point_lat`,`point_lon`, `point_descr`) 
                    VALUES (11,         5,              11,               11,                1,                     'Аббатство святого Мартина в Канигу','Аббатства святого Мартина в Канигу','stmartinducanigou','42.52814', '2.400979',  'Аббатство в горах во Франции на границе с Испанией');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,11,'','http://en.wikipedia.org/wiki/Martin-du-Canigou') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,11,'','http://stmartinducanigou.org/index_UK.php') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,11,'El Conflent i el Rosello','http://www.flickr.com/photos/jaumebcn/sets/72157631620572211/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (11,0,19,'Abadia de Sant Marti del Canigo','http://farm9.staticflickr.com/8042/8029125032_ee52b55b7b_h.jpg') ;


-- Ла-Рок-Гажак
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (10,3,'Аквитания','Аквитании','aquitania') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (12,10,'Дордонь','dordogne') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (12,2,'Ла-Рок-Гажак','laroquegageac') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                        `point_name_rod`,                    `point_alias`,      `point_lat`,`point_lon`, `point_descr`) 
                    VALUES (12,         3,              12,               12,                0,                     'Ла-Рок-Гажак','Ла-Рок-Гажак','laroquegageac','44.826649', '1.181599',  'Деревня, состоящая из одной улицы, с одной строны отвесная скала, с другой - река. Потрясающе красиво, можно поплавать на лодочке');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,12,'','http://en.wikipedia.org/wiki/La_Roque-Gageac') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,12,' с тегом laroquegageac','http://www.flickr.com/photos/jaumebcn/tags/laroquegageac/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (14,12,'Деревня la Roque Gageac - одна улица и все тут:)','http://dona-anna.livejournal.com/34819.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (21,100,'','Сайте ассоциации найкрасивейших французских деревень',' на ',1,'http://www.france-beautiful-villages.org','francebeautifulvillages') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (21,12,'','http://www.france-beautiful-villages.org/en/la-roque-gageac') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (12,0,19,'La Roque-Gageac','http://farm9.staticflickr.com/8462/8022609750_8eb30cb3e8_b.jpg') ;

-- Бейнак-е-Казенак
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (13,2,'Бейнак-е-Казенак','beynacetcazenac') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                        `point_name_rod`,                    `point_alias`,      `point_lat`,`point_lon`, `point_descr`) 
                    VALUES (13,         3,              12,               13,                0,                     'Бейнак-е-Казенак','Бейнак-е-Казенак','beynacetcazenac','44.839712', '1.143748',  'Красивая деревня у подножия замка Бейнак на реке Дордонь');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,13,'','http://en.wikipedia.org/wiki/Beynac-et-Cazenac') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,13,' с тегом beynacetcazenac','http://www.flickr.com/photos/jaumebcn/tags/beynacetcazenac/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (21,13,'','http://www.france-beautiful-villages.org/en/beynac-et-cazenac') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (22,1,'Пост ','ЖЖ "Норка в Шире" alla-hobbit',' в ',0,'http://alla-hobbit.livejournal.com/','lj_allahobbit') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (22,13,'Франция - Дордонь - замок Бейнак-эт-Казенак (Chateau de Beynac-et-Cazenac)','http://alla-hobbit.livejournal.com/331174.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (13,0,19,'Beynac-et-Cazenac','http://farm9.staticflickr.com/8172/7995241293_0936d8d365_b.jpg') ;

-- Замок Бейнак
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                        `point_name_rod`,                    `point_alias`,      `point_lat`,`point_lon`, `point_descr`, `point_parent`) 
                    VALUES (14,         2,              12,               13,                0,                     'замок Бейнак','замка Бейнак','beynaccastle','44.839712', '1.143748',  'Один из самых знаменитых замков Дордони. Находится в красивой деревушке Бейнак-е-Казинак. В нем снимался отличный французский фильм "Пришельцы" с Жаном Рено и Кристианом Клавье',13);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,14,'','http://ru.wikipedia.org/wiki/%D0%97%D0%B0%D0%BC%D0%BE%D0%BA_%D0%91%D0%B5%D0%B9%D0%BD%D0%B0%D0%BA') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (19,14,' с тегом chateaudebeynac','http://www.flickr.com/photos/jaumebcn/tags/ch%C3%A2teaudebeynac/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (22,14,'Франция - Дордонь - замок Бейнак-эт-Казенак (Chateau de Beynac-et-Cazenac)','http://alla-hobbit.livejournal.com/331174.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (14,0,19,'Chateau de Beynac','http://farm9.staticflickr.com/8302/7984941121_4c48fe54d9_b.jpg') ;

-- Отель Данубиус Бук
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (2,'Место для проживания','Отели, квартиры, комнаты','livingplace','livingplaces') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (3,2,'Отель','Отели','hotel');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (6,3,'Спа-отель, курортный отель','spahotel');
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (5,1,'Венгрия','Венгрии','hungary') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (5,'Регион','Медье','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (11,5,'Западно-Задунайский край','Западно-Задунайского края','nyugatdunantul') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (13,11,'Ваш','vas') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (14,1,'Бюк','buk') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (15,         6,              13,               14,                0,                     'Danubius Health Spa Resort Buk','Danubius Health Spa Resort Buk','danubiusbuk','47.38452','16.78565','Курортный спа-отель на западе Венгрии в курортном городе Бюк');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,15,'','http://www.danubiushotels.com/en/our_hotels/hungary/bukfurdo/danubius_health_spa_resort_buk') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (23,100,'','booking.com',' на ',1,'http://booking.com/','booking') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,15,'','http://www.booking.com/hotel/hu/buk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (15,0,23,'Вид на отель Danubius Health Spa Resort Buk','http://r.bstatic.com/images/hotel/max600/113/11301254.jpg') ;

-- Бардейов (Словакия)
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (6,1,'Словакия','Словакии','slovakia') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`region_nikname_rod`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (6,'Край','Края','Район','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (12,6,'Прешовский','Прешовского','presovsky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (14,12,'Бардейов','bardejov') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (15,1,'Бардейов','bardejov') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (16,         4,              14,               15,                0,                     'Бардейов','Бардейов','bardejov','49.292382','21.276226','Небольшой город на севере Словакии недалеко от границы с Польшой. Огромная необычная центральная площадь. Внесен в список всемирного наследия Юнеско');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,16,'','http://www.bardejov.sk/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (24,100,'','Списке объектов мирового наследия ЮНЕСКО',' в ',1,'http://whc.unesco.org/en/list','unesco') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (24,16,'','http://whc.unesco.org/en/list/973') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (25,2,'Фотографии ','Miroslav Petrasko ',' в ленте ',1,'http://www.flickr.com/photos/theodevil/','flickr_theodevil') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (25,16,' с тегом bardejov','http://www.flickr.com/photos/theodevil/tags/bardejov/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`,`link_type_content_type`) VALUES (34,100,'Панорамы ','virtualtravel.sk',' на ',1,'http://www.virtualtravel.sk/','virtualtravel_sk',2) ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (34,16,'','http://www.virtualtravel.sk/ru/preshov/bardejov/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (16,0,25,'Center of Bardejov','http://farm7.staticflickr.com/6141/5939590794_64f1f6856b_b.jpg') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (16,1,34,'By the Statue of St. Florian','http://www.virtualtravel.sk/ru/panorama/preshov/bardejov/historic-centre/by-the-statue-of-st-florian/','http://www.virtualtravel.sk/embed.php?pid=1602&lang=ru&x=670&y=450') ;

-- Кежмарский замок
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (15,12,'Кежмарок','kezmarok') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (16,1,'Кежмарок','kezmarok') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (17,         2,              15,               16,                0,                     'Кежмарский замок','Кежмарского замка','kezmarskyzamok','49.139906','20.433213','Симпатичный замок на северо-западе Словакии в городке Кежмарок (что в переводе с немецкого означает "сырный рынок")');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,17,'','http://www.kezmarok.com') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,17,'','http://ru.wikipedia.org/wiki/%D0%9A%D0%B5%D0%B6%D0%BC%D0%B0%D1%80%D1%81%D0%BA%D0%B8%D0%B9_%D0%B7%D0%B0%D0%BC%D0%BE%D0%BA') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (26,3,'Пост ','материалах Nokola',' в ',1,'http://turbina.ru/authors/Nokola/','turbina_nokola') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (26,17,'Кежмарский замок зимой','http://turbina.ru/guide/Kezhmarok-Slovakiya-125932/Zametki/Kezhmarskiy-zamok-zimoy-58033') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (17,0,26,'Кежмарский замок','http://img4.tourbina.ru/photos.4/5/1/7/1/6/1461715/big.photo/Kezhmarskiy-zamok-zimoy.jpg') ;

-- Оравский град
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (13,6,'Жилинский','Жилинского','zilinsky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (16,13,'Долны Кубин','dolnykubin') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (17,1,'Долны Кубин','dolnykubin') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (18,         2,              16,               17,                8,                     'Оравский град','Оравского града','oravskyhrad','49.261717','19.359042','Пожалуй самый достойный замок во всей Словакии. Большой, на высокой скале, много-ярусный');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,18,'','http://www.oravamuzeum.sk/index.php/oravsky-hrad/fotogaleria') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,18,'','http://ru.wikipedia.org/wiki/%D0%9E%D1%80%D0%B0%D0%B2%D1%81%D0%BA%D0%B8%D0%B9_%D0%93%D1%80%D0%B0%D0%B4') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (27,100,'','замкимира.рф',' на ',1,'http://www.замкимира.рф','zamkimira') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (27,18,'','http://www.замкимира.рф/blog/oravskij_zamok/2012-09-20-110') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (18,0,27,'Оравский замок','http://www.замкимира.рф/foto/Slovensko/Oravsky/zamok_oravskij.jpg') ;

-- Спишский град
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (17,12,'Левоча','levoca') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (18,1,'Спишске Подградье','spisskepodhradie') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (19,         2,              17,               18,                1,                     'Спишский град','Спишского града','spisskyhrad','49.000021','20.768334','Самый большой замок Словакии, включен в список ЮНЕСКО. Частично разрушенный но при этом очень живописный');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,19,'','http://www.spisskyhrad.sk/en.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,19,'','http://ru.wikipedia.org/wiki/%D0%A1%D0%BF%D0%B8%D1%88%D1%81%D0%BA%D0%B8%D0%B9_%D0%93%D1%80%D0%B0%D0%B4') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (19,0,3,'Spissky Hrad in Slovakia','http://upload.wikimedia.org/wikipedia/commons/8/8b/Spisska_nova_ves...castle.jpg') ;


-- Банска Быстрица
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (14,6,'Банскобыстрицкий','Банскобыстрицкого','banskobystricky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (18,14,'Банска-Быстрица','banskabystrica') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (19,1,'Банска-Быстрица','banskabystrica') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (20,         4,              18,               19,                0,                     'Банска-Быстрица','Банска-Быстрица','banskabystrica','48.735531','19.146574','Старинный город в самом центре Словакии. Городской замок и много старых интересных домов. Есть даже своя падающая башня');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,20,'','http://www.banskabystrica.sk/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,20,'','http://ru.wikipedia.org/wiki/%D0%91%D0%B0%D0%BD%D1%81%D0%BA%D0%B0-%D0%91%D0%B8%D1%81%D1%82%D1%80%D0%B8%D1%86%D0%B0') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (28,2,'Фотографии ','Robert.BlueSky\'s photostream',' в ленте ',1,'http://www.flickr.com/photos/robert-bluesky/','flickr_robertbluesky') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (28,20,' Slovakia - Banska Bystrica','http://www.flickr.com/photos/robert-bluesky/sets/72157605973673966') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (29,100,'','Путешествия со всего света all-voyage.ru',' на ',1,'http://all-voyage.ru','allvoyageru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (29,20,'Достопримечательности Банска Быстрица','http://all-voyage.ru/dostoprimechatelnosti-banskoy-bystritcy.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (20,0,28,'vyhlad z Hodinovej Veze - nzmestie','http://farm4.staticflickr.com/3034/2686179330_4252dfcb89_b.jpg') ;

-- Городской замок в Банска Быстрица
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (21,         2,              18,               19,                0,                     'Городской замок "Барбакан" в Банска-Быстрица','Городского замка "Барбакан" в Банска-Быстрица','banskabystricabarbakan','48.737272','19.147212','Замок в центре города Банска Быстрица в центральной части Словакии. Резиденция короля Белы IV, а также сокровищница. Вообще-то "барбакан" - это название урепленных ворот в замок или крепость, а из-за красивого барбакана местный замок многие так и называют: Барбакан. Замок городского типа находится  в историческом центре Банской Быстрицы и является его неотъемлемой частью. Его старейшая постройка, церковь Романского стиля 13-го века, была укреплена и реставрирована в 15-ом столетии. Далее строились остальные части замка: Дом Маттиаса, городская Ратуша и Словацкий Храм. Въездные ворота, вместе с Барбаканом, построены в 1512-ом году.  После пожара в 1761-ом, храм перестроили в стиле Барокко. Деревянный "крылатый" алтарь, посвященный Святой Барбаре, сделанный мастером Паулем из Левочи, был спасен от огня. Сейчас его можно увидеть в здании бывшей городской ратуши, центральной Словацкой Региональной Галерее, два раза в год на выставках',20);
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (21,0,28,'vyhlad z Hodinovej Veze - barbakan','http://farm4.staticflickr.com/3076/2685384679_67490a3c57_b.jpg') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (21,1,34,'Mestsky hrad Barbakan','http://www.virtualtravel.sk/sk/panorama/banskobystricky-kraj/banska-bystrica/zaujimavosti-mesta/mestsky-hrad-barbakan/','http://www.virtualtravel.sk/embed.php?pid=1083&lang=ru&x=670&y=450') ;

-- Ресторан Барбакан в ББ
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (3,'Ресторан, Бар, Кафе','Рестораны и кафе','rbc','restaurants') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (4,3,'Ресторан','Рестораны','restaurant');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (7,4,'Ресторан восточно-европейской кухни','easteuroperestaurant');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (22,         7,              18,               19,                0,                     'Ресторан "Barbakan" в Банска-Быстрица','Ресторана "Barbakan" в Банска-Быстрица','banskabystricabarbakanrestaurant','48.737272','19.147212','Ресторан прямо в самом городском замке "Барбакан" в центре города Банска Быстрица',21);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,22,'','http://www.bystrickybarbakan.sk/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (22,0,28,'vyhlad z Hodinovej Veze - barbakan','http://farm4.staticflickr.com/3076/2685384679_67490a3c57_b.jpg') ;

-- Падающая башня в Банска Быстрица
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (8,1,'Башня','tower');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (23,         8,              18,               19,                0,                     'Падающая башня в Банска Быстрица','Падающей башни  в Банска-Быстрица','leaningtowerbb','48.735959','19.146423','На центральной площади города Банска Быстрица ("Старой площади") есть своя падающая башня. Она, конечно же, не так известна как Пизанская. Отклоняется от вериткали вверху всего на 70см.',20);
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (23,0,28,'Падающая башня Банска Быстрица Словакия','http://farm4.staticflickr.com/3185/2636571406_1a15544b31_b.jpg') ;

-- Отель Kuria в Банска Быстрица
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (9,3,'Городской отель','cityhotel');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (24,         9,              18,               19,                0,                     'Отель "Kuria" в Банска-Быстрица','Отеля "Kuria"  в Банска-Быстрица','banskabystricakuria','48.737965','19.145372','Трехзвездочный отель в самом центре Банска Быстрица, у самой городской крепости, 100м до пешеходной зоны',20);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,24,'','http://www.kuria.sk/index.php/en/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,24,'','http://www.booking.com/hotel/sk/penzion-kuria.ru.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (24,0,2,'Отель kuria банска быстрица словакия','http://www.kuria.sk/images/phocagallery/exterier/thumbs/phoca_thumb_l_kuria_leto_den.jpg') ;


-- Зволенский замок
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (19,14,'Зволен','Zvolen') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (20,1,'Зволен','Zvolen') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (25,         2,              19,               20,                0,                     'Зволенский замок','Зволенского замка','zvolencastle','48.573022','19.12739','Замок в городе Зволен в центральной части Словакии. Построен королем Польши Людовиком I Великим. Никогда не был взят');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,25,'','http://ru.wikipedia.org/wiki/%D0%97%D0%B2%D0%BE%D0%BB%D0%B5%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%B7%D0%B0%D0%BC%D0%BE%D0%BA') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (30,100,'','Замки Европы castlesguide.ru',' на сайте ',1,'http://www.castlesguide.ru','castlesguideru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (30,25,'','http://www.castlesguide.ru/slovakia/zvolensky.html') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (31,2,'Фотографии ','Peter Fenda\'s photostream',' в ленте ',1,'http://www.flickr.com/photos/peterfenda/','flickr_peterfenda') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (25,0,31,'Zvolen Castle (Zvolensky zamok)','http://farm5.staticflickr.com/4132/5173783351_1d6b10f6fb_b.jpg') ;


-- Мотель "Под Замком" Невицкое
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (7,1,'Украина','Украины','ukraine') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`region_nikname_rod`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (7,'Область','Области','Район','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (15,7,'Закарпатская','Закарпатской','zakarpatskaya') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (20,15,'Ужгородский','uzhgorodsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (21,2,'Невицкое','nevitskoe') ;
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (10,3,'Мотель','motel');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (26,         10,             20,               21,                0,                     'Мотель "Под Замком"','Мотеля "Под Замком"','podzamkommotel','48.685089','22.403634','Придорожный мотель под Ужгородом в селе Невицкое. Рядом Невицкий замок (полуразваленный). Находится по дороге из Ужгорода к пограничноу переходу "Малый Березный - Убла", удобно заночевать перед переходом границы');
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (32,100,'','doroga.ua',' на ',1,'http://www.doroga.ua','dorogaua') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (32,26,'','http://www.doroga.ua/hotel/Zakarpatskaya/Nevickoe/Pod_zamkom/3399') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (26,0,32,'Мотель Под Замком Невицкое','http://www.doroga.ua/Handlers/ContentImageHandler.ashx?CatalogHotelPhotoCatalogHotelID=3399&Size=Big') ;


-- Любовньянский Град
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (21,12,'Стара Любовня','staralubovna') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (22,1,'Стара Любовня','staralubovna') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (27,         2,             21,               22,                 0,                     'Любовньянский Град','Любовньянского Града','lubovnianskyhrad','49.314775','20.698897','Замок на самом севере Словакии в городе Стара Любовна. Рядом с замком есть еще музей под открытым небом');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,27,'','http://www.muzeumsl.sk/en/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,27,'','http://ru.wikipedia.org/wiki/%D0%9B%D1%8E%D0%B1%D0%BE%D0%B2%D0%BD%D1%8C%D1%8F%D0%BD%D1%81%D0%BA%D0%B8%D0%B9_%D0%93%D1%80%D0%B0%D0%B4') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (27,0,2,'Любовньянский Град Словакия замок','http://files.muzeumsl.sk/200000633-101f61118d-public/03.jpg') ;

-- Гуменне
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (22,12,'Гуменне','humenne') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (23,1,'Гуменне','humenne') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (28,         4,             22,               23,                 0,                     'Гуменне','Гуменне','humenne','48.933806','21.909893','Небольшой город на востоке Словакии недалеко (50км) от границы с Украиной');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,28,'','http://www.humenne.sk/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,28,'','http://ru.wikipedia.org/wiki/%D0%93%D1%83%D0%BC%D0%B5%D0%BD%D0%BD%D0%B5') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (28,0,3,'Гуменне Словакия Замок','http://upload.wikimedia.org/wikipedia/commons/d/d6/Humenn%C3%A9.castle.jpg') ;


-- Мармарис (Турция)
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (8,1,'Турция','Турции','turkey') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (8,'Ил','Район','Регион','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (16,8,'Мугла','Муглы','mugla') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (23,16,'Мармарис','marmaris') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES ( 24,1,'Мармарис','marmaris') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (29,         4,              23,               24,                0,                     'Мармарис','Мармариса',       'marmaris',     '36.852239','28.274893','Очаровательный курортный городок на юго-западе Турции');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,29,'','http://ru.wikipedia.org/wiki/%D0%9C%D0%B0%D1%80%D0%BC%D0%B0%D1%80%D0%B8%D1%81') ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (3,'Вид на центр Мармариса с крепости','2012_04_29_turkey/marmaris/IMG_1490_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (29,0,3) ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (149,594,29) ;


-- Ичмелер
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (25,1,'Ичмелер','icmeler') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (30,         4,              23,               25,                0,                     'Ичмелер','Ичмелера','icmeler', '36.805299','28.232106','Курортный городок на юго-востоке Турции рядом с Мармарисом');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,30,'','http://en.wikipedia.org/wiki/%C4%B0%C3%A7meler') ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (4,'Бухта Ичмелера','2012_04_29_turkey/ichmeler/IMG_0413_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (30,0,4) ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (153,594,30) ;


-- Мармарис Палас
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (31,         6,              23,               24,                6,                     'Grand Yazici Marmaris Palace','Grand Yazici Marmaris Palace','marmarispalace',     '36.818583','28.243355','Турецкий отель с большой территорией между Мармарисом и Ичмелером',29);
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (33,100,'Описание ','turtess.com',' на ',1,'http://turtess.com','turtess') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,31,'','http://www.turtess.com/ru/hotel/364') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,31,'','http://www.grandyazicihotels.com/palace/en/index.php') ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (5,'Вид на главный корпус Marmaris Palace от бассейна','2012_04_29_turkey/marmarispalace/IMG_0331_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (31,0,5) ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (148,594,31) ;

-- Марес
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (32,         6,              23,               24,                5,                     'Grand Yazici Mares Hotel','Grand Yazici Mares Hotel','marmarismares',     '36.823654','28.242867','Турецкий отель с большой территорией между Мармарисом и Ичмелером',29);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,32,'','http://www.turtess.com/ru/hotel/342') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,32,'','http://www.grandyazicihotels.com/mares/en/index.php') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (32,0,33,'Вид с моря на отель Марес Мармарис Турция','http://www.turtess.com/images_p2/342/big/grand_yazici_mares_1.jpg') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (151,594,32) ;

-- Клаб Турбан
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (33,         6,              23,               24,                4,                     'Grand Yazici Club Turban','Grand Yazici Club Turban','marmaristurban',     '36.829309','28.24291','Турецкий отель с большой территорией между Мармарисом и Ичмелером',29);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,33,'','http://www.turtess.com/ru/hotel/695') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,33,'','http://www.grandyazicihotels.com/turban/en/index.php') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (33,0,33,'Вид с моря на отель Клаб Тюрбан Мармарис Турция','http://www.turtess.com/images_p2/695/big/grand_yazici_club_turban_1.jpg') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (151,594,33) ;

-- Банска Штьявница
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (24,14,'Банска-Штьявница','banskastiavnica') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (26,1,'Банска-Штьявница','banskastiavnica') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (34,         4,              24,               26,                0,                     'Банска-Штьявница','Банска-Штьявница','banskastiavnica','48.458964','18.892128','Старинный городок в центре Словакии. Два замка, много старых интересных домов');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,34,'','http://www.banskastiavnica.sk/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,34,'','http://ru.wikipedia.org/wiki/%D0%91%D0%B0%D0%BD%D1%81%D0%BA%D0%B0-%D0%A8%D1%82%D1%8C%D1%8F%D0%B2%D0%BD%D0%B8%D1%86%D0%B0') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (34,0,3,'Main place of Banska Stiavnica','http://upload.wikimedia.org/wikipedia/commons/thumb/1/12/Bansk%C3%A1_%C5%A0tiavnica_40326.jpg/1024px-Bansk%C3%A1_%C5%A0tiavnica_40326.jpg') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (35,100,'','Заметки о путешествиях - Rina Rina',' на ',1,'http://rina-rina.ru/','rinarina') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (35,34,'Словакия проездом. День в Банска Штьявнице','http://rina-rina.ru/2012/05/slovakiya-proezdom-den-v-banska-shtyavnice/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (24,34,'','http://whc.unesco.org/en/list/618') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (34,1,34,'Town Hall Square, Historic City Core','http://www.virtualtravel.sk/ru/panorama/banska-bystrica/banska-stiavnica/historic-city-core/town-hall-square/','http://www.virtualtravel.sk/embed.php?pid=1061&lang=ru&x=670&y=450') ;

-- Банска Штьявница Старый замок
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                   `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (35,         2,              24,               26,                0,                     'Старый замок в Банска-Штьявница','Старого замка в Банска-Штьявница','banskastiavnicaoldcastle','48.45959','18.890664','Городской замок, основу которого составила первоначальная  базилика в романском стиле с тремя нефами, построенная в первой половине 13-го века. В свою очередь, в 15-ом и 16-ом веках базилику перестроили в Готический собор, который позже укрепили замковыми стенами с бастионами. В середине 16-го века весь замковый комплекс опять перестроили,  на этот раз как крепость для защиты от турков. Сейчас в замковых постройках находится Словацкая Выставка Горной Промышленности. Старый и Новый замки, изображение распятия и памятники горной промышленности в окрестностях, включены в Список Всемирного Наследия ЮНЕСКО',34);
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (35,1,34,'Cannon Bastion, Old Castle, Banska Stiavnica','http://www.virtualtravel.sk/ru/panorama/banska-bystrica/banska-stiavnica/old-castle/cannon-bastion/','http://www.virtualtravel.sk/embed.php?pid=1056&lang=ru&x=670&y=450') ;

-- Банска Штьявница Новый замок
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                   `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (36,         2,              24,               26,                0,                     'Новый замок в Банска-Штьявница','Нового замка в Банска-Штьявница','banskastiavnicanewcastle','48.455822','18.895953','Новый Замок был построен между 1564-1571 годами в городской крепости для защиты от турков, как постройка для наблюдения, и как часть системы оповещения Центральной Словакии. Замок состоит из большой квадратной башни с  четырьмя угловыми бастионами круглой формы. Сейчас это доминирующая часть города Банска Штьявница. В замке можно увидеть выставку, посвященную борьбе словак с турками. Старый и Новый замки, изображение распятия и памятники горной промышленности в окрестностях, включены в Список Всемирного Наследия ЮНЕСКО',34);
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`,`link_iframe_src`) VALUES (36,1,34,'New Castle, Historic City Core, Banska Stiavnica','http://www.virtualtravel.sk/ru/panorama/banska-bystrica/banska-stiavnica/historic-city-core/new-castle/','http://www.virtualtravel.sk/embed.php?pid=1051&lang=ru&x=670&y=450') ;


-- Бойницкий замок
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (17,6,'Тренчинский','Тренчинского','trenciansky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (25,17,'Прьевидза','prievidza') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (27,1,'Бойнице','bojnice') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (37,         2,              25,               27,                0,                     'Бойницкий замок','Бойницкого замка','bojnickyzamok','48.779935','18.577736','Замок Бойнице - один из самых старых и значительных словацких замков. Первоначальный Готический Замок был построен около 1300 года. Известно, что первые владельцы замка были  сыновьями магната Казимира, родом из венгерского клана Хонт-Познань. Позже он был захвачен Матушем Чаком Тренчианским. После его смерти замок стал королевской собственностью, и   владельцы менялись несколько раз. Он был захвачен Запольской семьей на долгий период времени, позже Дурзоской, которая укрепила и расширила замок в 16-ом столетии. На современный вид замка повлиял Ян Палфи, который реставрировал его (1889 год), по примеру типичной модели французских средневековых замков. Но Готические и Ренессансные элементы дизайна остались хорошо сохранившимися. В привлекательном замке есть большой замковый парк со знаменитой  липой - Матей Корвин Липа. Живой уголок и замковая пещера - также  часть парка. Замок переделан в музей и центр различных социальных и культурных встреч. Здесь регулярно даются концерты классической музыки. Список мероприятий продолжается представлениями исторических боев с мечами и традиционным фестивалем привидений и прочих монстров');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,37,'','http://www.bojnicecastle.sk/index-en.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,37,'','http://ru.wikipedia.org/wiki/%D0%91%D0%BE%D0%B9%D0%BD%D0%B8%D1%86%D0%BA%D0%B8%D0%B9_%D0%B7%D0%B0%D0%BC%D0%BE%D0%BA') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (37,0,2,'Словакия Бойницкий замок','http://www.bojnicecastle.sk/foto/02-7.jpg') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (36,1,'Пост ','ЖЖ "Хороший Блог" horoshiyblog',' в ',0,'http://horoshiyblog.livejournal.com/','lj_horoshiyblog') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (36,37,'"Бойнице. Крушение стереотипов о Словакии-2"','http://horoshiyblog.livejournal.com/76807.html') ;


-- Крепость Мармариса
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,        `point_name_rod`,    `point_alias`,   `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (38,         1,              23,               24,                0,                     'Крепость Мармариса','Крепости Мармариса','marmariscastle','36.850578','28.274367','Крепость в центре курортного города Мармарис на юго-востоке Турции, построенная самим Сулейманом Великолепным',29);
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (150,594,38) ;
INSERT INTO `#__te_photos` (`photo_id`,`photo_name`,`photo_path`) VALUES (6,'Старая крепость в Мармарисе Турция','2012_04_29_turkey/marmariscastle/IMG_1493_900.jpg') ;
INSERT INTO `#__te_points_photos` (`point_id`,`photo_order`,`photo_id`) VALUES (38,0,6) ;


-- Братиславский град
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (18,6,'Братиславский','Братиславского','bratislavsky') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (26,18,'Братислава 1','bratislava1') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (28,1,'Братислава','bratislava') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (39,         2,              26,               28,                0,                     'Братиславский град','Братиславского града','bratislavskyhrad','48.142322','17.10000','Замок в Братиславе значительно выделяется среди остальных исторических достопримечательностей Словакии. Впервые был упомянут как оборонительные валы в письменных источниках 907 года. Замок построен в стратегическом месте, в Кельтский период и эпоху Великой Моравской Империи.  В 9-ом столетии происходило строительство дворца и  базилики на территории замка. После 1245 года была построена резиденция в крепости на замковой горе, позже окруженная замковыми стенами, а еще позже на ее юго-восточной границе была построена цитадель, известная как Коронационная крепость. В первой половине 15-го века значительная реставрации была проведена под влиянием короля Сигизмунда в связи с укреплением западных исторических венгерских земель против гуситов. На месте старого замка был возведен трехэтажный Готический Дворец. В середине 16-го века, когда Братислава стала столицей венгерских земель, замок был реставрирован в Ренессансном стиле. В первой половине 17-го века Микулаш Палфи построил еще один этаж Дворца, и дополнил первоначальные Готические Башни еще двумя.  Но сегодняшний вид замка обязан классическому стилю реставрации, проведенной Марией Терезой в 18-ом столетии. Когда королевский двор переехал в Вену, Йозеф II учредил семинарию в замке в 1784 году, и многие ученые люди того времени обучались именно там. В 1811-ом замок был сожжен, и реставрация произошла намного позже, в 60-их годах 20-го столетия. Сейчас там находятся государственные комнаты президента и парламента Словацкой республики вместе с выставками Словацкого Национального музея');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,39,'','http://www.bratislava-hrad.sk/en') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,39,'','http://ru.wikipedia.org/wiki/%D0%91%D1%80%D0%B0%D1%82%D0%B8%D1%81%D0%BB%D0%B0%D0%B2%D1%81%D0%BA%D0%B8%D0%B9_%D0%93%D1%80%D0%B0%D0%B4') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (39,0,3,'Slovenсina: Bratislava, hrad, Slovensko','http://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Bratislava%2C_Hrad%2C_Slovensko.jpg/1024px-Bratislava%2C_Hrad%2C_Slovensko.jpg') ;


-- Марти ресорт
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (40,         6,              23,               25,                0,                     'Marti Resort Deluxe','Marti Resort Deluxe','martiresort',     '36.805943','28.231956','Лучший отель в Ичмелере (Турция) судя по отзывам и рассказам очевидцев',30);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,40,'','http://www.turtess.com/ru/hotel/222') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,40,'','http://www.marti.com.tr/Tesis.aspx') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (153,594,40) ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (40,0,33,'Вид с моря на отель Марти Ресорт Ичмелер Турция','http://www.turtess.com/images_p2/222/big/1_marti_resort_deluxe-23.jpg') ;

-- Марти Ла Перла
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (41,         6,              23,               25,                0,                     'Marti La Perla','Marti La Perla','martilaperla','36.804436','28.232203','Один из лучших отелей Ичмелера (Турция) судя по внешнему виду и описанию',30);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (33,41,'','http://www.turtess.com/ru/hotel/220') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,41,'','http://www.marti.com.tr/Tesis.aspx') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (153,594,41) ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (41,0,33,'Вид с моря на отель Марти Ла Перла Ичмелер Турция','http://www.turtess.com/images_p2/220/big/1_marti_la_perla-12.jpg') ;


-- Дальян
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (27,16,'Ортаджа','ortaca') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (29,1,'Дальян','dalyan') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (42,         4,              27,               29,                0,                     'Дальян','Дальяна','dalyan', '36.834294','28.642387','Город на юго-востоке Турции, находящийся у устья одноименной реки, популярный у туристов благодаря расположенным рядом достопримечательностям');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,42,'','http://ru.wikipedia.org/wiki/%D0%94%D0%B0%D0%BB%D1%8C%D1%8F%D0%BD') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,42,'','http://www.dalyan.bel.tr/') ;
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,42) ;

-- Ликийские гробницы
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (11,1,'Гробницы','tomb');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (43,         11,             27,               29,                0,                     'Ликийские гробницы','Ликийских гробниц','dalyantombs', '36.830619','28.634588','Древние ликийские гробницы, высеченные в скале над рекой Дальян, рядом с городом, котоый тоже назывется Дальян, на юго-востоке Турции');
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,43) ;


-- Пляж Изтузу
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (5,1,'Природная достопримечательность','Природные достопримечательности','naturepoint');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (12,5,'Пляж','beach');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (44,         12,             27,               29,                7,                     'Пляж Изтузу','Пляжа Изтузу','istuzubeach', '36.79621','28.617282','Огромный природный пляж протяженностью 4,5 км. Находится в нескольких километрах от города Дальян вниз по реке Дальян. Известен как одно из немногих мест, где откладывают яйца морские черепахи редкого вида Caretta caretta');
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,44) ;

-- Грязелечебница
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (6,1,'Место отдыха и развлечения','Места отдыха и развлечения','relaxpoint');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (13,6,'Аквапарк, бассейн, сауна','aquapark');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (45,         13,             27,               29,                1,                     'Грязелечебница','Грязелечебницы','mudcure', '36.844049','28.63043','Комплекс с лечебными грязями и термальным источником возле турецкого города Дальян');
INSERT INTO `#__te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,45) ;


-- Ресторан Каунос
INSERT INTO `ixjun_te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,`point_name_rod`, `point_alias`,  `point_lat`, `point_lon`,    `point_descr`) 
                       VALUES (46,         7,              27,               29,                1,                     'Ресторан Каунос','Ресторана Каунос','kaunos', '36.827588','28.630924','Ресторан на берегу реки Дальян недалеко от одноименного курортного города в Турции. Обслуживает подъезжающих на лодках туристов');
INSERT INTO `ixjun_te_points_posts` (`post_article`,`post_menuitem`,`post_point`) VALUES (156,594,46) ;


-- Львов
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (19,7,'Львовская','Львовской','lvovskaya') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (28,19,'Львов','lvov') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (30,1,'Львов','lvov') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (47,         4,              28,               30,                0,                     'Львов','Львова','lvov','49.841899','24.031649','Самый известный туристичнеский город Украины. Настоящий европейский город, огромное количество достопримечательностей');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,47,'','http://city-adm.lviv.ua/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,47,'','http://ru.wikipedia.org/wiki/%D0%9B%D1%8C%D0%B2%D0%BE%D0%B2') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (47,0,3,'Панорама Львова','http://upload.wikimedia.org/wikipedia/commons/c/c7/Lemberg_Panorama_20.JPG') ;

-- Гранд-отель
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (48,         9,              28,               30,                0,                     '"Гранд-Отель" во Львове','"Гранд-Отеля" во Львове','grandhotellvov','49.84075','24.027121','Четырехзвездочный отель в центре Львова на площади Свободы',47);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,48,'','http://grandhotel.lviv.ua/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,48,'','http://www.booking.com/hotel/ua/grand-lviv.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (48,0,2,'Львов. Гранд-Отель','http://grandhotel.lviv.ua/gallery/full/hotel20.jpg') ;

-- Отель Жорж
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (49,         9,              28,               30,                0,                     'Отель "Жорж" во Львове','Отеля "Жорж" во Львове','hotelgeorgelvov','49.838809','24.030527','Трехзвездочный отель в центре Львова на площади Свободы, прямо возле памятника Адаму Мицкевичу. Это самый старый из действующих сейчас отелей не только Львова, но и всей Украины',47);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,49,'','http://www.georgehotel.com.ua/ua/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,49,'','http://www.booking.com/hotel/ua/george.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (49,0,2,'Львов. Отель Жорж','http://img-fotki.yandex.ru/get/4409/13341501.8/0_69b23_f407b5f5_XXXL') ;

-- Отель Медиваль
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`, `point_parent`) 
                    VALUES (50,         9,              28,               30,                0,                     'Отель "Reikartz Медиваль" во Львове','Отеля "Reikartz Медиваль" во Львове','hotelreikartzlvov','49.843559','24.03185','Четырехзвездочный отель в центре Львова, недалеко от Ратуши',47);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,50,'','http://www.reikartz.com/ru/hotels/medievale-lvov') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,50,'','http://www.booking.com/hotel/ua/reikartz-medievale-lviv.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (50,0,2,'Львов. Отель Reikartz Медиваль','http://www.reikartz.com/files/_thumbs/244_700x500_dim1.jpg') ;

-- Заправка ОККО Броды
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (4,'Объект инфраструктуры','Объекты инфраструктуры','infrastructure','infrastructures') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (7,4,'Автодорожная инфраструкутра','Объекты автодорожной инфраструкутры','autoinfrastructure');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (14,7,'Заправка','gasstation');
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (29,19,'Бродовский','brodovsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (31,1,'Броды','brody') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (51,         14,             29,               31,                0,                     'Заправка ОККО в Бродах','Заправки ОККО в Бродах','okkobrody','50.067938','25.163863','Заправка сети ОККО в г. Броды между Ровно и Львовом. Есть "La Minute"');

-- Заправка ОККО Стрый
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (30,19,'Стрыйский','strysky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (32,1,'Стрый','stry') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (52,         14,             30,               32,                0,                     'Заправка ОККО в Стрые','Заправки ОККО в Стрые','okkostry','49.247638','23.856677','Заправка сети ОККО в г. Стрый по дороге из Львова на Ужгород. Есть "La Minute"');

-- Заправка ОККО Сколе
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (31,19,'Сколевский','skolevsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (33,1,'Сколе','skole') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (53,         14,             31,               33,                0,                     'Заправка ОККО в Сколе','Заправки ОККО в Сколе','okkoskole','49.043639','23.510946','Заправка сети ОККО в г. Сколе по дороге из Львова на Ужгород. Есть "La Minute"');


-- Пограничный переход Малый Березный - Убла
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (15,7,'Пограничный переход','borderpass');
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (32,15,'Великоберезнянский','velikobereznjansky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (34,2,'Малый Березный','malyberezny') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (54,         15,             32,               34,                3,                     'Пограничный переход Малый Березный - Убла','Пограничного перехода Малый Березный - Убла','mbereznyubla','48.883944','22.420558','Пограничный переход Малый Березный - Убла между Украиной и Словакией. Менее удобный по расстоянию чем Ужгородский, но обычно менее загруженный. Пропускает пешеходов');

-- Пограничный переход Ужгород - Вышне Немецке
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (35,1,'Ужгород','uzhgorod') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (55,         15,             20,               35,                1,                     'Пограничный переход Ужгород - Вышне Немецке','Пограничного перехода Ужгород - Вышне Немецке','uzhgorodvysnenenecke','48.654927','22.265103','Пограничный переход Ужгород - Вышне Немецке  - основной переход между Украиной и Словакией. Находится практически в самом Ужгороде. Обычно загружен');

-- Пограничный переход Чоп-Захонь
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (36,1,'Чоп','chop') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (56,         15,             20,               36,                7,                     'Пограничный переход Чоп-Захонь','Пограничного перехода Чоп-Захонь','chopzahon','48.417567','22.17056','Пограничный переход Чоп-Захонь - основной переход между Украиной и Венгрией. Один из самых больших пограничных переходов в Европе, имеет даже собственное имя - "Тиса"');

-- Пограничный переход Берегово-Берегшурани
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (33,15,'Береговский','beregovsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (37,1,'Берегово','beregovo') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                              `point_name_rod`,                            `point_alias`, `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (57,         15,             33,               37,                5,                     'Пограничный переход Берегово-Берегшурани','Пограничного перехода Берегово-Берегшурани','beregovoberegshurani',   '48.164969','22.573192','Пограничный переход Берегово-Берегшурани - один из переходов между Украиной и Венгрией');

-- Пограничный переход Вилок-Тисабеч
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (34,15,'Виноградовский','vinogradovsky') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (38,2,'Вилок','vilok') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                              `point_name_rod`,                            `point_alias`, `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (58,         15,             34,               38,                2,                     'Пограничный переход Вилок-Тисабеч','Пограничного перехода Вилок-Тисабеч','viloktysabech',   '48.093216','22.834568','Пограничный переход Вилок-Тисабеч - один из пограничных переходов между Украиной и Венгрией');


-- Отель Корона 
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (20,5,'Северный Альфёльд','Северного Альфёльда','eszakalfold') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (35,20,'Сабольч-Сатмар-Берег','szabolcsszatmarbereg') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (39,1,'Ньиредьхаза','nyiregyhaza') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (59,         9,              35,               39,                0,                     'Korona Hotel','Korona Hotel','koronahotelnyiregyhaza','47.956281','21.717181','Трехзвездочный отель в самом центре Ньиредьгазы расположен на центральной площади в историческом здании');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,59,'','http://www.korona-hotel.hu') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,59,'','http://www.booking.com/hotel/hu/korona-nyiregyhaza.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (59,0,23,'Вид на отель Danubius Health Spa Resort Buk','http://q.bstatic.com/images/hotel/max600/145/1452579.jpg') ;


-- Отель Салирис 
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (21,5,'Северная Венгрия','Северной Венгрии','eszakmagyarorszag') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (36,21,'Хевеш','heves') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (40,1,'Эгерсалок','egerszalok') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (60,         6,              36,               40,                0,                     'Saliris Resort Spa Hotel','Saliris Resort Spa Hotel','salirisegersalok','47.854955','20.335286','Четырехзвездочный термальный спа-отель');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,60,'','http://www.salirisresort.hu/ru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,60,'','http://www.booking.com/hotel/hu/saliris-resort.uk.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (60,0,2,'Вид на отель Saliris Resort Spa Hotel','http://upload.wikimedia.org/wikipedia/commons/a/aa/Egerszal%C3%B3k.jpg') ;


-- Магазин telenor в Ньередьгазе
INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_name_pl`,`point_class_alias`,`point_class_alias_pl`) VALUES (5,'Магазин','Магазины','shop','shops') ;
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (8,5,'Специализированный магазин','Специализированные магазины','specialshop');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (16,8,'Салон мобильной связи','mobileshop');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (61,         16,             35,               39,                0,                     'Telenor. 4400 Nyiregyhaza Rakoczi utca 18','Telenor. 4400 Nyiregyhaza Rakoczi utca 18','telenornyiregyhaza','47.9588','21.71186','Салон оператора Telenor');

-- Торговый центр korzo в Ньередьгазе
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (9,5,'Торговый центр','Торговые центры','shoppingcenters');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (17,9,'Торговый центр','shoppingcenter');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (62,         17,             35,               39,                0,                     'Торговый центр Korzo','Торгового центра Korzo','korzonyiregyhaza','47.958178','21.717626','Торговый центр в центре венгерского города Ньиредьгаза');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,62,'','http://korzo.hu/english') ;

-- Полгар outlet
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (18,9,'Аутлет-центр','outletcenter');
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (37,20,'Хайду-Бихар','hajdubihar') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (41,1,'Полгар','polgar') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (63,         18,             37,               41,                2,                     'Аутлет-центр "Полгар"','Аутлет-центра "Полгар"','polgaroutlet','47.843615','21.14336','Аутлет-центр в районе венгерского города Полгар на автобане M3');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,63,'','http://www.m3outlet.hu/en') ;

-- Кёсег
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (42,1,'Кёсег','koszeg') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (64,         4,              13,               42,                0,                     'Кёсег','Кёсега','koszeg','47.389852','16.540368','Хорошо сохранившийся со средневековых времен город на западе Венгрии, недалеко от границы с Австрией. Интерес представляет исторический центр с множестовом старинных зданий. Главная достопримечательность - крепость Юришича, выдержавшая длительную осаду турецкой армии. Этой героической обороной крепости Кёсег известен на весь мир');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,64,'','http://www.koszeg.hu/nyelvek/en/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,64,'','http://ru.wikipedia.org/wiki/%D0%9A%D1%91%D1%81%D0%B5%D0%B3') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (64,0,3,'Центральная площадь венгерского города Кесег','http://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Koszeg_fo_ter.JPG/1024px-Koszeg_fo_ter.JPG') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (37,1,'Пост ','ЖЖ "ГОРИЗОНТЫ" evelevich',' в ',0,'http://evelevich.livejournal.com/','lj_evelevich') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (37,64,'Венгрия-2006: Кёсёг, Шюмег и рыцари','http://evelevich.livejournal.com/21121.html') ;


-- Кёсег - крепость Юришича
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (65,         1,              13,               42,                0,                     'Крепость Юришича в Кёсеге','Крепости Юришича в Кёсеге','koszegfortress','47.389648','16.538672','Крепость в городе Кёсег названа в честь командира гарнизона Миклоша Юришича, под командованием которого крепость выдержала длительную осаду турков',64);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,65,'','http://www.koszeg.hu/nyelvek/en/sightseeing/content.php?id=1475') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (65,0,2,'Крепость Юришича в венгерском городе Кесег','http://www.koszeg.hu/pictures/fotoalbumok/1/2/fotobigpic811.jpg') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (38,100,'','Замки Венгрии',' на сайте ',1,'http://www.zamkivengrii.ru','zamkivengrii') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (38,65,'','http://www.zamkivengrii.ru/keseg-krepost-krepostnoy-muzey-miklosha-yurishicha.html') ;


-- Шарвар
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (43,1,'Шарвар','sarvar') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (66,         4,              13,               43,                0,                     'Шарвар','Шарвара','sarvar','47.254082','16.93521','Город на западе Венгрии. Из достопримечательностей есть несколько интересных церквей и соборов, а также крепость с музеем. Также есть большой современный спа-комплекс. В переводе с венгерского название города Sarvar звучит как "грязная крепость"');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,66,'','http://www.sarvar.hu/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,66,'','http://en.wikipedia.org/wiki/S%C3%A1rv%C3%A1r') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (66,0,3,'Вид на город Шарвар (Венгрия) с крепости','http://farm8.staticflickr.com/7078/7294065228_450d016cd1_b.jpg') ;

-- Шарвар - крепость Надашди
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (67,         1,              13,               43,                0,                     'Крепость Надашди в Шарваре','Крепости Надашди в Шарваре','sarvarfortress','47.252458','16.936777','Крепость в городе Шарвар, сохранившаяся с 13-го века',66);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,67,'','http://nadasdymuzeum.hu/index.php') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (67,0,2,'Крепость Надажди в венгерском городе Шарвар','http://nadasdymuzeum.hu/images/nfm51.jpg') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (38,67,'','http://www.zamkivengrii.ru/sharvar-krepost-muzey-ferentsa-nadashdi.html') ;


-- Эгер
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (44,1,'Эгер','eger') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (68,         4,              36,               44,                0,                     'Эгер','Эгера','eger','47.902843','20.375894','Город на северо-востоке Венгрии. Много достопримечательностей');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,68,'','http://www.eger.hu/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,68,'','http://ru.wikipedia.org/wiki/%D0%AD%D0%B3%D0%B5%D1%80_%28%D0%B3%D0%BE%D1%80%D0%BE%D0%B4%29') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (68,0,3,'Вид города Эгер (Венгрия)','http://upload.wikimedia.org/wikipedia/commons/thumb/c/c2/Eger_a_v%C3%A1rb%C3%B3l.jpg/1024px-Eger_a_v%C3%A1rb%C3%B3l.jpg') ;

-- Эгер - крепость
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (69,         1,              36,               44,                0,                     'Эгерская крепость','Эгерской крепости','egerfortress','47.90439','20.379059','Крепость в Эгере - жемчужина и без того богатого на достопримечательности города. Героически противостояла длительной осаде туроков в 1552 г., и только через 44 года была все-таки взята',68);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,69,'','http://www.egrivar.hu/en/index.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (69,0,3,'Крепость Эгера','http://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Eger_-_Dob%C3%B3_Square.JPG/1024px-Eger_-_Dob%C3%B3_Square.JPG') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (38,69,'','http://www.zamkivengrii.ru/eger-krepost-krepostnoy-muzey-ishtvana-dobo.html') ;


-- Будапешт
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (22,5,'Центральная Венгрия','Центральной Венгрии','kozepgyarorszag') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (38,22,'Будапешт','budapest') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (45,1,'Будапешт','budapest') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (70,         4,              38,               45,                0,                     'Будапешт','Будапешта','budapest','47.498358','19.040422','Столица Венгрии и самый большой ее город. Огромное количество достопримечательностей и других точек интереса на все вкусы. Один их городов Европы, который обязательно надо увидеть своими глазами');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,70,'','http://budapest.hu/sites/english/Lapok/default.aspx') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,70,'','http://ru.wikipedia.org/wiki/%D0%91%D1%83%D0%B4%D0%B0%D0%BF%D0%B5%D1%88%D1%82') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (70,0,3,'Вид на Будапешт','http://upload.wikimedia.org/wikipedia/commons/thumb/6/61/Budape%C5%A1%C5%A5_0753.jpg/1024px-Budape%C5%A1%C5%A5_0753.jpg') ;

-- Вена
INSERT INTO `#__te_countries`(`country_id`,`country_continent`,`country_name`,`country_name_rod`,`country_alias`) VALUES (9,1,'Австрия','Австрии','austria') ;
INSERT INTO `#__te_region_names`(`country_id`,`region_nikname`,`subregion_nikname`,`regiongroup_nikname`,`subregiongroup_nikname`) VALUES (9,'Федеральная земля','Административный район','','') ;
INSERT INTO `#__te_regions`(`region_id`,`region_country`,`region_name`,`region_name_rod`,`region_alias`) VALUES (23,9,'Вена','Вены','wien') ;
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (39,23,'Вена','wien') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (46,1,'Вена','wien') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (71,         4,              39,               46,                0,                     'Вена','Вены','wien','48.210254','16.372225','Столица Австрии, в прошлом столица великой Австро-Венгерской империи. Один из самых красивых городов мира');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,71,'','http://www.wien.gv.at/english/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,71,'','http://ru.wikipedia.org/wiki/%D0%92%D0%B5%D0%BD%D0%B0') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (71,0,3,'Вид на центр Вены','http://upload.wikimedia.org/wikipedia/commons/thumb/2/29/Panorama_vom_burgthdach.JPG/1024px-Panorama_vom_burgthdach.JPG') ;


-- дворец Шенбрунн
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (19,1,'Дворец','palace');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (72,         19,             39,               46,                0,                     'Дворец Шенбрунн','Дворца Шенбрунн','schonbrunn','48.185732','16.312723','Одна из доминирующих достопримечательностей Вены, резиденция австрийских императоров. Находится в центре большой территории с парком и разными интересными сооружениями',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (24,72,'','http://whc.unesco.org/en/list/786') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,72,'','http://ru.wikipedia.org/wiki/%D0%A8%D1%91%D0%BD%D0%B1%D1%80%D1%83%D0%BD%D0%BD') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (72,0,3,'Дворец Шенбрунн Вена Австрия','http://upload.wikimedia.org/wikipedia/commons/thumb/b/b9/Schloss_Schoenbrunn_August_2006_406.jpg/1024px-Schloss_Schoenbrunn_August_2006_406.jpg') ;


-- Собор Святого Штефана
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (10,1,'Религиозное сооружение', 'Религиозные сооружения','religion');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (20,10,'Церковь, Собор','church');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (73,         20,             39,               46,                0,                     'Собор Святого Стефана','Собора Святого Стефана','stephansdom','48.208459','16.373148','Stephansdom - символ Вены и один известнейших символов Австрии. В нынешнем виде находится с 1511 года',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,73,'','http://www.stephansdom.at/') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,73,'','http://ru.wikipedia.org/wiki/%D0%A1%D0%BE%D0%B1%D0%BE%D1%80_%D0%A1%D0%B2%D1%8F%D1%82%D0%BE%D0%B3%D0%BE_%D0%A1%D1%82%D0%B5%D1%84%D0%B0%D0%BD%D0%B0') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (73,0,3,'Собор Святого Стефана Вена Австрия','http://niistali.narod.ru/cities/Wien/Stephansdom_23.jpg') ;

-- дворец Хофбург
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (74,         19,             39,               46,                0,                     'Хофбург','Хофбурга','hofburg','48.205506','16.364769','Зимняя резиденция Габсбургов, место постоянного пребывания австрийского двора, в настоящее время - официальная резиденция президента Австрии',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,74,'','http://ru.wikipedia.org/wiki/%D0%A5%D0%BE%D1%84%D0%B1%D1%83%D1%80%D0%B3') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (74,0,3,'Дворец Хофбург Вена Австрия','http://upload.wikimedia.org/wikipedia/commons/0/01/Wien_Hofburg_Neue_Burg_Heldenplatz.jpg') ;


-- Венская опера
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (11,1,'Архитектурная достопримечательность', 'Архитектурные достопримечательности','architecture');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (21,11,'Здание театра','theatre');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (75,         21,             39,               46,                0,                     'Венская Опера','Венской Оперы','wieneroper','48.203197','16.36906','Крупнейшая опера в Австрии. Одно из самых красивых театральных сооружений в мире',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,75,'','http://www.wiener-staatsoper.at/Content.Node/home/Startseite-Content.en.php') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,75,'','http://ru.wikipedia.org/wiki/%D0%92%D0%B5%D0%BD%D1%81%D0%BA%D0%B0%D1%8F_%D0%B3%D0%BE%D1%81%D1%83%D0%B4%D0%B0%D1%80%D1%81%D1%82%D0%B2%D0%B5%D0%BD%D0%BD%D0%B0%D1%8F_%D0%BE%D0%BF%D0%B5%D1%80%D0%B0') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (75,0,3,'Опера Вена Австрия','http://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Vienna_Opera.jpg/1024px-Vienna_Opera.jpg') ;


-- Кафе Захер
INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_name_pl`,`point_type_alias`) VALUES (12,3,'Кафе', 'Кафе','cafe');
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (22,12,'Кофейня','coffe');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (76,         22,             39,               46,                0,                     'Кафе Захер','Кафе Захер','sachercafe','48.203933','16.369489','Знаменитое кафе "Захер" (Sacher). Одноименный торт, изобретенный здесь, известен в кафе и кондитерских всего мира. В здании расположен отель Захер, а также ресторан "Анна Захер"',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,76,'','http://www.sacher.com/en-cafe-vienna.htm') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (76,0,3,'Кафе Захер Вена Австрия','http://venagid.ru/wp-content/uploads/2010/05/Sacher4.jpg') ;

-- Кафе Моцарт
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (77,         22,             39,               46,                0,                     'Кафе Моцарт','Кафе Моцарт','mozartcafe','48.204298','16.369328','Кафе "Моцарт" (Mozart). Считатся, что здесь подают самый лучший яблочный штрудель в Вене',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,77,'','http://www.cafe-mozart.at/en/the-cafe/') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (39,1,'Пост ','ЖЖ "Фотовпечатления" andreykomov',' в ',0,'http://andreykomov.livejournal.com/','lj_andreykomov') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (39,77,'Впечатления из Вены. Часть первая: Моцарт, Кайзеры, Музеи','http://andreykomov.livejournal.com/5524.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (77,0,39,'Кафе Моцарт Вена Австрия','http://pics.livejournal.com/andreykomov/pic/0009g2q6') ;


-- Венская ратуша
INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES (23,11,'Здание Ратуши','rathaus');
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (78,         23,             39,               46,                0,                     'Новая Ратуша Вены','Новой Ратуши Вены','wienerrathaus','48.210883','16.35743','Так называемая, "новая" ратуша Вены построена в 1883 году на улице Рингштрассе в неоготическом (а местами эклектическом) стиле',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,78,'','http://ru.wikipedia.org/wiki/%D0%A0%D0%B0%D1%82%D1%83%D1%88%D0%B0_%28%D0%92%D0%B5%D0%BD%D0%B0%29') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (78,0,3,'Ратуша Вена Австрия','http://upload.wikimedia.org/wikipedia/commons/thumb/7/7e/Wienerrathaus.jpg/1024px-Wienerrathaus.jpg') ;


-- Кафе Эйнштейн
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (79,         22,             39,               46,                0,                     'Кафе Эйнштейн','Кафе Эйнштейн','einsteincafe','48.212356','16.358492','Кафе "Эйнштейн" (Einstein). Шницель и Штрудель присутствуют в обязательном порядке',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,79,'','http://einstein.at/cms/uk/') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (79,0,2,'Кафе Эйнштейн Вена Австрия','http://media-cdn.tripadvisor.com/media/photo-s/01/e9/07/5b/cafe-einstein.jpg') ;

-- Кафе Демель
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (80,         22,             39,               46,                0,                     'Кафе Демель','Кафе Демель','demelcafe','48.208616','16.367183','Кафе "Демель" (Demel). Один из лучшихъ штруделей в Вене, а также "Шоколадная бомба"(!)',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,80,'','http://www.demel.at/en/frames/index_wien.htm') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (80,0,2,'Кафе Демель Вена Австрия','http://venagid.ru/wp-content/uploads/2012/05/Demel3.jpg') ;
INSERT INTO `#__te_points_link_types` (`link_type_id`,`link_type_class`,`link_type_pre_label`,`link_type_link_label`,`link_type_post_label`,`link_type_incl_point`,`link_type_sitelink`,`link_type_alias`) VALUES (40,100,'','allfun allmoldova',' на сайте ',1,'http://www.allfun.md','allfunmd') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (40,80,'','http://www.allfun.md/index.php?page=projects&id=1297081443&sid=1297081443&pid=23840') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (80,1,40,'Кафе Демель Вена Австрия','http://www.allmoldova.com/uimg/blog/blogeda200711_8.jpg') ;

-- Кафе Империал
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (81,         22,             39,               46,                0,                     'Кафе Империал','Кафе Империал','imperialcafe','48.201259','16.373094','Кафе "Империал" (Imperial). Кафе в отеле Империал. Из обязательного: фирменный тортик "Империал"',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,81,'','http://www.imperialvienna.com/ru/cafe_ru') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (40,81,'','http://www.allfun.md/index.php?page=projects&id=1297081443&sid=1297081443&pid=23840') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (81,0,2,'Кафе Империал Вена Австрия','http://3cats.ru/wp-content/uploads/images/4613/681274125_w800.jpg') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (81,1,40,'Кафе Империал Вена Австрия','http://www.allmoldova.com/uimg/blog/blogeda200711_4.jpg') ;

-- Кафе Централь
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,                `point_alias`,    `point_lat`, `point_lon`,    `point_descr`,    `point_parent`) 
                    VALUES (82,         22,             39,               46,                0,                     'Кафе Централь','Кафе Централь','centralcafe','48.210361','16.365412','Кафе "Централь" (Central). Кафе "Централь". Культовое место. Здесь отметилось множество известных людей, например русские большевики. А Лев Троцкий был постоянным гостем несколько лет подряд, когда проживал в Вене в эмиграции',71);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,82,'','http://www.palaisevents.at/en/cafecentral.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (3,82,'','http://ru.wikipedia.org/wiki/%D0%A6%D0%B5%D0%BD%D1%82%D1%80%D0%B0%D0%BB%D1%8C') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (40,82,'','http://www.allfun.md/index.php?page=projects&id=1297081443&sid=1297081443&pid=23840') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (82,0,40,'Кафе Централь Вена Австрия','http://www.allmoldova.com/uimg/blog/blogeda200711_2.jpg') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (82,1,40,'Кафе Централь Вена Австрия','http://www.allmoldova.com/uimg/blog/blogeda200711_1.jpg') ;


-- Carlton Hotel Budapest 
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`,`point_parent`) 
                    VALUES (83,         9,              38,               45,                0,                     'Carlton Hotel Budapest','Carlton Hotel Budapest','carltonhotelbudapest','47.499409','19.039285','Четырехзвездочный отель в самом центре Будапешта возле цепного моста на стороне Буды',70);
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,83,'','http://www.carltonhotel.hu/index_ru.htm') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,83,'','http://www.booking.com/hotel/hu/carltonhotelbudapest.ru.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (83,0,2,'Вид на отель Carlton Hotel Budapest','http://www.carltonhotel.hu/galeria/ch_utca03.jpg') ;


-- Nyerges Hotel Termal es Etterem  
INSERT INTO `#__te_subregions`(`subregion_id`,`subregion_region`,`subregion_name`,`subregion_alias`) VALUES (40,22,'Пешт','pest') ;
INSERT INTO `#__te_settlements`(`settlement_id`,`settlement_type`,`settlement_name`,`settlement_alias`) VALUES (47,1,'Монор','monor') ;
INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_subregion`,`point_settlement`,`point_settlement_dist`,`point_name`,                    `point_name_rod`,`point_alias`,    `point_lat`, `point_lon`,    `point_descr`) 
                    VALUES (84,         6,              40,               47,                0,                     'Nyerges Hotel Termal es Etterem','Nyerges Hotel Termal es Etterem','nyergeshotelmonor','47.333562','19.439079','Термальный СПА-отель в г. Монор недалеко от Будапешта. 20 мин езды до аэропорта Будапешта');
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (2,84,'','http://monor.utisugo.hu/szallasok/nyerges-hotel-3070.html') ;
INSERT INTO `#__te_points_links` (`link_type`,`link_point`,`link_label`,`link_link`) VALUES (23,84,'','http://www.booking.com/hotel/hu/nyerges-terma-l-a-c-s-atterem.ru.html') ;
INSERT INTO `#__te_points_link_photos` (`point_id`,`link_photo_order`,`link_type`,`link_photo_name`,`link_photo_path`) VALUES (84,0,23,'Вид на отель Nyerges Hotel Termal es Etterem в Monor','http://q.bstatic.com/images/hotel/max600/119/11999449.jpg') ;

ALTER TABLE `#__te_points` CHANGE `point_id` `point_id` INT AUTO_INCREMENT ;

-- Описания сочетаний
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,0,'','Это стартовая страница для всей базы достопримечательностей. Достопримечательности сгруппированы по странам, а также по типам достопримечательностей. Выберите ниже, достопримечательности какой страны, или какого типа, вас интересуют в первую очередь');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,6,0,1,'Более трех десятков хорошо сохранившихся средневековых замков и крепостей делает Словакию очень даже привлекательной страной для любителей исторических достопримечательностей','Страница посвящена замкам Словакии. А также крепостям, укрепленным дворцам, усадьбам и монастырям. В приведенном списке замков и дворцов Словакии нет разрушенных до руин и не восстановленных замков. Таких в Словакии около двухсот. Однако и тех что сохранились или были восстановлены немало - более трех десятков, что делает Словакию очень даже привлекательной страной для любителей исторических достопримечательностей');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,1,'','Средневековые замки привлекают туристов и любителей достпримечательностей всего мира. Кроме замков, к этой же группе достопримечательностей относятся разнообразные крепости, дворцы и монастыри. Объединяет их всех то, что все эти сооружения в той или иной степени имели защитную функцию. Замок защищал жизнь и имущество феодала, крепость хранила сокровища государства и защищала свой гарнизон, монастырь защищал живущих в нем монахов. Дворцы попадают в этот же тип достопримечательностей, потому что зачастую также имеют защитные элементы в архитетуре, и очень часто построены на месте замков, или даже перестроены на основе замков. Красота и мощь архитектуры всех этих защитных сооружений, сохранившихся до наших дней, делает их такими желанными точками посещения');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,2,'','В этой группе собраны населенные пункты, которые сами по себе являются достопримечательностями. Очень часто путешественников привлекает не какое-то конкретное здание или место, а целый город, или центр города, как достопримечательность. Такой подход используется и в списке объектов мирового наследия ЮНЕСКО, куда внесены, например, набережные Будапешта (Венгрия), истоический центр Вены (Австрия), город Бардейов (Словакия) и т.д.. Кроме городов в качесве достопримечательности могу выступать и деревни, яркий пример тому - деревня Рокамадур во Франции');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,10,'','Сооружения религиозного характера - один из главных типов достопримечательностей во всем мире. Для совершения молитв и разных религиозных обрядов строились церкви, соборы, храмы, мечети. Для многих культур и цивилизаций религиозные сооружения - это единственное, что сохранилось до наши дней. Отметим, что монастыри, хоть и являются в какой-то степени религиозными сооружениями, относятся к замкам и крепостям');
INSERT INTO `#__te_class_type_country_region` (`class_id`,`country_id`,`region_id`,`type_id`,`short_descr`,`long_descr`) VALUES (1,0,0,11,'','К этому типу относятся архитектурные достопримечательности, не вошедшие в другие разделы, такие как "Замки, крепости, дворцы и монастыри" и "Религиозные достопримечательности". Сюда попадают отдельные красивые здания, городские Ратуши, здания театров и т.п.');



-- ------------------------
-- дальше заполняем поездки

-- стадии поездок
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (1,'Идея, список точек','Места, куда хотелось бы попасть') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (2,'План поездки - последовательность точек по дням','План поездки по дням') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (3,'План поездки - по местам ночевок и перемещениям','Расписание поездки по дням') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (4,'Начата','Расписание поездки') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (5,'Завершена','Расписание поездки') ;
INSERT INTO `#__te_trip_stages` (`trip_stage_id`,`trip_stage_name`,`trip_stage_points_label`) VALUES (6,'Готовы отчеты','Расписание поездки') ;

-- путешественники
INSERT INTO `#__te_travelers`(`traveler_id`,`traveler_name`) VALUES (1,'Павел') ;
INSERT INTO `#__te_travelers`(`traveler_id`,`traveler_name`) VALUES (2,'Ирина') ;
INSERT INTO `#__te_travelers`(`traveler_id`,`traveler_name`) VALUES (3,'Дарина') ;

-- поездка в Словакию октябрь 2012
INSERT INTO `#__te_trips`(`trip_id`,`trip_stage`,`trip_name`,`trip_alias`,`trip_descr`,`trip_start_date`) VALUES (1,2,'Словакия на 3 дня октябрь 2012','slovakia2012','','2012-10-18') ;

-- в поездку едут трое:)
INSERT INTO `#__te_travelers_trips`(`trip_id`,`traveler_id`) VALUES (1,1) ;
INSERT INTO `#__te_travelers_trips`(`trip_id`,`traveler_id`) VALUES (1,2) ;
INSERT INTO `#__te_travelers_trips`(`trip_id`,`traveler_id`) VALUES (1,3) ;

-- точки поездки по словакии - план направление
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

-- точки поездки по словакии - план утвержденный
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,26,1,1,'2012-10-18 22:00','2012-10-19 07:00','Из Киева выезжаем в 14:00, до отеля перед границей доедем в лучшем случае к 10 вечера') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,16,2,2,'2012-10-19 10:00','2012-10-19 11:30','Подъем в 7, за пару часов проходим границу, кофе пьем в Бардейове') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,27,3,2,'2012-10-19 12:30','2012-10-19 13:30','Замок по дороге, заезжаем если будет время') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,17,4,2,'2012-10-19 14:30','2012-10-19 16:00','аналогично') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,24,5,2,'2012-10-19 18:00','2012-10-20 10:00','Селимся на 2 ночи') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,18,6,3,'2012-10-20 11:00','2012-10-20 13:00','С утра завтрак и едем в замок') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,25,7,3,'2012-10-20 14:30','2012-10-20 16:00','Если успеваем') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,20,8,3,'2012-10-20 17:00','2012-10-20 18:00','Гуляем по самому городу') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,23,9,3,'2012-10-20 18:00','2012-10-20 18:00','Местная "Пизанская башня"') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,21,10,3,'2012-10-20 18:30','2012-10-20 18:30','Городская крепость') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,22,11,3,'2012-10-20 19:00','2012-10-20 20:00','там и ужинаем') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,24,12,3,'2012-10-20 21:00','2012-10-21 08:00','вторая ночь') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,19,13,4,'2012-10-21 10:00','2012-10-21 11:00','Рано выезжаем чтобы успеть сюда') ;
INSERT INTO `#__te_points_trips_plan`(`trip_id`,`point_id`,`point_order`,`day_number`,`arrival_date`,`depature_date`,`point_comment`) VALUES (1,28,14,4,'2012-10-21 12:00','2012-10-21 13:00','Встречаемся там с Николаем, а затем домой') ;


-- поездка в Венгрию январь 2013
INSERT INTO `#__te_trips`(`trip_id`,`trip_stage`,`trip_name`,`trip_alias`,`trip_descr`,`trip_start_date`) VALUES (2,3,'Венгрия - СПА + экскурсии - январь 2013','hungary2013','','2013-01-02') ;

-- места ночевок
INSERT INTO `#__te_trips_stay_points` (`trip_id`,`stay_point_order`,`stay_point_id`,`nights_to_stay`,`arrival_date`,    `depature_date`,`stay_point_comment`) 
                               VALUES ( 2       , 1                , 83            , 1              ,'2013-01-02 15:00','2013-01-03 10:00','Первую ночь ночуем в Будапеште') ;
INSERT INTO `#__te_trips_stay_points` (`trip_id`,`stay_point_order`,`stay_point_id`,`nights_to_stay`,`arrival_date`,    `depature_date`,`stay_point_comment`) 
                               VALUES ( 2       , 2                , 15            , 4              ,'2013-01-03 17:00','2013-01-07 10:00','Четыре ночи в "Данубиус Бюк". Отдыхаем, принимаем процедуры, ездим по окрестностям и в Вену') ;
INSERT INTO `#__te_trips_stay_points` (`trip_id`,`stay_point_order`,`stay_point_id`,`nights_to_stay`,`arrival_date`,    `depature_date`,`stay_point_comment`) 
                               VALUES ( 2       , 3                , 60            , 3              ,'2013-01-07 17:00','2013-01-10 10:00','Три ночи в "Салирисе" (Эгерсалок). Отдыхаем, принимаем процедуры, немного ездим по окрестностям') ;
INSERT INTO `#__te_trips_stay_points` (`trip_id`,`stay_point_order`,`stay_point_id`,`nights_to_stay`,`arrival_date`,    `depature_date`,`stay_point_comment`) 
                               VALUES ( 2       , 4                , 84            , 1              ,'2013-01-10 17:00','2013-01-11 07:30','Последняя ночь в Моноре, поближе к аэропорту. Отдыхаем, принимаем процедуры') ;


