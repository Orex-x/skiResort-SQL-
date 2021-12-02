create table TableName
(
    ID_TableName int not null auto_increment primary key,
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
    ID_Trigger_History int not null auto_increment primary key,
    Status_History varchar (50) not null,
    Log_Info varchar(500) not null,
    Date_Create date null default now(),
    TableName_ID int not null references TableName (ID_TableName)
);

/*---------------------------------------------------------Outfit-----------------------------------------------------*/

DELIMITER $$
CREATE
    TRIGGER add_to_log_outfit_insert AFTER INSERT
    ON outfit
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert outfit; name: ',NEW.Title)),
            1);
    END$$
    DELIMITER ;


DELIMITER $$
    CREATE
        TRIGGER add_to_log_outfit_update AFTER UPDATE
        ON outfit
        FOR EACH ROW BEGIN
        INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
        values ('UPDATE',
                (select concat('update outfit; name: ',NEW.Title)),
                1);
        END$$
        DELIMITER ;


DELIMITER $$
        CREATE
            TRIGGER add_to_log_outfit_delete AFTER DELETE
            ON outfit
            FOR EACH ROW BEGIN
            INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
            values ('DELETE',
                    (select concat('delete outfit; name: ',OLD.Title)),
                    1);
            END$$
            DELIMITER ;

/*---------------------------------------------------------Rental_Outfit-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_rental_outfit_insert AFTER INSERT
    ON rental_outfit
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert rental outfit; ',
                           'title outfit: ',
                           cast(title as varchar(50)),
                           'Date issue: ',cast(NEW.Date_Issue as varchar(100)),
                           'Return date: ',cast(NEW.Return_Date as varchar(100))
                        ) from outfit where id_outfit = NEW.Outfit_ID),
            2);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_rental_outfit_update AFTER UPDATE
    ON rental_outfit
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update rental outfit; ',
                           'title outfit: ',
                           cast(title as varchar(50)),
                           'Date issue: ',cast(NEW.Date_Issue as varchar(100)),
                           'Return date: ',cast(NEW.Return_Date as varchar(100))
                        ) from outfit where id_outfit = NEW.Outfit_ID),
            2);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_rental_outfit_delete AFTER DELETE
    ON rental_outfit
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete rental outfit; ',
                           ' title outfit: ',
                           cast(title as varchar(50)),
                           ' Date issue: ',cast(OLD.Date_Issue as varchar(100)),
                           ' Return date: ',cast(OLD.Return_Date as varchar(100))
                        ) from outfit where id_outfit = OLD.Outfit_ID),
            2);
END$$
DELIMITER ;


/*---------------------------------------------------------Status_Card-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_status_card_insert AFTER INSERT
    ON status_card
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert status card; status name: ',NEW.Title)),
            3);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_status_card_update AFTER UPDATE
    ON status_card
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update status card; status name: ',NEW.Title)),
            3);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_status_card_delete AFTER DELETE
    ON status_card
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete status card; status name: ',OLD.Title)),
            3);
END$$
DELIMITER ;


/*---------------------------------------------------------Bonus_Card-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_bonus_card_insert AFTER INSERT
    ON bonus_card
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert bonus card; ',
                           'Tariff card: ',
                           cast(NEW.Tariff as varchar(50)),
                           'Balance card: ',
                           cast(NEW.Balance as varchar(50)),
                           'Status name: ', cast(title as varchar(50))
                        ) from status_Card where id_status_card = NEW.Status_Card_ID),
            4);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_bonus_card_update AFTER UPDATE
    ON bonus_card
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update bonus card; ',
                           'Tariff card: ',
                           cast(NEW.Tariff as varchar(50)),
                           'Balance card: ',
                           cast(NEW.Balance as varchar(50)),
                           'Status name: ', cast(title as varchar(50))
                        ) from status_Card where id_status_card = NEW.Status_Card_ID),
            4);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_bonus_card_delete AFTER DELETE
    ON bonus_card
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete bonus card; ',
                           'Tariff card: ',
                           cast(OLD.Tariff as varchar(50)),
                           'Balance card: ',
                           cast(OLD.Balance as varchar(50)),
                           'Status name: ', cast(title as varchar(50))
                        ) from status_Card where id_status_card = OLD.Status_Card_ID),
            4);
END$$
DELIMITER ;


/*---------------------------------------------------------Position-----------------------------------------------------*/


DELIMITER $$
CREATE
    TRIGGER add_to_log_position_insert AFTER INSERT
    ON position
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat(
                            'insert position; position name: ',NEW.Title,
                            ' Post price: ',NEW.Post_Price,
                            ' Description price: ',NEW.Description,
                            ' Responsibilities price: ',NEW.Responsibilities)),
            5);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_position_update AFTER UPDATE
    ON position
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat(
                            'update position; position name: ',NEW.Title,
                            ' Post price: ',NEW.Post_Price,
                            ' Description price: ',NEW.Description,
                            ' Responsibilities price: ',NEW.Responsibilities)),
            5);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_position_delete AFTER DELETE
    ON position
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat(
                            'delete position; post name: ',OLD.Title,
                            ' Post price: ',OLD.Post_Price,
                            ' Description price: ',OLD.Description,
                            ' Responsibilities price: ',OLD.Responsibilities)),
            5);
END$$
DELIMITER ;

/*---------------------------------------------------------Employee-----------------------------------------------------*/

DELIMITER $$
CREATE
    TRIGGER add_to_log_employee_insert AFTER INSERT
    ON employee
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('INSERT',
            (select concat('insert employee; ',
                           concat(NEW.First_Name,' ',NEW.Second_Name,' ',NEW.Middle_Name),
                           'Status name: ', cast(title as varchar(50)),
                           concat('post name ',Title,', post price: ', cast(Post_Price as varchar(100)), 'post part: ', cast(NEW.Post_Part as varchar(100)))
                        ) from position where id_position = NEW.Position_ID),
            6);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_employee_update AFTER UPDATE
    ON employee
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('UPDATE',
            (select concat('update employee; ',
                           concat(NEW.First_Name,' ',NEW.Second_Name,' ',NEW.Middle_Name),
                           'Status name: ', cast(title as varchar(50)),
                           concat('post name ',Title,', post price: ', cast(Post_Price as varchar(100)), 'post part: ', cast(NEW.Post_Part as varchar(100)))
                        ) from position where id_position = NEW.Position_ID),
            6);
END$$
DELIMITER ;


DELIMITER $$
CREATE
    TRIGGER add_to_log_employee_delete AFTER DELETE
    ON employee
    FOR EACH ROW BEGIN
    INSERT INTO Trigger_History(Status_History, Log_Info, TableName_ID)
    values ('DELETE',
            (select concat('delete employee; ',
                           concat(OLD.First_Name,' ',OLD.Second_Name,' ',OLD.Middle_Name),
                         'Status name: ', cast(title as varchar(50)),
                           concat('post name ',Title,', post price: ', cast(Post_Price as varchar(100)), 'post part: ', cast(OLD.Post_Part as varchar(100)))
                        ) from position where id_position = OLD.Position_ID),
            6);
END$$
DELIMITER ;

/*---------------------------------------------------------Cableway-----------------------------------------------------*/



/*---------------------------------------------------------Track-----------------------------------------------------*/



/*---------------------------------------------------------Status_Card_Track-----------------------------------------------------*/


/*---------------------------------------------------------Client-----------------------------------------------------*/



/*---------------------------------------------------------Receipt-----------------------------------------------------*/
/*---------------------------------------------------------Rental_Outfit_Client-----------------------------------------------------*/
