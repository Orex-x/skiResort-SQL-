
/*-----------------------------------------------------------------outfit-------------------------------------------------*/
use test;
DELIMITER //
create  procedure outfit_insert(p_title varchar (50))

begin
	declare have_record int ; select count(*) into have_record from outfit
                              where title = p_title;

if have_record > 0 then
select 'наименование снаряжения уже существует в таблице';
else
			insert into outfit (title)
			values (p_title);
end if;
end;


use test;
DELIMITER //
create  procedure outfit_update(p_id_outfit int, p_title varchar (50))

begin
	declare have_record int ; select count(*) into have_record from outfit
                              where title = p_title;


if have_record > 0 then
select 'наименование снаряжения уже существует в таблице';
else
update outfit set
    title = p_title
where
        id_outfit = p_id_outfit;
end if;
end;


use test;
DELIMITER //
create  procedure outfit_delete(p_id_outfit int)

begin
	declare have_record int ; select count(*) into have_record from rental_outfit
                              where outfit_id = p_id_outfit;

if have_record > 0 then
select 'данное наименование снаряжения нельзя удалить, так как оно задействовано в справочнике "аренда снаряжения"!';
else
delete  from outfit
where
        id_outfit = p_id_outfit;
end if;
end;



/*-----------------------------------------------------------------rental_outfit------------------------------------------*/


use test;
DELIMITER //
create  procedure rental_outfit_insert ( p_price int, p_date_issue datetime, p_return_date datetime, p_outfit_id int )

begin

declare have_record int ; select count(*) into have_record from rental_outfit
                          where price = p_price and date_issue = p_date_issue and return_date = p_return_date and outfit_id = p_outfit_id;


if have_record>0 then
select 'указанная "аренда снаряжения" уже есть в таблице!';
else
insert into rental_outfit (price, date_issue, return_date, outfit_id)
	values ( p_price, p_date_issue, p_return_date, p_outfit_id);
end if;
end;



use test;
DELIMITER //
create  procedure rental_outfit_update(p_id_rental_outfit int, p_price int, p_date_issue datetime, p_return_date datetime, p_outfit_id int)

begin
	declare have_record int ; select count(*) into have_record from rental_outfit
                              where price = p_price and date_issue = p_date_issue and return_date = p_return_date and outfit_id = p_outfit_id;


if have_record > 0 then
select 'указанная запись "аренда снаряжения" уже есть в таблице';
else
update rental_outfit set
                         price = p_price,
                         date_issue = p_date_issue,
                         return_date = p_return_date,
                         outfit_id = p_outfit_id
where
        id_rental_outfit = p_id_rental_outfit;
end if;
end;



use test;
DELIMITER //
create  procedure rental_outfit_delete(p_id_rental_outfit int)

begin
	declare have_record int ; select count(*) into have_record from rental_outfit_client
                              where rental_outfit_id = p_id_rental_outfit;

if have_record > 0 then
select 'данную указанная запись "аренда снаряжения" нельзя удалить, так как оно задействовано в справочнике "аренда снаряжения клиент"!';
else
delete  from rental_outfit
where
        id_rental_outfit = p_id_rental_outfit;
end if;
end;


/*-----------------------------------------------------------------status_card--------------------------------------------*/


use test;
DELIMITER //
create  procedure status_card_insert(p_title varchar (50))

begin
	declare have_record int ; select count(*) into have_record from status_card
                              where title = p_title;

if have_record > 0 then
select 'наименование статуса уже существует в таблице';
else
			insert into status_card (title)
			values (p_title);
end if;
end;


use test;
DELIMITER //
create  procedure status_card_update(p_id_status_card int, p_title varchar (50))

begin
	declare have_record int ; select count(*) into have_record from status_card
                              where title = p_title;


if have_record > 0 then
select 'наименование статуса уже существует в таблице';
else
update status_card set
    title = p_title
where
        id_status_card = p_id_status_card;
end if;
end;


use test;
DELIMITER //
create  procedure status_card_delete(p_id_status_card int)

begin


    declare have_record_bonus_card int;
    declare have_record_status_card_track int;
