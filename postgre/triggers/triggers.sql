create table TableName
(
    ID_TableName SERIAL not null constraint PK_TableName primary key,
    TableName varchar (50) not null
);

insert into TableName (TableName) values ('Outfit');
insert into TableName (TableName) values ('Rental_Outfit');
insert into TableName (TableName) values ('Status_Card');
insert into TableName (TableName) values ('Bonus_Card');
insert into TableName (TableName) values ('Position');
insert into TableName (TableName) values ('Employee');
insert into TableName (TableName) values ('Cableway');
insert into TableName (TableName) values ('Track');
insert into TableName (TableName) values ('Status_Card_Track');
insert into TableName (TableName) values ('Client');
insert into TableName (TableName) values ('Receipt');
insert into TableName (TableName) values ('Rental_Outfit_Client');

create table Trigger_History
(
    ID_Trigger_History SERIAL not null constraint PK_Trigger_History primary key,
    Status_History varchar (50) not null,
    Log_Info varchar not null,
    Date_Create date null default now(),
    TableName_ID int not null references TableName (ID_TableName)
);

select * from TableName;
---------------------------------------------------------Outfit---------------------------------------------------------

CREATE OR REPLACE FUNCTION add_to_log_outfit() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 1;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = (select concat('insert outfit; name: ',NEW.Title));
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';
        log_info = (select concat('update outfit; new name: ',NEW.Title,' old name: ',OLD.title));
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';
        log_info = (select concat('delete outfit; name: ',OLD.Title));
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Outfit AFTER INSERT OR UPDATE OR DELETE
    ON Outfit FOR EACH ROW EXECUTE PROCEDURE add_to_log_outfit ();

---------------------------------------------------------Rental_Outfit--------------------------------------------------

CREATE OR REPLACE FUNCTION add_to_log_rental_outfit() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 2;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = ((select concat('insert rental outfit; ',
                                    'title outfit: ',
                                    cast(title as varchar(50)),
                                    'Date issue: ',cast(NEW.Date_Issue as varchar(100)),
                                    'Return date: ',cast(NEW.Return_Date as varchar(100))
                                ) from Outfit where id_outfit = NEW.Outfit_ID)
                    );
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = ((select concat('update rental outfit; ',
                                   'title outfit: ',
                                   cast(title as varchar(50)),
                                   'Date issue: ',cast(NEW.Date_Issue as varchar(100)),
                                   'Return date: ',cast(NEW.Return_Date as varchar(100))
                                ) from Outfit where id_outfit = NEW.Outfit_ID)
        );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        log_info = ((select concat('delete rental outfit; ',
                                   ' title outfit: ',
                                   cast(title as varchar(50)),
                                   ' Date issue: ',cast(OLD.Date_Issue as varchar(100)),
                                   ' Return date: ',cast(OLD.Return_Date as varchar(100))
                                ) from Outfit where id_outfit = OLD.Outfit_ID)
        );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Rental_Outfit AFTER INSERT OR UPDATE OR DELETE
    ON Rental_Outfit FOR EACH ROW EXECUTE PROCEDURE add_to_log_rental_outfit ();



---------------------------------------------------------Status_Card----------------------------------------------------


CREATE OR REPLACE FUNCTION add_to_log_status_card() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 3;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = (select concat('insert status card; status name: ',NEW.Title));
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';
        log_info = (select concat('update status card; status name: ',NEW.Title));
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';
        log_info = (select concat('delete status card; status name: ',OLD.Title));
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Status_Card AFTER INSERT OR UPDATE OR DELETE
    ON Status_Card FOR EACH ROW EXECUTE PROCEDURE add_to_log_status_card ();

---------------------------------------------------------Bonus_Card-----------------------------------------------------

