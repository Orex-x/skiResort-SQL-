create table TableName
(
    ID_TableName int         not null auto_increment primary key,
    TableName    varchar(50) not null
);


insert into TableName (TableName)
values ('Outfit');
insert into TableName (TableName)
values ('Rental_Outfit');
insert into TableName (TableName)
values ('Status_Card');
insert into TableName (TableName)
values ('Bonus_Card');
insert into TableName (TableName)
values ('Position');
insert into TableName (TableName)
values ('Employee');
insert into TableName (TableName)
values ('Cableway');
insert into TableName (TableName)
values ('Track');
insert into TableName (TableName)
values ('Status_Card_Track');
insert into TableName (TableName)
values ('Client');
insert into TableName (TableName)
values ('Receipt');
insert into TableName (TableName)
values ('Rental_Outfit_Client');

create table Trigger_History
(
    ID_Trigger_History int          not null auto_increment primary key,
    Status_History     varchar(50)  not null,
    Log_Info           varchar(500) not null,
    Date_Create        date         null default now(),
    TableName_ID       int          not null references TableName (ID_TableName)
);

/*---------------------------------------------------------Outfit-----------------------------------------------------*/

DELIMITER $$
CREATE
    TRIGGER add_to_log_outfit_insert
    AFTER INSERT
    ON outfit
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert outfit; name: ', NEW.Title)),
            1);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_outfit_update
    AFTER UPDATE
    ON outfit
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update outfit; name: ', NEW.Title)),
            1);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_outfit_delete
    AFTER DELETE
    ON outfit
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete outfit; name: ', OLD.Title)),
            1);
END$$
DELIMITER ;

/*---------------------------------------------------------Rental_Outfit-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_rental_outfit_insert
    AFTER INSERT
    ON rental_outfit
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert rental outfit; ',
                           'title outfit: ',
                           cast(title as varchar(50)),
                           'Date issue: ', cast(NEW.Date_Issue as varchar(100)),
                           'Return date: ', cast(NEW.Return_Date as varchar(100))
                        )
             from outfit
             where id_outfit = NEW.Outfit_ID),
            2);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_rental_outfit_update
    AFTER UPDATE
    ON rental_outfit
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update rental outfit; ',
                           'title outfit: ',
                           cast(title as varchar(50)),
                           'Date issue: ', cast(NEW.Date_Issue as varchar(100)),
                           'Return date: ', cast(NEW.Return_Date as varchar(100))
                        )
             from outfit
             where id_outfit = NEW.Outfit_ID),
            2);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_rental_outfit_delete
    AFTER DELETE
    ON rental_outfit
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete rental outfit; ',
                           ' title outfit: ',
                           cast(title as varchar(50)),
                           ' Date issue: ', cast(OLD.Date_Issue as varchar(100)),
                           ' Return date: ', cast(OLD.Return_Date as varchar(100))
                        )
             from outfit
             where id_outfit = OLD.Outfit_ID),
            2);
END$$
DELIMITER ;


/*---------------------------------------------------------Status_Card-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_status_card_insert
    AFTER INSERT
    ON status_card
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert status card; status name: ', NEW.Title)),
            3);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_status_card_update
    AFTER UPDATE
    ON status_card
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update status card; status name: ', NEW.Title)),
            3);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_status_card_delete
    AFTER DELETE
    ON status_card
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete status card; status name: ', OLD.Title)),
            3);
END$$
DELIMITER ;


/*---------------------------------------------------------Bonus_Card-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_bonus_card_insert
    AFTER INSERT
    ON bonus_card
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert bonus card; ',
                           'Tariff card: ',
                           cast(NEW.Tariff as varchar(50)),
                           'Balance card: ',
                           cast(NEW.Balance as varchar(50)),
                           'Status name: ', cast(title as varchar(50))
                        )
             from status_Card
             where id_status_card = NEW.Status_Card_ID),
            4);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_bonus_card_update
    AFTER UPDATE
    ON bonus_card
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update bonus card; ',
                           'Tariff card: ',
                           cast(NEW.Tariff as varchar(50)),
                           'Balance card: ',
                           cast(NEW.Balance as varchar(50)),
                           'Status name: ', cast(title as varchar(50))
                        )
             from status_Card
             where id_status_card = NEW.Status_Card_ID),
            4);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_bonus_card_delete
    AFTER DELETE
    ON bonus_card
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete bonus card; ',
                           'Tariff card: ',
                           cast(OLD.Tariff as varchar(50)),
                           'Balance card: ',
                           cast(OLD.Balance as varchar(50)),
                           'Status name: ', cast(title as varchar(50))
                        )
             from status_Card
             where id_status_card = OLD.Status_Card_ID),
            4);
END$$
DELIMITER ;


/*---------------------------------------------------------Position-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_position_insert
    AFTER INSERT
    ON position
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat(
                            'insert position; position name: ', NEW.Title,
                            ' Post price: ', NEW.Post_Price,
                            ' Description price: ', NEW.Description,
                            ' Responsibilities price: ', NEW.Responsibilities)),
            5);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_position_update
    AFTER UPDATE
    ON position
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat(
                            'update position; position name: ', NEW.Title,
                            ' Post price: ', NEW.Post_Price,
                            ' Description price: ', NEW.Description,
                            ' Responsibilities price: ', NEW.Responsibilities)),
            5);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_position_delete
    AFTER DELETE
    ON position
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat(
                            'delete position; post name: ', OLD.Title,
                            ' Post price: ', OLD.Post_Price,
                            ' Description price: ', OLD.Description,
                            ' Responsibilities price: ', OLD.Responsibilities)),
            5);
END$$
DELIMITER ;

/*---------------------------------------------------------Employee-----------------------------------------------------*/