select count(*) into have_record_bonus_card from bonus_card where status_card_id = p_id_status_card;
select count(*) into have_record_status_card_track from status_card_track where status_card_id = p_id_status_card;
if have_record_bonus_card > 0 or have_record_status_card_track > 0 then
select 'данное наименование статуса нельзя удалить, так как оно задействовано в справочнике "бонусная карта" или "статус карты склон"!';
else
delete  from status_card
where
        id_status_card = p_id_status_card;
end if;
end;

/*---------------------------------------------------------bonus_card-----------------------------------------------------*/


use test;
DELIMITER //
create  procedure bonus_card_insert ( p_balance int, p_tariff varchar(50), p_status_card_id int )

begin

declare have_record int ; select count(*) into have_record from bonus_card
                          where balance = p_balance and tariff = p_tariff and status_card_id = p_status_card_id;


if have_record>0 then
select 'указанная "бонусная карта" уже есть в таблице!';
else
insert into bonus_card (balance, tariff, status_card_id)
	values ( p_balance, p_tariff, p_status_card_id);
end if;
end;




use test;
DELIMITER //
create  procedure bonus_card_update(p_id_bonus_card int, p_balance int, p_tariff varchar(50), p_status_card_id int)

begin
	declare have_record int ; select count(*) into have_record from bonus_card
                              where balance = p_balance and tariff = p_tariff and status_card_id = p_status_card_id;


if have_record > 0 then
select 'указанная "бонусная карта" уже есть в таблице';
else
update bonus_card set
                      balance = p_balance,
                      tariff = p_tariff,
                      status_card_id = p_status_card_id
where
        id_bonus_card = p_id_bonus_card;
end if;
end;



use test;
DELIMITER //
create  procedure bonus_card_delete(p_id_bonus_card int)

begin
	declare have_record int ; select count(*) into have_record from client
                              where bonus_card_id = p_id_bonus_card;

if have_record > 0 then
select 'данную запись "вонусная карта" нельзя удалить, так как оно задействовано в справочнике "киент"!';
else
delete  from bonus_card
where
        id_bonus_card = p_id_bonus_card;
end if;
end;


/*---------------------------------------------------------position-----------------------------------------------------*/

use test;
DELIMITER //
create  procedure position_insert ( p_title varchar(50), p_post_price decimal (38,2),
                                    p_description varchar(300), p_responsibilities varchar(300))

begin

declare have_record int ; select count(*) into have_record from position
                          where title = p_title and post_price = p_post_price and description = p_description and responsibilities = p_responsibilities;


if have_record>0 then
select 'указанная "должность" уже есть в таблице!';
else
insert into position (title, post_price, description, responsibilities)
	values ( p_title, p_post_price, p_description, p_responsibilities);
end if;
end;




use test;
DELIMITER //
create  procedure position_update(p_id_position int, p_title varchar(50),
                                  p_post_price decimal (38,2), p_description varchar(300),
                                  p_responsibilities varchar(300))

begin
	declare have_record int ; select count(*) into have_record from position
                              where title = p_title and post_price = p_post_price and description = p_description and responsibilities = p_responsibilities;


if have_record > 0 then
select 'указанная "должность" уже есть в таблице';
else
update position set
                    title = p_title,
                    post_price = p_post_price,
                    description = p_description,
                    responsibilities = p_responsibilities
where
        id_position = p_id_position;
end if;
end;



use test;
DELIMITER //
create  procedure position_delete(p_id_position int)

begin
	declare have_record int ; select count(*) into have_record from employee
                              where position_id = p_id_position;

if have_record > 0 then
select 'данную запись "должность" нельзя удалить, так как оно задействовано в справочнике "сотрудник"!';
else
delete  from position
where
        id_position = p_id_position;
end if;
end;


/*---------------------------------------------------------employee-------------------------------------------------------*/


use test;
DELIMITER //
create  procedure employee_insert ( p_first_name varchar (30), p_second_name varchar (30), p_middle_name varchar (30), p_phone_number varchar(19),
                                    p_email varchar(300), p_age int, p_inn varchar(12), p_snils varchar(14)
    ,p_post_part decimal (38,1), p_position_id int)

begin