CREATE OR REPLACE FUNCTION add_to_log_bonus_card() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 4;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = ((select concat('insert bonus card; ',
                                   'Tariff card: ',
                                   cast(NEW.Tariff as varchar(50)),
                                   'Balance card: ',
                                   cast(NEW.Balance as varchar(50)),
                                   'Status name: ', cast(title as varchar(50))
                                ) from Status_Card where id_status_card = NEW.Status_Card_ID)
        );
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = ((select concat('update bonus card; ',
                                   'Tariff card: ',
                                   cast(NEW.Tariff as varchar(50)),
                                   'Balance card: ',
                                   cast(NEW.Balance as varchar(50)),
                                   'Status name: ', cast(title as varchar(50))
                                ) from Status_Card where id_status_card = NEW.Status_Card_ID)
        );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        log_info = ((select concat('delete bonus card; ',
                                   'Tariff card: ',
                                   cast(OLD.Tariff as varchar(50)),
                                   'Balance card: ',
                                   cast(OLD.Balance as varchar(50)),
                                   'Status name: ', cast(title as varchar(50))
                                ) from Status_Card where id_status_card = OLD.Status_Card_ID)
        );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Bonus_Card AFTER INSERT OR UPDATE OR DELETE
    ON Bonus_Card FOR EACH ROW EXECUTE PROCEDURE add_to_log_bonus_card ();




---------------------------------------------------------Position-------------------------------------------------------

CREATE OR REPLACE FUNCTION add_to_log_position() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 5;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = (select concat(
            'insert position; position name: ',NEW.Title,
            ' Post price: ',NEW.Post_Price,
            ' Description price: ',NEW.Description,
            ' Responsibilities price: ',NEW.Responsibilities));
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = (select concat(
                                   'update position; position name: ',NEW.Title,
                                   ' Post price: ',NEW.Post_Price,
                                   ' Description price: ',NEW.Description,
                                   ' Responsibilities price: ',NEW.Responsibilities));

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        log_info = (select concat(
                                   'delete position; post name: ',OLD.Title,
                                   ' Post price: ',OLD.Post_Price,
                                   ' Description price: ',OLD.Description,
                                   ' Responsibilities price: ',OLD.Responsibilities));

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Position AFTER INSERT OR UPDATE OR DELETE
    ON Position FOR EACH ROW EXECUTE PROCEDURE add_to_log_position ();

---------------------------------------------------------Employee-------------------------------------------------------

CREATE OR REPLACE FUNCTION add_to_log_employee() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 6;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = ((select concat('insert employee; ',
                                   concat(NEW.First_Name,' ',NEW.Second_Name,' ',NEW.Middle_Name),
                                   'Status name: ', cast(title as varchar(50)),
                                   concat('post name ',Title,', post price: ', cast(Post_Price as varchar(100)), 'post part: ', cast(NEW.Post_Part as varchar(100)))
                                ) from Position where id_position = NEW.Position_ID)
        );
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = ((select concat('update employee; ',
                                   concat(NEW.First_Name,' ',NEW.Second_Name,' ',NEW.Middle_Name),
                                   'Status name: ', cast(title as varchar(50)),
                                   concat('post name ',Title,', post price: ', cast(Post_Price as varchar(100)), 'post part: ', cast(NEW.Post_Part as varchar(100)))
                                ) from Position where id_position = NEW.Position_ID)
        );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        log_info = ((select concat('delete employee; ',
                                   concat(OLD.First_Name,' ',OLD.Second_Name,' ',OLD.Middle_Name),
                                   'Status name: ', cast(title as varchar(50)),
                                   concat('post name ',Title,', post price: ', cast(Post_Price as varchar(100)), 'post part: ', cast(OLD.Post_Part as varchar(100)))
                                ) from Position where id_position = OLD.Position_ID)
        );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Employee AFTER INSERT OR UPDATE OR DELETE
    ON Employee FOR EACH ROW EXECUTE PROCEDURE add_to_log_employee ();




---------------------------------------------------------Cableway-------------------------------------------------------


CREATE OR REPLACE FUNCTION add_to_log_cableway() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 7;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = (select concat(
                                   'insert cableway; Roominess: ',NEW.Roominess,
                                   ' Price: ',NEW.Price));
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = (select concat(
                                   'update cableway; Roominess: ',NEW.Roominess,
                                   ' Price: ',NEW.Price));

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        log_info = (select concat(
                                   'delete cableway; Roominess: ',OLD.Roominess,
                                   ' Price: ',OLD.Price));

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Cableway AFTER INSERT OR UPDATE OR DELETE
    ON Cableway FOR EACH ROW EXECUTE PROCEDURE add_to_log_cableway ();


