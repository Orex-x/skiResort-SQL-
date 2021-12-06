-----------------------------------------------------------------Outfit-------------------------------------------------
create or replace procedure Outfit_Insert(p_Title varchar(50))
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Outfit
	where Title = p_Title;
begin
    if have_record > 0 then
        raise exception 'Наименование снаряжения уже существует в таблице';
    else
        insert into Outfit (Title)
        values (p_Title);
    end if;
end;
$$;

create or replace procedure Outfit_Update(p_ID_Outfit int, p_Title varchar(50))
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Outfit
	where Title = p_Title;

begin
    if have_record > 0 then
        raise exception 'Наименование снаряжения уже существует в таблице';
    else
        update Outfit
        set Title = p_Title
        where ID_Outfit = p_ID_Outfit;
    end if;
end;
$$;

create or replace procedure Outfit_Delete(p_ID_Outfit int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Rental_Outfit
	where Outfit_ID = p_ID_Outfit;
begin
    if have_record > 0 then
        raise exception 'Данное наименование снаряжения нельзя удалить, так как оно задействовано в справочнике "Аренда снаряжения"!';
    else
        delete
        from Outfit
        where ID_Outfit = p_ID_Outfit;
    end if;
end;
$$;


-----------------------------------------------------------------Rental_Outfit------------------------------------------


create or replace procedure Rental_Outfit_Insert(p_Price int, p_Date_Issue timestamp, p_Return_Date timestamp,
                                                 p_Outfit_ID int)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Rental_Outfit
where Price = p_Price and Date_Issue = p_Date_Issue and Return_Date = p_Return_Date and Outfit_ID = p_Outfit_ID;

begin
    if have_record > 0 then
        raise exception 'Указанная "аренда снаряжения" уже есть в таблице!';
    else
        insert into Rental_Outfit (Price, Date_Issue, Return_Date, Outfit_ID)
        values (p_Price, p_Date_Issue, p_Return_Date, p_Outfit_ID);
    end if;
end;
$$;


create or replace procedure Rental_Outfit_Update(p_ID_Rental_Outfit int, p_Price int, p_Date_Issue timestamp,
                                                 p_Return_Date timestamp, p_Outfit_ID int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Rental_Outfit
	where Price = p_Price and Date_Issue = p_Date_Issue and Return_Date = p_Return_Date and Outfit_ID = p_Outfit_ID;

begin
    if have_record > 0 then
        raise exception 'Указанная запись "аренда снаряжения" уже есть в таблице';
    else
        update Rental_Outfit
        set Price       = p_Price,
            Date_Issue  = p_Date_Issue,
            Return_Date = p_Return_Date,
            Outfit_ID   = p_Outfit_ID
        where ID_Rental_Outfit = p_ID_Rental_Outfit;
    end if;
end;
$$;


create or replace procedure Rental_Outfit_Delete(p_ID_Rental_Outfit int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Rental_Outfit_Client
	where Rental_Outfit_ID = p_ID_Rental_Outfit;
begin
    if have_record > 0 then
        raise exception 'Данную Указанная запись "аренда снаряжения" нельзя удалить, так как оно задействовано в справочнике "Аренда снаряжения клиент"!';
    else
        delete
        from Rental_Outfit
        where ID_Rental_Outfit = p_ID_Rental_Outfit;
    end if;
end;
$$;

-----------------------------------------------------------------Status_Card--------------------------------------------


create or replace procedure Status_Card_Insert(p_Title varchar(50))
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Status_Card
	where Title = p_Title;
begin
    if have_record > 0 then
        raise exception 'Наименование статуса уже существует в таблице';
    else
        insert into Status_Card (Title)
        values (p_Title);
    end if;
end;
$$;

create or replace procedure Status_Card_Update(p_ID_Status_Card int, p_Title varchar(50))
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Status_Card
	where Title = p_Title;

begin
    if have_record > 0 then
        raise exception 'Наименование статуса уже существует в таблице';
    else
        update Status_Card
        set Title = p_Title
        where ID_Status_Card = p_ID_Status_Card;
    end if;
end;
$$;

create or replace procedure Status_Card_Delete(p_ID_Status_Card int)
    language plpgsql
as
$$
DECLARE
    have_record_Bonus_Card        int := count(*) from Bonus_Card
	where Status_Card_ID = p_ID_Status_Card;
    have_record_Status_Card_Track int := count(*) from Status_Card_Track
	where Status_Card_ID = p_ID_Status_Card;
begin
    if have_record_Bonus_Card > 0 OR have_record_Status_Card_Track > 0 then
        raise exception 'Данное наименование статуса нельзя удалить, так как оно задействовано в справочнике "Бонусная карта" или "статус карты склон"!';
    else
        delete
        from Status_Card
        where ID_Status_Card = p_ID_Status_Card;
    end if;
end;
$$;


---------------------------------------------------------Bonus_Card-----------------------------------------------------


create or replace procedure Bonus_Card_Insert(p_Balance int, p_Bonus_Balance int, p_Status_Card_ID int)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Bonus_Card
where Balance = p_Balance and Bonus_Balance = p_Bonus_Balance and Status_Card_ID = p_Status_Card_ID;

begin
    if have_record > 0 then
        raise exception 'Указанная "бонусная карта" уже есть в таблице!';
    else
        insert into Bonus_Card (Balance, Bonus_Balance, Status_Card_ID)
        values (p_Balance, p_Bonus_Balance, p_Status_Card_ID);
    end if;
end;
$$;



create or replace procedure Bonus_Card_Update(p_ID_Bonus_Card int, p_Balance int, p_Bonus_Balance int,
                                              p_Status_Card_ID int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Bonus_Card
	where Balance = p_Balance and Bonus_Balance = p_Bonus_Balance and Status_Card_ID = p_Status_Card_ID;

begin
    if have_record > 0 then
        raise exception 'Указанная "бонусная карта" уже есть в таблице';
    else
        update Bonus_Card
        set Balance        = p_Balance,
            Bonus_Balance         = p_Bonus_Balance,
            Status_Card_ID = p_Status_Card_ID
        where ID_Bonus_Card = p_ID_Bonus_Card;
    end if;
end;
$$;


create or replace procedure Bonus_Card_Delete(p_ID_Bonus_Card int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Client
	where Bonus_Card_ID = p_ID_Bonus_Card;
begin
    if have_record > 0 then
        raise exception 'Данную запись "вонусная карта" нельзя удалить, так как оно задействовано в справочнике "Киент"!';
    else
        delete
        from Bonus_Card
        where ID_Bonus_Card = p_ID_Bonus_Card;
    end if;
end;
$$;

---------------------------------------------------------Position-----------------------------------------------------

create or replace procedure Position_Insert(p_Title varchar(50), p_Post_Price decimal(38, 2),
                                            p_Description varchar, p_Responsibilities varchar)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Position
where Title = p_Title and Post_Price = p_Post_Price and Description = p_Description and Responsibilities = p_Responsibilities;

begin
    if have_record > 0 then
        raise exception 'Указанная "Должность" уже есть в таблице!';
    else
        insert into Position (Title, Post_Price, Description, Responsibilities)
        values (p_Title, p_Post_Price, p_Description, p_Responsibilities);
    end if;
end;
$$;



create or replace procedure Position_Update(p_ID_Position int, p_Title varchar(50),
                                            p_Post_Price decimal(38, 2), p_Description varchar,
                                            p_Responsibilities varchar)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Position
	where Title = p_Title and Post_Price = p_Post_Price and Description = p_Description and Responsibilities = p_Responsibilities;

begin
    if have_record > 0 then
        raise exception 'Указанная "Должность" уже есть в таблице';
    else
        update Position
        set Title            = p_Title,
            Post_Price       = p_Post_Price,
            Description      = p_Description,
            Responsibilities = p_Responsibilities
        where ID_Position = p_ID_Position;
    end if;
end;
$$;


create or replace procedure Position_Delete(p_ID_Position int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Employee
	where Position_ID = p_ID_Position;
begin
    if have_record > 0 then
        raise exception 'Данную запись "должность" нельзя удалить, так как оно задействовано в справочнике "Сотрудник"!';
    else
        delete
        from Position
        where ID_Position = p_ID_Position;
    end if;
end;
$$;

---------------------------------------------------------Employee-------------------------------------------------------


create or replace procedure Employee_Insert(p_First_Name varchar(30), p_Second_Name varchar(30),
                                            p_Middle_Name varchar(30), p_Phone_Number varchar(19),
                                            p_Email varchar, p_Age int, p_INN varchar(12), p_SNILS varchar(14)
    , p_Post_Part decimal(38, 1), p_Position_ID int)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Employee
where First_Name = p_First_Name and Second_Name = p_Second_Name and Middle_Name = p_Middle_Name
and Phone_Number = p_Phone_Number and Email = p_Email and Age = p_Age
and INN = p_INN and SNILS = p_SNILS and Position_ID = p_Position_ID and Post_Part = p_Post_Part;

begin
    if have_record > 0 then
        raise exception 'Указанный сотрудник уже есть в таблице!';
    else
        insert into Employee (First_Name, Second_Name, Middle_Name, Phone_Number, Email, Age, INN, SNILS, Post_Part,
                              Position_ID)
        values (p_First_Name, p_Second_Name, p_Middle_Name, p_Phone_Number, p_Email, p_Age, p_INN, p_SNILS, p_Post_Part,
                p_Position_ID);
    end if;
end;
$$;



create or replace procedure Employee_Update(p_ID_Employee int, p_First_Name varchar(30), p_Second_Name varchar(30),
                                            p_Middle_Name varchar(30), p_Phone_Number varchar(19),
                                            p_Email varchar, p_Age int, p_INN varchar(12), p_SNILS varchar(14)
    , p_Post_Part decimal(38, 1), p_Position_ID int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Employee
	where First_Name = p_First_Name and Second_Name = p_Second_Name and Middle_Name = p_Middle_Name
and Phone_Number = p_Phone_Number and Email = p_Email and Age = p_Age
and INN = p_INN and SNILS = p_SNILS and Position_ID = p_Position_ID and Post_Part = p_Post_Part;

begin
    if have_record > 0 then
        raise exception 'Указанный сотрудник уже есть в таблице';
    else
        update Employee
        set First_Name   = p_First_Name,
            Second_Name  = p_Second_Name,
            Middle_Name  = p_Middle_Name,
            Phone_Number = p_Phone_Number,
            Email        = p_Email,
            Age          = p_Age,
            INN          = p_INN,
            SNILS        = p_SNILS,
            Post_Part    = p_Post_Part,
            Position_ID  = p_Position_ID
        where ID_Employee = p_ID_Employee;
    end if;
end;
$$;


create or replace procedure Employee_Delete(p_ID_Employee int)
    language plpgsql
as
$$
DECLARE
    have_record_Receipt              int := count(*) from Receipt
	where Employee_ID = p_ID_Employee;
    have_record_Track                int := count(*) from Track
	where Employee_ID = p_ID_Employee;
    have_record_Rental_Outfit_Client int := count(*) from Rental_Outfit_Client
	where Employee_ID = p_ID_Employee;


begin
    if have_record_Receipt > 0 OR have_record_Track > 0 OR have_record_Rental_Outfit_Client > 0 then
        raise exception 'Данную запись "сотрудник" нельзя удалить, так как оно задействовано в других справочниках';
    else
        delete
        from Employee
        where ID_Employee = p_ID_Employee;
    end if;
end;
$$;


---------------------------------------------------------Cableway-------------------------------------------------------


create or replace procedure Cableway_Insert(p_Roominess int, p_Price int)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Cableway
where Roominess = p_Roominess and Price = p_Price;
begin
    if have_record > 0 then
        raise exception 'Указанная "Канатная дорога" уже есть в таблице!';
    else
        insert into Cableway (Roominess, Price)
        values (p_Roominess, p_Price);
    end if;
end;
$$;



create or replace procedure Cableway_Update(p_ID_Cableway int, p_Roominess int, p_Price int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Cableway
	where Roominess = p_Roominess and Price = p_Price;

begin
    if have_record > 0 then
        raise exception 'Указанная "Канатная дорога" уже есть в таблице';
    else
        update Cableway
        set Roominess = p_Roominess,
            Price     = p_Price
        where ID_Cableway = p_ID_Cableway;
    end if;
end;
$$;


create or replace procedure Cableway_Delete(p_ID_Cableway int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Track
	where Cableway_ID = p_ID_Cableway;
begin
    if have_record > 0 then
        raise exception 'Данную запись "Канатная дорога" нельзя удалить, так как оно задействовано в справочнике "Склоны"!';
    else
        delete
        from Cableway
        where ID_Cableway = p_ID_Cableway;
    end if;
end;
$$;

---------------------------------------------------------Track----------------------------------------------------------

create or replace procedure Track_Insert(p_Complexity int, p_Title varchar(50), p_Employee_ID int, p_Cableway_ID int)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Track
where Complexity = p_Complexity and Title = p_Title and Employee_ID = p_Employee_ID and Cableway_ID = p_Cableway_ID;
begin
    if have_record > 0 then
        raise exception 'Указанный "Склон" уже есть в таблице!';
    else
        insert into Track (Complexity, Title, Employee_ID, Cableway_ID)
        values (p_Complexity, p_Title, p_Employee_ID, p_Cableway_ID);
    end if;
end;
$$;



create or replace procedure Track_Update(p_ID_Track int, p_Complexity int, p_Title varchar(50), p_Employee_ID int,
                                         p_Cableway_ID int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Track
	where Complexity = p_Complexity and Title = p_Title and Employee_ID = p_Employee_ID and Cableway_ID = p_Cableway_ID;

begin
    if have_record > 0 then
        raise exception 'Указанный "Склон" уже есть в таблице';
    else
        update Cableway
        set Complexity  = p_Complexity,
            Title       = p_Title,
            Employee_ID = p_Employee_ID,
            Cableway_ID = p_Cableway_ID
        where ID_Track = p_ID_Track;
    end if;
end;
$$;


create or replace procedure Track_Delete(p_ID_Track int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Status_Card_Track
	where Track_ID = p_ID_Track;
begin
    if have_record > 0 then
        raise exception 'Данную запись "слон" нельзя удалить, так как оно задействовано в справочнике "статус карты склон"!';
    else
        delete
        from Track
        where ID_Track = p_ID_Track;
    end if;
end;
$$;

---------------------------------------------------------Status_Card_Track----------------------------------------------

create or replace procedure Status_Card_Track_Insert(p_Track_Permission boolean, p_Track_ID int, p_Status_Card_ID int)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Status_Card_Track
where Track_Permission = p_Track_Permission and Track_ID = p_Track_ID and Status_Card_ID = p_Status_Card_ID;
begin
    if have_record > 0 then
        raise exception 'Указанная запись уже есть в таблице!';
    else
        insert into Status_Card_Track (Track_Permission, Track_ID, Status_Card_ID)
        values (p_Track_Permission, p_Track_ID, p_Status_Card_ID);
    end if;
end;
$$;



create or replace procedure Status_Card_Track_Update(p_ID_Status_Card_Track int, p_Track_Permission boolean,
                                                     p_Track_ID int, p_Status_Card_ID int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Track
	where Track_Permission = p_Track_Permission and Track_ID = p_Track_ID and Status_Card_ID = p_Status_Card_ID;

begin
    if have_record > 0 then
        raise exception 'Указанная запись уже есть в таблице';
    else
        update Status_Card_Track
        set Track_Permission = p_Track_Permission,
            Track_ID         = p_Track_ID,
            Status_Card_ID   = p_Status_Card_ID
        where ID_Status_Card_Track = p_ID_Status_Card_Track;
    end if;
end;
$$;


create or replace procedure Status_Card_Track_Delete(p_ID_Status_Card_Track int)
    language plpgsql
as
$$
begin
    delete
    from Status_Card_Track
    where ID_Status_Card_Track = p_ID_Status_Card_Track;
end;
$$;

---------------------------------------------------------Client---------------------------------------------------------


create or replace procedure Client_Insert(p_First_Name varchar(30), p_Second_Name varchar(30),
                                          p_Middle_Name varchar(30), p_Phone_Number varchar(19),
                                          p_Email varchar, p_Age int, p_NumberDL varchar(11), p_Bonus_Card_ID int)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Client
where First_Name = p_First_Name and Second_Name = p_Second_Name and Middle_Name = p_Middle_Name
and Phone_Number = p_Phone_Number and Email = p_Email and Age = p_Age
and NumberDL = p_NumberDL and Bonus_Card_ID = p_Bonus_Card_ID;

begin
    if have_record > 0 then
        raise exception 'Указанный клиент уже есть в таблице!';
    else
        insert into Client (First_Name, Second_Name, Middle_Name, Phone_Number, Email, Age, NumberDL, Bonus_Card_ID)
        values (p_First_Name, p_Second_Name, p_Middle_Name, p_Phone_Number, p_Email, p_Age, p_NumberDL,
                p_Bonus_Card_ID);
    end if;
end;
$$;



create or replace procedure Client_Update(p_ID_Client int, p_First_Name varchar(30), p_Second_Name varchar(30),
                                          p_Middle_Name varchar(30), p_Phone_Number varchar(19),
                                          p_Email varchar, p_Age int, p_NumberDL varchar(11), p_Bonus_Card_ID int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Client
	where First_Name = p_First_Name and Second_Name = p_Second_Name and Middle_Name = p_Middle_Name
	and Phone_Number = p_Phone_Number and Email = p_Email and Age = p_Age
	and NumberDL = p_NumberDL and Bonus_Card_ID = p_Bonus_Card_ID;

begin
    if have_record > 0 then
        raise exception 'Указанный клиент уже есть в таблице';
    else
        update Client
        set First_Name    = p_First_Name,
            Second_Name   = p_Second_Name,
            Middle_Name   = p_Middle_Name,
            Phone_Number  = p_Phone_Number,
            Email         = p_Email,
            Age           = p_Age,
            NumberDL      = p_NumberDL,
            Bonus_Card_ID = p_Bonus_Card_ID
        where ID_Client = p_ID_Client;
    end if;
end;
$$;


create or replace procedure Client_Delete(p_ID_Client int)
    language plpgsql
as
$$
DECLARE
    have_record_Receipt              int := count(*) from Receipt
	where Client_ID = p_ID_Client;
    have_record_Rental_Outfit_Client int := count(*) from Rental_Outfit_Client
	where Client_ID = p_ID_Client;

begin
    if have_record_Receipt > 0 OR have_record_Rental_Outfit_Client > 0 then
        raise exception 'Данную запись "клиент" нельзя удалить, так как оно задействовано в других справочниках';
    else
        delete
        from Client
        where ID_Client = p_ID_Client;
    end if;
end;
$$;


---------------------------------------------------------Receipt--------------------------------------------------------

create or replace procedure Receipt_Insert(p_Date_Of_Creation date, p_Employee_ID int, p_Rental_Outfit_Client_ID int)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Receipt
where Date_Of_Creation = p_Date_Of_Creation and Employee_ID = p_Employee_ID and Rental_Outfit_Client_ID = p_Rental_Outfit_Client_ID;
begin
    if have_record > 0 then
        raise exception 'Указанный чек уже есть в таблице!';
    else
        insert into Receipt (Date_Of_Creation, Employee_ID, Rental_Outfit_Client_ID)
        values (p_Date_Of_Creation, p_Employee_ID, p_Rental_Outfit_Client_ID);
    end if;
end;
$$;


create or replace procedure Receipt_Update(p_ID_Receipt int, p_Date_Of_Creation date, p_Employee_ID int,
                                           p_Rental_Outfit_Client_ID int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Receipt
	where Date_Of_Creation = p_Date_Of_Creation and Employee_ID = p_Employee_ID and Rental_Outfit_Client_ID = p_Rental_Outfit_Client_ID;

begin
    if have_record > 0 then
        raise exception 'Указанный чек уже есть в таблице';
    else
        update Receipt
        set Date_Of_Creation        = p_Date_Of_Creation,
            Employee_ID             = p_Employee_ID,
            Rental_Outfit_Client_ID = p_Rental_Outfit_Client_ID
        where ID_Receipt = p_ID_Receipt;
    end if;
end;
$$;


create or replace procedure Receipt_Delete(p_ID_Receipt int)
    language plpgsql
as
$$
begin
    delete from Receipt where ID_Receipt = p_ID_Receipt;
end;
$$;

---------------------------------------------------------Rental_Outfit_Client-------------------------------------------


create or replace procedure Rental_Outfit_Client_Insert(p_Employee_ID int, p_Client_ID int, p_Rental_Outfit_ID int)
    language plpgsql
as
$$

DECLARE
    have_record int := count(*) from Rental_Outfit_Client
where Employee_ID = p_Employee_ID and Client_ID = p_Client_ID and Rental_Outfit_ID = p_Rental_Outfit_ID;
begin
    if have_record > 0 then
        raise exception 'Указанная запись уже есть в таблице!';
    else
        insert into Rental_Outfit_Client (Employee_ID, Client_ID, Rental_Outfit_ID)
        values (p_Employee_ID, p_Client_ID, p_Rental_Outfit_ID);
    end if;
end;
$$;



create or replace procedure Rental_Outfit_Client_Update(p_ID_Rental_Outfit_Client int, p_Employee_ID int,
                                                        p_Client_ID int, p_Rental_Outfit_ID int)
    language plpgsql
as
$$
DECLARE
    have_record int := count(*) from Rental_Outfit_Client
	where Employee_ID = p_Employee_ID and Client_ID = p_Client_ID and Rental_Outfit_ID = p_Rental_Outfit_ID;

begin
    if have_record > 0 then
        raise exception 'Указанная запись уже есть в таблице';
    else
        update Rental_Outfit_Client
        set Employee_ID      = p_Employee_ID,
            Client_ID        = p_Client_ID,
            Rental_Outfit_ID = p_Rental_Outfit_ID
        where ID_Rental_Outfit_Client = p_ID_Rental_Outfit_Client;
    end if;
end;
$$;


create or replace procedure Receipt_Rental_Outfit_Client(p_ID_Rental_Outfit_Client int)
    language plpgsql
as
$$
begin
    delete from Rental_Outfit_Client where ID_Rental_Outfit_Client = p_ID_Rental_Outfit_Client;
end;
$$;
