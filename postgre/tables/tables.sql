
create table Outfit
(
    ID_Outfit SERIAL not null constraint PK_Outfit primary key,
    Title varchar(50) not null unique
);
comment on table Outfit is 'Таблица хранит в себе наименование снаряжения';
comment on column Outfit.Title is 'Название снаряжения';


create table Rental_Outfit
(
    ID_Rental_Outfit SERIAL not null constraint PK_Rental_Outfit primary key,
    Price int not null default (0) check (Price >= 0),
    Date_Issue timestamp not null,
    Return_Date timestamp not null,
    Outfit_ID int not null references Outfit (ID_Outfit)
);
comment on table Rental_Outfit is 'Таблица хранит в себе информацию об аренде снаряжения';
comment on column Rental_Outfit.Price is 'Цена за услугу аренды';
comment on column Rental_Outfit.Date_Issue is 'Дата выдачи снаряжения';
comment on column Rental_Outfit.Return_Date is 'Дата возрата снаряжения';
comment on column Rental_Outfit.Outfit_ID is 'Внешний ключ ссылающийся на наименование снаряжения';


create table Status_Card
(
    ID_Status_Card SERIAL not null constraint PK_Status_Card primary key,
    Title varchar(50) not null unique
);
comment on table Status_Card is 'Таблица хранит в себе наименование статуса';
comment on column Status_Card.Title is 'Наименование статуса';


create table Bonus_Card
(
    ID_Bonus_Card SERIAL not null constraint PK_Bonus_Card primary key,
    Balance int not null default (0) check (Balance >= 0),
    Tariff varchar(50) not null,
    Status_Card_ID int not null references Status_Card (ID_Status_Card)
);
comment on table Bonus_Card is 'Таблица хранит в себе информацию бонусной карте';
comment on column Bonus_Card.Balance is 'Баланс на бонусной карте';
comment on column Bonus_Card.Tariff is 'Тариф на бонусной карте';
comment on column Bonus_Card.Status_Card_ID is 'Внешний ключ ссылающийся на наименование статуса';



create table Position
(
    ID_Position SERIAL not null constraint PK_Position primary key,
    Title varchar(50) not null unique,
    Post_Price decimal (38,2) null default 0.0 check (Post_Price>=0),
    Description varchar not null default ('-'),
    Responsibilities varchar not null default ('-')
);
comment on table Position is 'Таблица хранит в себе информацию о должности';
comment on column Position.Title is 'Наименование должности';
comment on column Position.Post_Price is 'Оклад должности';
comment on column Position.Description is 'Описание должности';
comment on column Position.Responsibilities is 'Обязанности должности';