---------------------------------------------------------Track----------------------------------------------------------

CREATE OR REPLACE FUNCTION add_to_log_track() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 8;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = (
                    'insert track; track name: ',NEW.Title,'Track attendant: ',
                    (select concat(First_Name,' ',Second_Name,' ',Middle_Name)
                    from Employee where id_employee = NEW.Employee_ID),
                    (select concat('Cableway price: ',Price)
                    from Cableway where id_cableway = NEW.Cableway_ID)
        );
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = (
                    'update track; track name: ',NEW.Title,'Track attendant: ',
                    (select concat(First_Name,' ',Second_Name,' ',Middle_Name)
                    from Employee where id_employee = NEW.Employee_ID),
                    (select concat('Cableway price: ',Price)
                     from Cableway where id_cableway = NEW.Cableway_ID)
            );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        log_info = (
                    'delete track; track name: ',OLD.Title,'Track attendant: ',
                    (select concat(First_Name,' ',Second_Name,' ',Middle_Name)
                    from Employee where id_employee = OLD.Employee_ID),
                    (select concat('Cableway price: ',Price)
                     from Cableway where id_cableway = OLD.Cableway_ID)
            );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Track AFTER INSERT OR UPDATE OR DELETE
    ON Track FOR EACH ROW EXECUTE PROCEDURE add_to_log_track ();

---------------------------------------------------------Status_Card_Track----------------------------------------------

CREATE OR REPLACE FUNCTION add_to_log_status_card_track() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 9;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = (
                    'insert status card track; permission: ',NEW.Track_Permission,
                    'Track name: ',(select concat(title)
                    from Track where id_track = NEW.Track_ID),
                    'status name: ',(select concat(title)
                     from Status_Card where id_status_card = NEW.Status_Card_ID)
            );
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = (
                    'update status card track; permission: ',NEW.Track_Permission,
                    'Track name: ',(select concat(title)
                                    from Track where id_track = NEW.Track_ID),
                    'status name: ',(select concat(title)
                                     from Status_Card where id_status_card = NEW.Status_Card_ID)
            );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        log_info = (
                    'delete status card track; permission: ',OLD.Track_Permission,
                    'Track name: ',(select concat(title)
                                    from Track where id_track = OLD.Track_ID),
                    'status name: ',(select concat(title)
                                     from Status_Card where id_status_card = OLD.Status_Card_ID)
            );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Status_Card_Track AFTER INSERT OR UPDATE OR DELETE
    ON Status_Card_Track FOR EACH ROW EXECUTE PROCEDURE add_to_log_status_card_track ();

---------------------------------------------------------Client---------------------------------------------------------


CREATE OR REPLACE FUNCTION add_to_log_client() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 10;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = ((select concat('insert client; ',NEW.First_Name,' ',NEW.Second_Name,' ',NEW.Middle_Name,
                                   'bonus card tariff : ',tariff)
                     from Bonus_Card where id_bonus_card = NEW.Bonus_Card_ID)
        );


        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = ((select concat('update client; ',NEW.First_Name,' ',NEW.Second_Name,' ',NEW.Middle_Name,
                                   'bonus card tariff : ',tariff)
                     from Bonus_Card where id_bonus_card = NEW.Bonus_Card_ID)
        );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        log_info = ((select concat('delete client; ',OLD.First_Name,' ',OLD.Second_Name,' ',OLD.Middle_Name,
                                   'bonus card tariff : ',tariff)
                     from Bonus_Card where id_bonus_card = OLD.Bonus_Card_ID)
        );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Client AFTER INSERT OR UPDATE OR DELETE
    ON Client FOR EACH ROW EXECUTE PROCEDURE add_to_log_client ();


---------------------------------------------------------Receipt--------------------------------------------------------

