-- query 1: JOIN
select
  b.booking_id,
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
from
  bookings b
  inner join users u on b.user_id = u.user_id
  inner join vehicles v on b.vehicle_id = v.vehicle_id



--   Query 2: EXISTS
select * from vehicles v where not exists (SELECT *
    from bookings b
    where b.vehicle_id = v.vehicle_id)



-- Query 3: WHERE
select *
from vehicles
where status = 'available'
  and type = 'car'



-- Query 4: GROUP BY and HAVING
select
  v.name as vehicle_name,
  count(b.booking_id) as total_bookings
from
  vehicles v
  join bookings b on v.vehicle_id = b.vehicle_id
group by
  v.vehicle_id,
  v.name
having
  count(b.booking_id) > 2;