declare have_record int ; select count(*) into have_record from employee
                          where first_name = p_first_name and second_name = p_second_name and middle_name = p_middle_name
                            and phone_number = p_phone_number and email = p_email and age = p_age
                            and inn = p_inn and snils = p_snils and position_id = p_position_id and post_part = p_post_part;


if have_record>0 then
select 'указанный сотрудник уже есть в таблице!';
else
insert into employee (first_name, second_name, middle_name, phone_number, email, age, inn, snils, post_part, position_id)
	values (p_first_name , p_second_name , p_middle_name , p_phone_number , p_email, p_age, p_inn, p_snils , p_post_part, p_position_id);
end if;
end;




use test;
DELIMITER //
create  procedure employee_update(p_id_employee int, p_first_name varchar (30), p_second_name varchar (30), p_middle_name varchar (30), p_phone_number varchar(19),
                                  p_email varchar(300), p_age int, p_inn varchar(12), p_snils varchar(14)
    ,p_post_part decimal (38,1), p_position_id int)

begin
	declare have_record int ; select count(*) into have_record from employee
                              where first_name = p_first_name and second_name = p_second_name and middle_name = p_middle_name
                                and phone_number = p_phone_number and email = p_email and age = p_age
                                and inn = p_inn and snils = p_snils and position_id = p_position_id and post_part = p_post_part;


if have_record > 0 then
select 'указанный сотрудник уже есть в таблице';
else
update employee set
                    first_name = p_first_name,
                    second_name = p_second_name,
                    middle_name = p_middle_name,
                    phone_number = p_phone_number,
                    email = p_email,
                    age = p_age,
                    inn = p_inn,
                    snils = p_snils,
                    post_part = p_post_part,
                    position_id = p_position_id
where
        id_employee = p_id_employee;
end if;
end;



use test;
DELIMITER //
create  procedure employee_delete(p_id_employee int)

begin
    declare have_record_receipt int;
    declare have_record_track int;
    declare have_record_rental_outfit_client int;

select count(*) into have_record_receipt from receipt
where employee_id = p_id_employee;
select count(*) into have_record_track from track
where employee_id = p_id_employee;
select count(*) into have_record_rental_outfit_client from rental_outfit_client
where employee_id = p_id_employee;



if have_record_receipt > 0 or have_record_track > 0 or have_record_rental_outfit_client > 0 then
select 'данную запись "сотрудник" нельзя удалить, так как оно задействовано в других справочниках';
else
delete  from employee
where
        id_employee = p_id_employee;
end if;
end;



/*---------------------------------------------------------cableway-------------------------------------------------------*/


use test;
DELIMITER //
create  procedure cableway_insert ( p_roominess int, p_price int)

begin

declare have_record int ; select count(*) into have_record from cableway
                          where roominess = p_roominess and price = p_price;

if have_record>0 then
select 'указанная "канатная дорога" уже есть в таблице!';
else
insert into cableway (roominess, price)
	values ( p_roominess, p_price);
end if;
end;




use test;
DELIMITER //
create  procedure cableway_update(p_id_cableway int, p_roominess int, p_price int)

begin
	declare have_record int ; select count(*) into have_record from cableway
                              where roominess = p_roominess and price = p_price;


if have_record > 0 then
select 'указанная "канатная дорога" уже есть в таблице';
else
update cableway set
                    roominess = p_roominess,
                    price = p_price
where
        id_cableway = p_id_cableway;
end if;
end;



use test;
DELIMITER //
create  procedure cableway_delete(p_id_cableway int)

begin
	declare have_record int ; select count(*) into have_record from track
                              where cableway_id = p_id_cableway;

if have_record > 0 then
select 'данную запись "канатная дорога" нельзя удалить, так как оно задействовано в справочнике "склоны"!';
else
delete  from cableway
where
        id_cableway = p_id_cableway;
end if;
end;


/*---------------------------------------------------------track----------------------------------------------------------*/

use test;
DELIMITER //
create  procedure track_insert ( p_complexity int, p_title varchar(50), p_employee_id int, p_cableway_id int )

begin

declare have_record int ; select count(*) into have_record from track
                          where complexity = p_complexity and title = p_title and employee_id = p_employee_id and cableway_id = p_cableway_id;

