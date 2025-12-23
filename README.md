## 📋 Overview

A comprehensive database design and SQL implementation for a Vehicle Rental System that manages users, vehicles, and bookings with proper relationships and business logic constraints.

## 🎯 Objectives

- Design an Entity Relationship Diagram (ERD) with 1:1, 1:Many, and Many:1 relationships
- Implement proper primary keys and foreign keys
- Write complex SQL queries using JOIN, EXISTS, and WHERE clauses
- Handle real-world vehicle rental business scenarios

## Query Explanation

### Query 1: JOIN

```select
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
```

we have joined(inner) bookings,users and vehicles table on condition the selected our desire column name and value

### Query 2:EXISTS

````select * from vehicles v where not exists (SELECT *
    from bookings b
    where b.vehicle_id = v.vehicle_id)```

sub query will find those vehicle that were booked ever.and main query will exlude those.so that it will find out vehicles that have never been booked.

### Query 3:WHERE
```select *
from vehicles
where status = 'available'
  and type = 'car'```


it will run condition by where on status and type.then select everything

### Query 4:GROUP BY and HAVING

```select
  v.name as vehicle_name,
  count(b.booking_id) as total_bookings
from
  vehicles v
  join bookings b on v.vehicle_id = b.vehicle_id
group by
  v.vehicle_id,
  v.name
having
  count(b.booking_id) > 2;```

we will join vehicle and and booking .then group by vehicle id,vehicle name.count the booking number and mark as totalBooking.then apply codition by having keyword

## 🏗️ Database Design

### **Users Table**

Stores user information with role-based access control:

| Column         | Type                      | Constraint       | Description                         |
| -------------- | ------------------------- | ---------------- | ----------------------------------- |
| `user_id`      | SERIAL                    | PRIMARY KEY      | Auto-incrementing unique identifier |
| `role`         | ENUM('Admin', 'Customer') | NOT NULL         | User role in system                 |
| `name`         | VARCHAR(100)              | NOT NULL         | Full name of user                   |
| `email`        | VARCHAR(100)              | UNIQUE, NOT NULL | Email address (must be unique)      |
| `password`     | VARCHAR(255)              | NOT NULL         | Hashed password                     |
| `phone_number` | VARCHAR(20)               | NOT NULL         | Contact phone number                |

**Business Logic:**

- Email addresses must be unique (no duplicate accounts)
- Role determines system access level

### **Vehicles Table**

Manages rental vehicle inventory:

| Column                 | Type                                       | Constraint          | Description                         |
| ---------------------- | ------------------------------------------ | ------------------- | ----------------------------------- |
| `vehicle_id`           | SERIAL                                     | PRIMARY KEY         | Auto-incrementing unique identifier |
| `vehicle_name`         | VARCHAR(100)                               | NOT NULL            | Name/description of vehicle         |
| `type`                 | ENUM('car', 'bike', 'truck')               | NOT NULL            | Type of vehicle                     |
| `model`                | VARCHAR(50)                                | NOT NULL            | Model/year of vehicle               |
| `registration_number`  | VARCHAR(20)                                | UNIQUE, NOT NULL    | Vehicle registration number         |
| `rental_price_per_day` | DECIMAL(10,2)                              | NOT NULL            | Daily rental price                  |
| `availability_status`  | ENUM('available', 'rented', 'maintenance') | DEFAULT 'available' | Current availability status         |

**Business Logic:**

- Registration numbers must be unique
- Real-time availability tracking

### **Bookings Table**

Tracks all rental transactions:

| Column           | Type                                                   | Constraint        | Description                         |
| ---------------- | ------------------------------------------------------ | ----------------- | ----------------------------------- |
| `booking_id`     | SERIAL                                                 | PRIMARY KEY       | Auto-incrementing unique identifier |
| `user_id`        | INTEGER                                                | FOREIGN KEY       | References Users.user_id            |
| `vehicle_id`     | INTEGER                                                | FOREIGN KEY       | References Vehicles.vehicle_id      |
| `start_date`     | DATE                                                   | NOT NULL          | Rental start date                   |
| `end_date`       | DATE                                                   | NOT NULL          | Rental end date                     |
| `booking_status` | ENUM('pending', 'confirmed', 'completed', 'cancelled') | DEFAULT 'pending' | Current booking status              |
| `total_cost`     | DECIMAL(10,2)                                          | NOT NULL          | Calculated total cost               |

**Business Logic:**

- Links users to their booked vehicles
- Tracks booking lifecycle from creation to completion
- Total cost calculated based on rental duration and daily rate
````