DELIMITER $$
CREATE
    TRIGGER add_to_log_employee_insert
    AFTER INSERT
    ON employee
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert employee; ',
                           concat(NEW.First_Name, ' ', NEW.Second_Name, ' ', NEW.Middle_Name),
                           'Status name: ', cast(title as varchar(50)),
                           concat('post name ', Title, ', post price: ', cast(Post_Price as varchar(100)),
                                  'post part: ', cast(NEW.Post_Part as varchar(100)))
                        )
             from position
             where id_position = NEW.Position_ID),
            6);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_employee_update
    AFTER UPDATE
    ON employee
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update employee; ',
                           concat(NEW.First_Name, ' ', NEW.Second_Name, ' ', NEW.Middle_Name),
                           'Status name: ', cast(title as varchar(50)),
                           concat('post name ', Title, ', post price: ', cast(Post_Price as varchar(100)),
                                  'post part: ', cast(NEW.Post_Part as varchar(100)))
                        )
             from position
             where id_position = NEW.Position_ID),
            6);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_employee_delete
    AFTER DELETE
    ON employee
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete employee; ',
                           concat(OLD.First_Name, ' ', OLD.Second_Name, ' ', OLD.Middle_Name),
                           'Status name: ', cast(title as varchar(50)),
                           concat('post name ', Title, ', post price: ', cast(Post_Price as varchar(100)),
                                  'post part: ', cast(OLD.Post_Part as varchar(100)))
                        )
             from position
             where id_position = OLD.Position_ID),
            6);
END$$
DELIMITER ;

/*---------------------------------------------------------Cableway-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_cableway_insert
    AFTER INSERT
    ON cableway
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat(
                            'insert cableway; Roominess: ', NEW.Roominess,
                            ' Price: ', NEW.Price)),
            7);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_cableway_update
    AFTER UPDATE
    ON cableway
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat(
                            'update cableway; Roominess: ', NEW.Roominess,
                            ' Price: ', NEW.Price)),
            7);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_cableway_delete
    AFTER DELETE
    ON cableway
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat(
                            'delete cableway; Roominess: ', OLD.Roominess,
                            ' Price: ', OLD.Price)),
            7);
END$$
DELIMITER ;

/*---------------------------------------------------------Track-----------------------------------------------------*/

