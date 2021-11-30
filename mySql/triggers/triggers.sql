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