create table Employee
(
    ID_Employee SERIAL not null constraint PK_Employee primary key,
    First_Name varchar (30) not null,
    Second_Name varchar (30) not null,
    Middle_Name varchar (30) null default('-'),
    Phone_Number varchar(19) not null constraint CH_Phone_Number check
        (Phone_Number similar to '\+7\([0-9][0-9][0-9]\)[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
  	Email varchar null constraint CH_Email check
  	(Email similar to '%@%.%') default ('@.'),
  	Age int not null default (0) check (Age >= 0),
 	INN varchar(12) not null check
 	(INN similar to '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
 	SNILS varchar(14) not null check
 	(SNILS similar to '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9]'),
	Post_Part decimal (38,1) null default 0.1 check (Post_Part>0.0),
 	Position_ID int not null references Position (ID_Position)
);
comment on table Employee is 'Таблица хранит в себе информацию о сотрудниках';
comment on column Employee.First_Name is 'Имя сотрудника';
comment on column Employee.Second_Name is 'Фамилия сотрудника';
comment on column Employee.Middle_Name is 'Отчество сотрудника';
comment on column Employee.Phone_Number is 'Мобильный номер телефона сотрудника';
comment on column Employee.Email is 'Почта сотрудника';
comment on column Employee.Age is 'Возраст сотрудника';
comment on column Employee.INN is 'ИНН сотрудника';
comment on column Employee.SNILS is 'СНИЛС сотрудника';
comment on column Employee.Post_Part is 'Ставка сотрудника';
comment on column Employee.Position_ID is 'Внешний ключ ссылающийся на должность сотрудника';


create table Cableway
(
    ID_Cableway SERIAL not null constraint PK_Cableway primary key,
    Roominess int not null check (Roominess > 0),
    Price int not null check (Price >= 0) default (0)
);
comment on table Cableway is 'Таблица хранит в себе информацию о канатной дороге';
comment on column Cableway.Roominess is 'Вместительность кабинки';
comment on column Cableway.Price is 'Цена за одно катание';


create table Track
(
    ID_Track SERIAL not null constraint PK_Track primary key,
    Complexity int not null check (Complexity >= 0) default (0),
    Title varchar(50) not null default ('-'),
    Employee_ID int not null references Employee (ID_Employee),
    Cableway_ID int not null references Cableway (ID_Cableway)
);
comment on table Track is 'Таблица хранит в себе информацию о склоне';
comment on column Track.Complexity is 'Сложность склона';
comment on column Track.Title is 'Наименование склона';
comment on column Track.Employee_ID is 'Внешний ключ ссылающийся на дежурного по склону';
comment on column Track.Cableway_ID is 'Внешний ключ ссылающийся на канатную дорогу склона';


create table Status_Card_Track
(
    ID_Status_Card_Track SERIAL not null constraint PK_Status_Card_Track primary key,
    Track_Permission boolean not null default (false),
    Track_ID int not null references Track (ID_Track),
    Status_Card_ID int not null references Status_Card (ID_Status_Card)
);
comment on table Status_Card_Track is 'Таблица о разрещении кататься на склоне в зависимости от стутуса карты';
comment on column Status_Card_Track.Track_Permission is 'Разрещение';
comment on column Status_Card_Track.Track_ID is 'Внешний ключ ссылающийся на склон';
comment on column Status_Card_Track.Status_Card_ID is 'Внешний ключ ссылающийся на статус карты';


create table Client
(
    ID_Client SERIAL not null constraint PK_Client primary key,
    First_Name varchar (30) not null,
    Second_Name varchar (30) not null,
    Middle_Name varchar (30) null default('-'),
    Phone_Number varchar(19) not null constraint CH_Phone_Number check
        (Phone_Number similar to '\+7\([0-9][0-9][0-9]\)[0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]'),
  	Email varchar null constraint CH_Email check
  	(Email similar to '%@%.%') default ('@.'),
  	Age int not null default (0) check (Age >= 0),
 	NumberDL varchar(11) null default ('-') check
	(NumberDL similar to '[0-9][0-9][0-9][0-9]-[0-9][0-9][0-9][0-9][0-9][0-9]'),
 	Bonus_Card_ID int not null references Bonus_Card (ID_Bonus_Card)
);
comment on table Client is 'Таблица хранит в себе информацию о клиентах';
comment on column Client.First_Name is 'Имя клиента';
comment on column Client.Second_Name is 'Фамилия клиента';
comment on column Client.Middle_Name is 'Отчество клиента';
comment on column Client.Phone_Number is 'Мобильный номер телефона клиента';
comment on column Client.Email is 'Почта клиента';
comment on column Client.Age is 'Возраст клиента';
comment on column Client.NumberDL is 'Номер водительского удостоверения клиента';
comment on column Client.Bonus_Card_ID is 'Внешний ключ ссылающийся на карту клиента';


create table Rental_Outfit_Client
(
    ID_Rental_Outfit_Client SERIAL not null constraint PK_Rental_Outfiet_Client primary key,
    Employee_ID int not null references Employee (ID_Employee),
    Client_ID int not null references Client (ID_Client),
    Rental_Outfit_ID int not null references Rental_Outfit (ID_Rental_Outfit)
);

comment on table Rental_Outfit_Client is
    'Таблица хранит в себе информацию о том, какой клиент взял какое снаряжение и какой сотрудник это оформил';
comment on column Rental_Outfit_Client.Employee_ID is 'Внешний ключ ссылающийся на сотрудника выдавшего снаряжение';
comment on column Rental_Outfit_Client.Client_ID is 'Внешний ключ ссылающийся на клиента';
comment on column Rental_Outfit_Client.Rental_Outfit_ID is 'Внешний ключ ссылающийся на аренду сняряжения';


create table Receipt
(
    ID_Receipt SERIAL not null constraint PK_Receipt primary key,
    Date_Of_Creation date not null,
    Employee_ID int not null references Employee (ID_Employee),
    Rental_Outfit_Client_ID int not null references Rental_Outfit_Client (ID_Rental_Outfit_Client)
);
comment on table Receipt is 'Таблица хранит в себе информацию о клиентах';
comment on column Receipt.Date_Of_Creation is 'Дата создания чека';
comment on column Receipt.Employee_ID is 'Внешний ключ ссылающийся на сотрудника выписывшего чек';
comment on column Receipt.Rental_Outfit_Client_ID is 'Внешний ключ ссылающийся на услугу аренды';


