create or replace view view_employee
as
select concat(second_name, ' ', substring(first_name, 1, 1), '.', substring(middle_name, 1, 1), '.')
    as "фамилия и инициалы сотрудника",
       concat('мобильный телефон: ', phone_number, ', адрес электронной почты: ', email)
    as "контактная информация",
       concat(
               'название должности - ', title, 'с окладом в ', cast(post_price as varchar(100)), 'руб., по ставке - ',
               post_part,
               '. доход состовляет: - без ндфл- ', cast(round(post_price * post_part, 2) as varchar(100)),
               ' руб. - с ндфл - ', cast(round(post_price * post_part * 0.87, 2) as varchar(100)), ' руб.'
           ) as "данные о занимаемых должностях"
from employee
         inner join position on position_id = id_position;



create or replace view view_client
as
select concat(second_name, ' ', substring(first_name, 1, 1), '.', substring(middle_name, 1, 1), '.')
    as "фамилия и инициалы клиента",
       concat('мобильный телефон: ', phone_number, ', адрес электронной почты: ', email)
    as "контактная информация",
       concat('статус карты: ', status_card.title, 'количество баллов: ', bonus_card.balance)
    as "данные о карте клиента"
from client
         inner join bonus_card on bonus_card_id = id_bonus_card
         inner join status_card on status_card_id = id_status_card;



create or replace view view_rental_outfit_client
as
select concat(employee.second_name, ' ', substring(employee.first_name, 1, 1), '.',
              substring(employee.middle_name, 1, 1), '.') as "фамилия и инициалы сотрудника",
       concat('мобильный телефон: ', employee.phone_number, ', адрес электронной почты: ',
              employee.email) as "контактная информация сотрудника",
       concat(client.second_name, ' ', substring(client.first_name, 1, 1), '.', substring(client.middle_name, 1, 1),
              '.')  as "фамилия и инициалы клиента",
       concat('мобильный телефон: ', client.phone_number, ', адрес электронной почты: ',
              client.email) as "контактная информация клиента",
       concat('цена за услугу аренды: ', rental_outfit.price, 'дата выдачи снаряжения: ',
              rental_outfit.date_issue, 'дата возрата снаряжения', rental_outfit.return_date,
              'наименование снаряжения: ',
              outfit.title) as "данные об арденде"
from rental_outfit_client
         inner join employee on employee_id = id_employee
         inner join client on client_id = id_client
         inner join rental_outfit on rental_outfit_id = id_rental_outfit
         inner join outfit on outfit_id = id_outfit;



