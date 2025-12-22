# db_assignment

## this is project is about postgresql.

Vehicle Rental System - Database & SQL Project
📋 Overview
A comprehensive database design and SQL implementation for a Vehicle Rental System that manages users, vehicles, and bookings with proper relationships and business logic constraints.

Objectives
Design an Entity Relationship Diagram (ERD) with 1:1, 1:Many, and Many:1 relationships

Implement proper primary keys and foreign keys

Write complex SQL queries using JOIN, EXISTS, and WHERE clauses

Handle real-world vehicle rental business scenarios

Database Design
Users Table
Stores user information with role-based access control:

Primary Key: user_id (Auto-increment)

Required Fields:

role (ENUM: 'Admin', 'Customer')

name (VARCHAR)

email (VARCHAR, UNIQUE constraint)

password (VARCHAR, hashed in production)

phone_number (VARCHAR)

Business Logic:

Email addresses must be unique (no duplicate accounts)

Role determines system access level

Vehicles Table
Manages rental vehicle inventory:

Primary Key: vehicle_id (Auto-increment)

Required Fields:

vehicle_name (VARCHAR)

type (ENUM: 'car', 'bike', 'truck')

model (VARCHAR)

registration_number (VARCHAR, UNIQUE constraint)

rental_price_per_day (DECIMAL)

availability_status (ENUM: 'available', 'rented', 'maintenance')

Business Logic:

Registration numbers must be unique

Real-time availability tracking

Bookings Table
Tracks all rental transactions:

Primary Key: booking_id (Auto-increment)

Foreign Keys:

user_id (references Users.user_id)

vehicle_id (references Vehicles.vehicle_id)

Required Fields:

start_date (DATE)

end_date (DATE)

booking_status (ENUM: 'pending', 'confirmed', 'completed', 'cancelled')

total_cost (DECIMAL, calculated)

Business Logic:

Links users to their booked vehicles

Tracks booking lifecycle from creation to completion

🔗 Entity Relationships
Users → Bookings (1:Many)

One user can make multiple bookings

Each booking belongs to exactly one user

Vehicles → Bookings (1:Many)

One vehicle can have multiple bookings over time

Each booking is for exactly one vehicle

Bookings → Users/Vehicles (Many:1)

Many bookings can reference a single user

Many bookings can reference a single vehicle
