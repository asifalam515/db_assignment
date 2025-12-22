## 📋 Overview

A comprehensive database design and SQL implementation for a Vehicle Rental System that manages users, vehicles, and bookings with proper relationships and business logic constraints.

## 🎯 Objectives

- Design an Entity Relationship Diagram (ERD) with 1:1, 1:Many, and Many:1 relationships
- Implement proper primary keys and foreign keys
- Write complex SQL queries using JOIN, EXISTS, and WHERE clauses
- Handle real-world vehicle rental business scenarios

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
