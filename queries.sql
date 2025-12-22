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
  inner join users u on b.user_id = u.id
  inner join vehicles v on b.vehicle_id = v.vehicle_id



--   Query 2: EXISTS
select * from vehicles v where not exists (SELECT *
    FROM bookings b
    WHERE b.vehicle_id = v.vehicle_id)

-- Query 3: WHERE
select * from vehicles v where status='available'

-- Query 4: GROUP BY and HAVING
select
  v.vehicle_id,
  v.name AS vehicle_name,
  count(b.booking_id) as total_bookings
from
  vehicles v
  join bookings b on v.vehicle_id = b.vehicle_id
group by
  v.vehicle_id,
  v.name
having
  COUNT(b.booking_id) > 2;