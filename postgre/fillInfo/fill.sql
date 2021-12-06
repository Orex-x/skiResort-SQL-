TRUNCATE TABLE Outfit cascade;
TRUNCATE TABLE Rental_Outfit cascade;
TRUNCATE TABLE Status_Card cascade;
TRUNCATE TABLE Bonus_Card cascade;
TRUNCATE TABLE Position cascade;
TRUNCATE TABLE Employee cascade;
TRUNCATE TABLE Cableway cascade;
TRUNCATE TABLE Track cascade;
TRUNCATE TABLE Status_Card_Track cascade;
TRUNCATE TABLE Client cascade;
TRUNCATE TABLE Rental_Outfit_Client cascade;
TRUNCATE TABLE Receipt cascade;


call Outfit_Insert ('Лыжи');
call Outfit_Insert ('Лыжные палки');
call Outfit_Insert ('Ботинки');
call Outfit_Insert ('Сноуборд');
call Outfit_Insert ('Маска');
call Outfit_Insert ('Перчатки');
call Outfit_Insert ('Шлем');


call Rental_Outfit_Insert(500, '2021-03-12 12:00:00', '2021-03-12 14:00:00', 1);
call Rental_Outfit_Insert(400, '2021-03-12 12:00:00', '2021-03-12 14:00:00', 2);
call Rental_Outfit_Insert(300, '2021-03-12 12:00:00', '2021-03-12 14:00:00', 3);
call Rental_Outfit_Insert(200, '2021-03-12 12:00:00', '2021-03-12 14:00:00', 4);
call Rental_Outfit_Insert(400, '2021-03-12 12:00:00', '2021-03-12 14:00:00', 5);

call Status_Card_Insert('Copper');
call Status_Card_Insert('Silver');
call Status_Card_Insert('Gold');

call Bonus_Card_Insert(1000, 100, 1);
call Bonus_Card_Insert(3000, 872, 3);
call Bonus_Card_Insert(2000, 43, 1);
call Bonus_Card_Insert(2178, 23, 2);
call Bonus_Card_Insert(2159, 436, 1);


call Position_Insert('Бухгалтер', 100000, 'выполнение работ, направленных на сокращение ' ||
    'расходов на налоговые отчисления, сдача налоговой отчетности.'
    , 'Считать счета');
call Position_Insert('Менеджер', 150000,'Специалист по управлению производственными ' ||
    'или бизнес-процессами. Он решает различные задачи в области организации, производства, ' ||
    'сбыта, сервиса, и при этом самостоятельно занимается административно-хозяйственными вопросами',
    'Закупка оборудования, учет всего');
call Position_Insert('Кассир', 80000, 'Должностное лицо, непосредственно выполняющее кассовые операции',
    'Обслуживать клиентов, предлагать бонусную карту новым клиентам');
call Position_Insert('Дежурный по склону', 90000, 'Дежурный по склону', 'Следить за безопасностью клиентов');


call Employee_Insert('Иванов','Иван','Иванович','+7(916)365-43-21','i.ivanov@gmail.com',
    23, 432763859364, 212-325-123-54, 1, 1);

call Employee_Insert('Зыков','Арсен','Лукьевич','+7(916)667-12-21','z.arsen@gmail.com',
    45, 273648732643, 332-654-233-12, 1, 2);

call Employee_Insert('Коновалов','Герасим','Аристархович','+7(916)287-23-33','k.lerasin@gmail.com',
    21, 430950943598, 240-234-544-23, 0.5, 3);

call Employee_Insert('Дьячков','Митрофан','Степанович','+7(916)667-12-21','z.arsen@gmail.com',
    19, 273648732643, 332-654-233-12, 0.5, 3);

call Employee_Insert('Коновалов','Герасим','Аристархович','+7(916)236-55-33','k.lerasin@gmail.com',
    28, 234043765863, 398-234-234-43, 1, 4);

call Employee_Insert('Дьячков','Митрофан','Степанович','+7(916)234-54-34','z.arsen@gmail.com',
    31, 394859384723, 845-234-235-32, 1, 4);

