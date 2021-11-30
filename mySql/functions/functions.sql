
/*Задача1: Вывести информацию о заработанных, конкретным сотрудником денег, в зависимости от отработанных часов в месяц.*/
use test;
DELIMITER //
create or replace function Employee_Ammount(p_Employee_ID int, p_Worked_Hours decimal(38,2))
returns decimal(38,2)
begin
  declare count_money decimal(38,2);
select sum((Post_Part*Post_Price*0.87)*(p_Worked_Hours/160)) into count_money from combination
                                                                                       inner join post on ID_Post = Post_ID
where Employee_ID =p_Employee_ID;
return count_money;
end;


use test;
DELIMITER //
create or replace function employee_amount(p_id_employee int, p_worked_hours decimal (38,2))
    returns decimal (38,2)

begin
declare count_money decimal (38,2);

select sum((post_part*post_price*0.87)*(p_worked_hours/160)) into count_money into have_record from employee inner join position on id_position = position_id
where id_employee = p_id_employee;
return count_money;
end;



use test;
DELIMITER //
create  function rental_outfit_amount(p_id_rental_outfit int)
    returns int

begin
declare count_money int;

select sum ((date_part('hour', (return_date - date_issue))) * price) into count_money
from rental_outfit
where id_rental_outfit = p_id_rental_outfit;
return count_money;
end;



use test;
DELIMITER //
create  function cableway_amount(p_id_cableway int, p_number_of_rides int)
    returns int

begin
declare count_money int;

select sum(price * p_number_of_rides) into count_money
from cableway
where id_cableway = p_id_cableway;
return count_money;
end;




Process finished with exit code 0