if have_record>0 then
select 'указанный "склон" уже есть в таблице!';
else
insert into track (complexity, title, employee_id, cableway_id)
	values ( p_complexity, p_title, p_employee_id, p_cableway_id);
end if;
end;




use test;
DELIMITER //
create  procedure track_update(p_id_track int, p_complexity int, p_title varchar(50), p_employee_id int, p_cableway_id int )

begin
	declare have_record int ; select count(*) into have_record from track
                              where complexity = p_complexity and title = p_title and employee_id = p_employee_id and cableway_id = p_cableway_id;


if have_record > 0 then
select 'указанный "склон" уже есть в таблице';
else
update cableway set
                    complexity = p_complexity,
                    title = p_title,
                    employee_id = p_employee_id,
                    cableway_id = p_cableway_id
where
        id_track = p_id_track;
end if;
end;



use test;
DELIMITER //
create  procedure track_delete(p_id_track int)

begin
	declare have_record int ; select count(*) into have_record from status_card_track
                              where track_id = p_id_track;

if have_record > 0 then
select 'данную запись "слон" нельзя удалить, так как оно задействовано в справочнике "статус карты склон"!';
else
delete  from track
where
        id_track = p_id_track;
end if;
end;


/*---------------------------------------------------------status_card_track----------------------------------------------*/

use test;
DELIMITER //
create  procedure status_card_track_insert ( p_track_permission boolean, p_track_id int, p_status_card_id int )

begin

declare have_record int ; select count(*) into have_record from status_card_track
                          where track_permission = p_track_permission and track_id = p_track_id and status_card_id = p_status_card_id;

if have_record>0 then
select 'указанная запись уже есть в таблице!';
else
insert into status_card_track (track_permission, track_id, status_card_id)
	values ( p_track_permission, p_track_id, p_status_card_id);
end if;
end;




use test;
DELIMITER //
create  procedure status_card_track_update(p_id_status_card_track int,  p_track_permission boolean, p_track_id int, p_status_card_id int )

begin
	declare have_record int ; select count(*) into have_record from track
                              where track_permission = p_track_permission and track_id = p_track_id and status_card_id = p_status_card_id;


if have_record > 0 then
select 'указанная запись уже есть в таблице';
else
update status_card_track set
                             track_permission = p_track_permission,
                             track_id = p_track_id,
                             status_card_id = p_status_card_id
where
        id_status_card_track = p_id_status_card_track;
end if;
end;



use test;
DELIMITER //
create  procedure status_card_track_delete(p_id_status_card_track int)

begin

delete  from status_card_track
where
        id_status_card_track = p_id_status_card_track;
end;


/*---------------------------------------------------------client---------------------------------------------------------*/


use test;
DELIMITER //
create  procedure client_insert ( p_first_name varchar (30), p_second_name varchar (30), p_middle_name varchar (30), p_phone_number varchar(19),
                                  p_email varchar(300), p_age int, p_numberdl varchar(11), p_bonus_card_id int)

begin

declare have_record int ; select count(*) into have_record from client
                          where first_name = p_first_name and second_name = p_second_name and middle_name = p_middle_name
                            and phone_number = p_phone_number and email = p_email and age = p_age
                            and numberdl = p_numberdl and bonus_card_id = p_bonus_card_id;


if have_record>0 then
select 'указанный клиент уже есть в таблице!';
else
insert into client (first_name, second_name, middle_name, phone_number, email, age, numberdl, bonus_card_id)
	values (p_first_name , p_second_name , p_middle_name , p_phone_number , p_email, p_age, p_numberdl , p_bonus_card_id);
end if;
end;




use test;
DELIMITER //
create  procedure client_update(p_id_client int, p_first_name varchar (30), p_second_name varchar (30), p_middle_name varchar (30), p_phone_number varchar(19),
                                p_email varchar(300), p_age int, p_numberdl varchar(11), p_bonus_card_id int)

begin
	declare have_record int ; select count(*) into have_record from client
                              where first_name = p_first_name and second_name = p_second_name and middle_name = p_middle_name
                                and phone_number = p_phone_number and email = p_email and age = p_age
                                and numberdl = p_numberdl and bonus_card_id = p_bonus_card_id;


