
--Outfit
call Outfit_Insert ('Лыжи');
call Outfit_Insert ('Лыжи'); --проверка поля на unique
call Outfit_Insert ('Ботинки');
call Outfit_Insert ('Ботинки2');
call Outfit_Update (3, 'Лыжные палки'); -- изменим название
call Outfit_Insert ('Ботинки2');
call Outfit_Delete (4);
select * from Outfit;

--Rental_Outfit

call Rental_Outfit_Insert(300, '2021-03-12 12:00:00', '2021-03-12 14:00:00', 1);
call Rental_Outfit_Insert(400, '2021-03-12 12:00:00', '2021-03-12 14:00:00', 2);
call Rental_Outfit_Update(
    2,500, '2021-03-12 12:00:00', '2021-03-12 14:00:00', 2);
call Rental_Outfit_Delete(2);
select * from Rental_Outfit;

--Status_Card

call Status_Card_Insert('gold');
call Status_Card_Insert('silver');
call Status_Card_Insert('ultra copper');
call Status_Card_Update(3, 'copper');
call Status_Card_Delete(3);
select * from Status_Card;

--Bonus_Card





