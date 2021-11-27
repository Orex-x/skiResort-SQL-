
create or replace function Employee_Amount(p_ID_Employee int, p_Worked_Hours decimal (38,2))
    returns decimal (38,2)
    language plpgsql
as $$
declare count_money decimal (38,2);
begin
    select sum((Post_Part*Post_Price*0.87)*(p_Worked_Hours/160)) into count_money from Employee inner join Position on ID_Position = Position_ID
    where ID_Employee = p_ID_Employee;
    return count_money;
end;
$$;


create or replace function Rental_Outfit_Amount(p_ID_Rental_Outfit int)
    returns int
    language plpgsql
as $$
declare count_money int;
begin
    select sum ((date_part('hour', (Return_Date - Date_Issue))) * Price) into count_money
    from Rental_Outfit
    where ID_Rental_Outfit = p_ID_Rental_Outfit;
    return count_money;
end;
$$;


create or replace function Cableway_Amount(p_ID_Cableway int, p_number_of_rides int)
    returns int
    language plpgsql
as $$
declare count_money int;
begin
    select sum(Price * p_number_of_rides) into count_money
    from Cableway
    where ID_Cableway = p_ID_Cableway;
    return count_money;
end;
$$;

