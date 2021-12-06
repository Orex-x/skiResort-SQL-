use test;
create table outfit
(
    id_outfit int         not null auto_increment primary key,
    title     varchar(50) not null unique
);

use test;
create table rental_outfit
(
    id_rental_outfit int      not null auto_increment primary key,
    price            int      not null default '0' check (price >= 0),
    date_issue       datetime not null,
    return_date      datetime not null,
    outfit_id        int      not null references outfit (id_outfit)
);


use test;
create table status_card
(
    id_status_card int         not null auto_increment primary key,
    title          varchar(50) not null unique
);

use test;
create table bonus_card
(
    id_bonus_card  int         not null auto_increment primary key,
    balance        int         not null default '0' check (balance >= 0),
    tariff         varchar(50) not null,
    status_card_id int         not null references status_card (id_status_card)
);

use test;
create table position
(
    id_position      int            not null auto_increment primary key,
    title            varchar(50)    not null unique,
    post_price       decimal(38, 2) null     default 0.0 check (post_price >= 0.0),
    description      varchar(300)   not null default '-',
    responsibilities varchar(300)   not null default '-'
);


use test;
create table employee
(
    id_employee  int            not null auto_increment primary key,
    first_name   varchar(30)    not null,
    second_name  varchar(30)    not null,
    middle_name  varchar(30)    null     default ('-'),
    phone_number varchar(19)    not null check (phone_number like
                                                '\+7\([0-9][0-9][0-9]\)[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    email        varchar(300)   null     default '@.' check (email like '%@%.%'),
    age          int            not null default '0' check (age >= 0),
    inn          varchar(12)    not null check (inn like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
    snils        varchar(14)    not null check (snils like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9]'),
    post_part    decimal(38, 1) null     default 0.1 check (post_part > 0.0),
    position_id  int            not null references position (id_position)
);

use test;
create table cableway
(
    id_cableway int not null auto_increment primary key,
    roominess   int not null check (roominess > 0),
    price       int not null default '0' check (price >= 0)
);

use test;
create table track
(
    id_track    int         not null auto_increment primary key,
    complexity  int         not null default '0' check (complexity >= 0),
    title       varchar(50) not null default ('-'),
    employee_id int         not null references employee (id_employee),
    cableway_id int         not null references cableway (id_cableway)
);


use test;
create table status_card_track
(
    id_status_card_track int     not null auto_increment primary key,
    track_permission     boolean not null default (false),
    track_id             int     not null references track (id_track),
    status_card_id       int     not null references status_card (id_status_card)
);


use test;
create table client
(
    id_client     int          not null auto_increment primary key,
    first_name    varchar(30)  not null,
    second_name   varchar(30)  not null,
    middle_name   varchar(30)  null     default ('-'),
    phone_number  varchar(19)  not null check (phone_number like
                                               '\+7\([0-9][0-9][0-9]\)[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
    email         varchar(300) null     default '@.' check (email like '%@%.%'),
    age           int          not null default (0) check (age >= 0),
    numberdl      varchar(11)  null     default '-' check (phone_number like
                                                           '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]'),
    bonus_card_id int          not null references bonus_card (id_bonus_card)
);

use test;
create table receipt
(
    id_receipt              int  not null auto_increment primary key,
    date_of_creation        date not null,
    employee_id             int  not null references employee (id_employee),
    rental_outfit_client_id int  not null references rental_outfit_client (id_rental_outfit_client)
);

use test;
create table rental_outfit_client
(
    id_rental_outfit_client int not null auto_increment primary key,
    employee_id             int not null references employee (id_employee),
    client_id               int not null references client (id_client),
    rental_outfit_id        int not null references rental_outfit (id_rental_outfit)
);

