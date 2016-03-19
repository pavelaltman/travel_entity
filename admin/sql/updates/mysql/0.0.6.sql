drop table if exists `#__te_points`;
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

---------------------------------------------
-- Блок таблиц классов типов и подтипов точек

create table `#__te_point_classes`
(
   `point_class_id`       int(11) not null,
   `point_class_name`     varchar(255) not null,
   `point_class_alias`    varchar(255) not null unique,
   `point_class_descr`    varchar(255),
   primary key (`point_class_id`)
) ENGINE=MyISAM AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

create table `#__te_point_types`
(
   `point_type_id`        int not null,
   `point_class`          int not null,
   `point_type_name`      varchar(255) not null,
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



------------------------------------------------------
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
   `country_id`        int not null,
   `country_continent` int not null,
   `country_name`      varchar(255) not null,
   `country_alias`     varchar(255) not null unique,
   `country_descr`     varchar(255),
   primary key (`country_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

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
   `area_id`         int not null,
   `country_id`      int not null,
   primary key (`area_id`,`country_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

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
   primary key (`region_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_subregions` add constraint `#__te_FK_subregion_region` foreign key (`subregion_region`)
      references `#__te_regions` (`region_id`) on delete restrict on update restrict;


-- Названия единиц административного деления для разных стран
create table `#__te_region_names`
(
   `country_id`          int not null,
   `region_name`         varchar(255) not null,
   `subregion_name`      varchar(255) not null
   `regiongroup_name`    varchar(255) not null,
   `subregiongroup_name` varchar(255) not null
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
   `regiongroup_id`         int not null,
   `region_id`              int not null,
    primary key (`regiongroup_id`,`region_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

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
   `subregiongroup_id`         int not null,
   `subregion_id`              int not null,
    primary key (`subregiongroup_id`,`subregion_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_regiongroups_subregions` add constraint `#__te_FK_subregiongroups_subregions_subregiongroup` foreign key (`subregiongroup_id`)
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
   `settlement_id`         int not null,
   `subregion_id`          int not null,
   `subregion_is_capital`  int not null, -- 1- если город - столица субрегиона, 0 - иначе.
   primary key (`settlement_id`,`subregion_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_settlements_subregions` add constraint `#__te_FK_settlements_subregion_settlement` foreign key (`settlement_id`)
      references `#__te_settlements` (`settlement_id`) on delete restrict on update restrict;

alter table `#__te_settlements_subregions` add constraint `#__te_FK_settlements_subregion_subregions` foreign key (`subregion_id`)
      references `#__te_subregions` (`subregion_id`) on delete restrict on update restrict;



------------------------------------------------------
-- таблица точек (мест)

create table `#__te_points`
(
   `point_id`              int not null,
   `point_subtype`         int not null,
   `point_subregion`       int not null,
   `point_settlement`      int,
   `point_settlement_dist` int,  -- расстояние до населенного пункта, 0 если на его территории 
   `point_name`            varchar(255) not null,
   `point_alias`           varchar(255) not null unique,
   `point_descr`           varchar(511) not null,
   primary key (`point_id`)
) AUTO_INCREMENT=0 DEFAULT CHARSET=utf8;

alter table `#__te_points` add constraint `#__te_FK_Reference_3` foreign key (`point_subtype`)
      references `#__te_point_subtypes` (`point_subtype_id`) on delete restrict on update restrict;

alter table `#__te_points` add constraint `#__te_FK_points_subregions` foreign key (`point_subregion`)
      references `#__te_subregions` (`subregion_id`) on delete restrict on update restrict;

alter table `#__te_points` add constraint `#__te_FK_points_settlements` foreign key (`point_settlements`)
      references `#__te_settlements` (`settlement_id`) on delete restrict on update restrict;


SET NAMES cp1251 ;

INSERT INTO `#__te_point_classes` (`point_class_id`,`point_class_name`,`point_class_alias`) VALUES
	(1,'Достопримечательность','attraction'),
	(2,'Ресторан, кафе','restaurant'),
	(3,'Отель, аппартаменты, квартира','hotel');

INSERT INTO `#__te_point_types` (`point_type_id`,`point_class`,`point_type_name`,`point_type_alias`) VALUES
	(1,1,'Замок, дворец, крепость','castle'),
	(2,1,'Церковь, собор, костел','church'),
	(3,2,'Кофейня, кафе','cafe'),
	(4,2,'Булочная','bakery'),
	(5,2,'Ресторан национальной кухни','cuisine'),
	(6,3,'Отель','hotel');

INSERT INTO `#__te_point_subtypes` (`point_subtype_id`,`point_type`,`point_subtype_name`,`point_subtype_alias`) VALUES
	(1,1,'Замок','castle'),
	(2,1,'Крепость','fortress'),
	(3,1,'Монастырь','monastery'),
	(4,1,'Дворец','palace'),
	(5,2,'Церковь','church'),
	(6,2,'Собор','cathedral'),
	(7,3,'Кофейня','cafe'),
	(8,4,'Булочная','bakery'),
	(9,5,'Ресторан немецкой кухни','germancuisine'),
	(10,6,'Отель','hotel');

INSERT INTO `#__te_points` (`point_id`,`point_subtype`,`point_name`,`point_alias`) VALUES
	(1,4,'Дворец Сан-Суси','sansusi'),
	(2,4,'Новый Дворец','sansusinewpalace'),
	(3,2,'Крепость Шпандау','spandaufortress'),
	(4,6,'Берлинер Дом','berlinerdome'),
	(5,10,'Отель Элегия','elegiahonel');