if have_record > 0 then
select 'указанный клиент уже есть в таблице';
else
update client set
                  first_name = p_first_name,
                  second_name = p_second_name,
                  middle_name = p_middle_name,
                  phone_number = p_phone_number,
                  email = p_email,
                  age = p_age,
                  numberdl = p_numberdl,
                  bonus_card_id = p_bonus_card_id
where
        id_client = p_id_client;
end if;
end;



use test;
DELIMITER //
create  procedure client_delete(p_id_client int)
begin
	declare have_record_receipt int;
	declare have_record_rental_outfit_client int;

select count(*) into have_record_receipt from receipt
where client_id = p_id_client;
select count(*) into have_record_rental_outfit_client from rental_outfit_client
where client_id = p_id_client;


if have_record_receipt > 0 or have_record_rental_outfit_client > 0 then
select 'данную запись "клиент" нельзя удалить, так как оно задействовано в других справочниках';
else
delete  from client
where
        id_client = p_id_client;
end if;
end;



/*---------------------------------------------------------receipt--------------------------------------------------------*/

use test;
DELIMITER //
create  procedure receipt_insert ( p_date_of_creation date, p_employee_id int, p_rental_outfit_client_id int )

begin

declare have_record int ; select count(*) into have_record from receipt
                          where date_of_creation = p_date_of_creation and employee_id = p_employee_id and rental_outfit_client_id = p_rental_outfit_client_id;

if have_record>0 then
select 'указанный чек уже есть в таблице!';
else
insert into receipt (date_of_creation, employee_id, rental_outfit_client_id)
	values ( p_date_of_creation, p_employee_id, p_rental_outfit_client_id);
end if;
end;



use test;
DELIMITER //
create  procedure receipt_update(p_id_receipt int, p_date_of_creation date, p_employee_id int, p_rental_outfit_client_id int )

begin
	declare have_record int ; select count(*) into have_record from receipt
                              where date_of_creation = p_date_of_creation and employee_id = p_employee_id and rental_outfit_client_id = p_rental_outfit_client_id;


if have_record > 0 then
select 'указанный чек уже есть в таблице';
else
update receipt set
                   date_of_creation = p_date_of_creation,
                   employee_id = p_employee_id,
                   rental_outfit_client_id = p_rental_outfit_client_id
where
        id_receipt = p_id_receipt;
end if;
end;



use test;
DELIMITER //
create  procedure receipt_delete(p_id_receipt int)

begin

delete  from receipt where id_receipt = p_id_receipt;
end;


/*---------------------------------------------------------rental_outfit_client-------------------------------------------*/



use test;
DELIMITER //
create  procedure rental_outfit_client_insert ( p_employee_id int, p_client_id int, p_rental_outfit_id int )

begin

declare have_record int ; select count(*) into have_record from rental_outfit_client
                          where employee_id = p_employee_id and client_id = p_client_id and rental_outfit_id = p_rental_outfit_id;

if have_record>0 then
select 'указанная запись уже есть в таблице!';
else
insert into rental_outfit_client (employee_id, client_id, rental_outfit_id)
	values ( p_employee_id, p_client_id, p_rental_outfit_id);
end if;
end;




use test;
DELIMITER //
create  procedure rental_outfit_client_update(p_id_rental_outfit_client int,  p_employee_id int, p_client_id int, p_rental_outfit_id int )

begin
	declare have_record int ; select count(*) into have_record from rental_outfit_client
                              where employee_id = p_employee_id and client_id = p_client_id and rental_outfit_id = p_rental_outfit_id;


if have_record > 0 then
select 'указанная запись уже есть в таблице';
else
update rental_outfit_client set
                                employee_id = p_employee_id,
                                client_id = p_client_id,
                                rental_outfit_id = p_rental_outfit_id
where
        id_rental_outfit_client = p_id_rental_outfit_client;
end if;
end;



use test;
DELIMITER //
create  procedure receipt_rental_outfit_client(p_id_rental_outfit_client int)

begin

delete  from rental_outfit_client where id_rental_outfit_client = p_id_rental_outfit_client;
end;