DELIMITER $$
CREATE
    TRIGGER add_to_log_track_insert
    AFTER INSERT
    ON track
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (
             'insert track; track name: ', NEW.Title, 'Track attendant: ',
             (select concat(First_Name, ' ', Second_Name, ' ', Middle_Name)
              from employee
              where id_employee = NEW.Employee_ID),
             (select concat('Cableway price: ', Price)
              from cableway
              where id_cableway = NEW.Cableway_ID)
                ),
            8);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_track_update
    AFTER UPDATE
    ON track
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (
             'update track; track name: ', NEW.Title, 'Track attendant: ',
             (select concat(First_Name, ' ', Second_Name, ' ', Middle_Name)
              from employee
              where id_employee = NEW.Employee_ID),
             (select concat('Cableway price: ', Price)
              from cableway
              where id_cableway = NEW.Cableway_ID)
                ),
            8);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_track_delete
    AFTER DELETE
    ON track
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (
             'delete track; track name: ', OLD.Title, 'Track attendant: ',
             (select concat(First_Name, ' ', Second_Name, ' ', Middle_Name)
              from employee
              where id_employee = OLD.Employee_ID),
             (select concat('Cableway price: ', Price)
              from cableway
              where id_cableway = OLD.Cableway_ID)
                ),
            8);
END$$
DELIMITER ;

/*---------------------------------------------------------Status_Card_Track-----------------------------------------------------*/

DELIMITER $$
CREATE
    TRIGGER add_to_log_status_card_track_insert
    AFTER INSERT
    ON status_card_track
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (
             'insert status card track; permission: ', NEW.Track_Permission,
             'Track name: ', (select concat(title)
                              from track
                              where id_track = NEW.Track_ID),
             'status name: ', (select concat(title)
                               from status_Card
                               where id_status_card = NEW.Status_Card_ID)
                ),
            9);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_status_card_track_update
    AFTER UPDATE
    ON status_card_track
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (
             'update status card track; permission: ', NEW.Track_Permission,
             'Track name: ', (select concat(title)
                              from track
                              where id_track = NEW.Track_ID),
             'status name: ', (select concat(title)
                               from status_Card
                               where id_status_card = NEW.Status_Card_ID)
                ),
            9);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_status_card_track_delete
    AFTER DELETE
    ON status_card_track
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (
             'delete status card track; permission: ', OLD.Track_Permission,
             'Track name: ', (select concat(title)
                              from track
                              where id_track = OLD.Track_ID),
             'status name: ', (select concat(title)
                               from status_Card
                               where id_status_card = OLD.Status_Card_ID)
                ),
            9);
END$$
DELIMITER ;

/*---------------------------------------------------------Client-----------------------------------------------------*/

DELIMITER $$
CREATE
    TRIGGER add_to_log_client_insert
    AFTER INSERT
    ON client
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert client; ', NEW.First_Name, ' ', NEW.Second_Name, ' ', NEW.Middle_Name,
                           'bonus card tariff : ', tariff)
             from bonus_Card
             where id_bonus_card = NEW.Bonus_Card_ID),
            10);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_client_update
    AFTER UPDATE
    ON client
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update client; ', NEW.First_Name, ' ', NEW.Second_Name, ' ', NEW.Middle_Name,
                           'bonus card tariff : ', tariff)
             from bonus_Card
             where id_bonus_card = NEW.Bonus_Card_ID),
            10);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_client_delete
    AFTER DELETE
    ON client
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete client; ', OLD.First_Name, ' ', OLD.Second_Name, ' ', OLD.Middle_Name,
                           'bonus card tariff : ', tariff)
             from bonus_Card
             where id_bonus_card = OLD.Bonus_Card_ID),
            10);
END$$
DELIMITER ;


/*---------------------------------------------------------Receipt-----------------------------------------------------*/

