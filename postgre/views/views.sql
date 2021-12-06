create or replace view View_Employee
as
select concat(Second_Name, ' ', substring(First_Name, 1, 1), '.', substring(Middle_Name, 1, 1), '.')
    as "Фамилия и инициалы сотрудника",
       concat('Мобильный телефон: ', Phone_Number, ', адрес электронной почты: ', Email)
    as "Контактная информация",
       concat(
               'Название должности - ', Title, 'с окладом в ', cast(Post_Price as varchar(100)), 'руб., по ставке - ',
               Post_Part,
               '. Доход состовляет: - Без НДФЛ- ', cast(round(Post_Price * Post_Part, 2) as varchar(100)),
               ' руб. - С НДФЛ - ', cast(round(Post_Price * Post_Part * 0.87, 2) as varchar(100)), ' руб.')
    as "Данные о занимаемых должностях"
from Employee
         inner join Position on Position_ID = ID_Position;



create or replace view View_Client
as
select concat(Second_Name, ' ', substring(First_Name, 1, 1), '.', substring(Middle_Name, 1, 1), '.')
    as "Фамилия и инициалы клиента",
       concat('Мобильный телефон: ', Phone_Number, ', адрес электронной почты: ',  Email)                                                                         as "Контактная информация",
       concat('Статус карты: ', Status_Card.Title, 'Количество баллов: ', Bonus_Card.Balance)
    as "Данные о карте клиента"
from Client
         inner join Bonus_Card on Bonus_Card_ID = ID_Bonus_Card
         inner join Status_Card on Status_Card_ID = ID_Status_Card;



create or replace view View_Rental_Outfit_Client
as
select concat(Employee.Second_Name, ' ', substring(Employee.First_Name, 1, 1), '.',
              substring(Employee.Middle_Name, 1, 1), '.')
    as "Фамилия и инициалы сотрудника",
       concat('Мобильный телефон: ', Employee.Phone_Number, ', адрес электронной почты: ',
              Employee.Email)
    as "Контактная информация сотрудника",
       concat(Client.Second_Name, ' ', substring(Client.First_Name, 1, 1), '.',
           substring(Client.Middle_Name, 1, 1), '.')
    as "Фамилия и инициалы клиента",
       concat('Мобильный телефон: ', Client.Phone_Number, ', адрес электронной почты: ', Client.Email)                                                                                as "Контактная информация клиента",
       concat('Цена за услугу аренды: ', Rental_Outfit.Price, 'Дата выдачи снаряжения: ',
              Rental_Outfit.Date_Issue, 'Дата возрата снаряжения', Rental_Outfit.Return_Date,
              'Наименование снаряжения: ', Outfit.Title)
    as "Данные об арденде"

from Rental_Outfit_Client
         inner join Employee on Employee_ID = ID_Employee
         inner join Client on Client_ID = ID_Client
         inner join Rental_Outfit on Rental_Outfit_ID = ID_Rental_Outfit
         inner join Outfit on Outfit_ID = ID_Outfit;