CREATE OR REPLACE FUNCTION add_to_log_receipt() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 11;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = (
                    'insert receipt; Date of creation: ',NEW.Date_Of_Creation,
                    (select  concat('Cashier: ',First_Name,' ',Second_Name,' ',Middle_Name)
                     from Employee where id_employee = NEW.Employee_ID),
                    (select concat('Client: ',First_Name,' ',Second_Name,' ',Middle_Name)
                     from Rental_Outfit_Client
                              INNER JOIN client
                                         ON client_id = client.id_client
                     where id_rental_outfit_client = NEW.Rental_Outfit_Client_ID)
            );
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = (
                    'update receipt; Date of creation: ',NEW.Date_Of_Creation,
                    (select  concat('Cashier: ',First_Name,' ',Second_Name,' ',Middle_Name)
                     from Employee where id_employee = NEW.Employee_ID),
                    (select concat('Client: ',First_Name,' ',Second_Name,' ',Middle_Name)
                     from Rental_Outfit_Client
                              INNER JOIN client
                                         ON client_id = client.id_client
                     where id_rental_outfit_client = NEW.Rental_Outfit_Client_ID)
            );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);

        log_info = (
                    'delete receipt; Date of creation: ',OLD.Date_Of_Creation,
                    (select  concat('Cashier: ',First_Name,' ',Second_Name,' ',Middle_Name)
                     from Employee where id_employee = OLD.Employee_ID),
                    (select concat('Client: ',First_Name,' ',Second_Name,' ',Middle_Name)
                     from Rental_Outfit_Client
                              INNER JOIN client
                                         ON client_id = client.id_client
                              where id_rental_outfit_client = OLD.Rental_Outfit_Client_ID)
            );
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Receipt AFTER INSERT OR UPDATE OR DELETE
    ON Receipt FOR EACH ROW EXECUTE PROCEDURE add_to_log_receipt();

---------------------------------------------------------Rental_Outfit_Client-------------------------------------------

CREATE OR REPLACE FUNCTION add_to_log_rental_outfit_client() RETURNS TRIGGER AS $$
DECLARE
    Status_History varchar(30);
    log_info varchar;
    id_tableName int = 12;
BEGIN
    IF TG_OP = 'INSERT' THEN
        Status_History = 'INSERT';
        log_info = (
                    'insert rental_outfit_client;',
                    'Cashier: ',(select  concat(First_Name,' ',Second_Name,' ',Middle_Name)
                                 from Employee where id_employee = NEW.Employee_ID),
                    'Client: ',(select concat(First_Name,' ',Second_Name,' ',Middle_Name)
                                from Client where id_client = NEW.Client_ID),
                    (select concat('Price: ',price,' Date_Issue: ',date_issue,' return date: ',return_date)
                                from Rental_Outfit where id_rental_outfit = NEW.Rental_Outfit_ID)
            );
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'UPDATE' THEN
        Status_History = 'UPDATE';

        log_info = (
                    'update rental_outfit_client;',
                    'Cashier: ',(select  concat(First_Name,' ',Second_Name,' ',Middle_Name)
                                 from Employee where id_employee = NEW.Employee_ID),
                    'Client: ',(select concat(First_Name,' ',Second_Name,' ',Middle_Name)
                                from Client where id_client = NEW.Client_ID),
                    (select concat('Price: ',price,' Date_Issue: ',date_issue,' return date: ',return_date)
                     from Rental_Outfit where id_rental_outfit = NEW.Rental_Outfit_ID)
            );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        Status_History = 'DELETE';

        log_info = (
                    'delete rental_outfit_client;',
                    'Cashier: ',(select  concat(First_Name,' ',Second_Name,' ',Middle_Name)
                                 from Employee where id_employee = OLD.Employee_ID),
                    'Client: ',(select concat(First_Name,' ',Second_Name,' ',Middle_Name)
                                from Client where id_client = OLD.Client_ID),
                    (select concat('Price: ',price,' Date_Issue: ',date_issue,' return date: ',return_date)
                     from Rental_Outfit where id_rental_outfit = OLD.Rental_Outfit_ID)
            );

        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values (Status_History, log_info, id_tableName);
        RETURN OLD;
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_Rental_Outfit_Client AFTER INSERT OR UPDATE OR DELETE
    ON Rental_Outfit_Client FOR EACH ROW EXECUTE PROCEDURE add_to_log_rental_outfit_client();