DELIMITER $$
CREATE
    TRIGGER add_to_log_receipt_insert
    AFTER INSERT
    ON receipt
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (
             'insert receipt; Date of creation: ', NEW.Date_Of_Creation,
             (select concat('Cashier: ', First_Name, ' ', Second_Name, ' ', Middle_Name)
              from employee
              where id_employee = NEW.Employee_ID),
             (select concat('Client: ', First_Name, ' ', Second_Name, ' ', Middle_Name)
              from rental_Outfit_Client
                       INNER JOIN client
                                  ON client_id = client.id_client
              where id_rental_outfit_client = NEW.Rental_Outfit_Client_ID)
                ),
            11);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_receipt_update
    AFTER UPDATE
    ON receipt
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (
             'update receipt; Date of creation: ', NEW.Date_Of_Creation,
             (select concat('Cashier: ', First_Name, ' ', Second_Name, ' ', Middle_Name)
              from employee
              where id_employee = NEW.Employee_ID),
             (select concat('Client: ', First_Name, ' ', Second_Name, ' ', Middle_Name)
              from rental_Outfit_Client
                       INNER JOIN client
                                  ON client_id = client.id_client
              where id_rental_outfit_client = NEW.Rental_Outfit_Client_ID)
                ),
            11);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_receipt_delete
    AFTER DELETE
    ON receipt
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (
             'delete receipt; Date of creation: ', OLD.Date_Of_Creation,
             (select concat('Cashier: ', First_Name, ' ', Second_Name, ' ', Middle_Name)
              from employee
              where id_employee = OLD.Employee_ID),
             (select concat('Client: ', First_Name, ' ', Second_Name, ' ', Middle_Name)
              from rental_Outfit_Client
                       INNER JOIN client
                                  ON client_id = client.id_client
              where id_rental_outfit_client = OLD.Rental_Outfit_Client_ID)
                ),
            11);
END$$
DELIMITER ;

/*---------------------------------------------------------Rental_Outfit_Client-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_rental_outfit_client_insert
    AFTER INSERT
    ON rental_outfit_client
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (
             'insert rental_outfit_client;',
             'Cashier: ', (select concat(First_Name, ' ', Second_Name, ' ', Middle_Name)
                           from employee
                           where id_employee = NEW.Employee_ID),
             'Client: ', (select concat(First_Name, ' ', Second_Name, ' ', Middle_Name)
                          from client
                          where id_client = NEW.Client_ID),
             (select concat('Price: ', price, ' Date_Issue: ', date_issue, ' return date: ', return_date)
              from rental_Outfit
              where id_rental_outfit = NEW.Rental_Outfit_ID)
                ),
            12);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_rental_outfit_client_update
    AFTER UPDATE
    ON rental_outfit_client
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (
             'update rental_outfit_client;',
             'Cashier: ', (select concat(First_Name, ' ', Second_Name, ' ', Middle_Name)
                           from employee
                           where id_employee = NEW.Employee_ID),
             'Client: ', (select concat(First_Name, ' ', Second_Name, ' ', Middle_Name)
                          from client
                          where id_client = NEW.Client_ID),
             (select concat('Price: ', price, ' Date_Issue: ', date_issue, ' return date: ', return_date)
              from rental_Outfit
              where id_rental_outfit = NEW.Rental_Outfit_ID)
                ),
            12);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_rental_outfit_client_delete
    AFTER DELETE
    ON rental_outfit_client
    FOR EACH ROW
BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (
             'delete rental_outfit_client;',
             'Cashier: ', (select concat(First_Name, ' ', Second_Name, ' ', Middle_Name)
                           from employee
                           where id_employee = OLD.Employee_ID),
             'Client: ', (select concat(First_Name, ' ', Second_Name, ' ', Middle_Name)
                          from client
                          where id_client = OLD.Client_ID),
             (select concat('Price: ', price, ' Date_Issue: ', date_issue, ' return date: ', return_date)
              from rental_Outfit
              where id_rental_outfit = OLD.Rental_Outfit_ID)),
            12);
END$$
DELIMITER ;