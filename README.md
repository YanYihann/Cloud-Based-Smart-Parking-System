# Cloud-Based-Smart-Parking-System

## Overview

The **Smart Parking System (SPS)** is a web-based, sensor-integrated parking management platform designed to solve urban parking challenges. It integrates IoT, license plate recognition, and QR code payment technologies to streamline parking operations for members, guests, and administrators.

The system was designed and implemented using UML-driven methodology and includes comprehensive static and behavioral diagrams to support software architecture and maintainability.

## Features

- **User Roles**: Member, Guest, Admin
- **Reservation System**: Book and modify parking spot reservations
- **Real-Time Monitoring**: Parking spot status via IoT sensors
- **License Plate Recognition (LPR)**: Automated access control
- **QR Code Payments**: Instant and secure payment method
- **Admin Panel**: Manage users, spots, bookings, and pricing

## Tech Stack

| Layer                | Technology                          |
|----------------------|--------------------------------------|
| Frontend             | HTML, CSS, JavaScript                |
| Backend              | PHP 8+                               |
| Database             | MySQL 8.x                            |
| Web Server           | Apache (WAMP / XAMPP or LAMP stack) |
| Diagrams & Modeling  | PlantUML, Visual Paradigm            |

## System Architecture

The project adopts a **three-tier architecture**:
- **Presentation Layer**: User interfaces for web interaction
- **Application Logic Layer**: Booking, payment, sensor services
- **Persistence Layer**: MySQL database with normalized schema

## UML Coverage

This system is fully modeled with **12 UML diagrams**:

- **Use Case Diagram**  
- **Class Diagrams (Analysis + Design)**  
- **Component Diagram**  
- **Package Diagram**  
- **Deployment Diagram**  
- **Object Diagram**  
- **Activity Diagrams** (Reservation, Payment, Reserved Spot)  
- **Sequence Diagrams** (Reservation, Payment)  
- **Communication Diagrams** (Reservation, Payment)  
- **State Machine Diagrams** (Booking, ParkingSpot)  
- **Timing Diagram**  
- **Composite Structure Diagram**

All diagrams are available in `/Diagrams/`.

## Database Design

The database includes 4 main tables:

- **users**: Username, password hash, contact info, role, plate number
- **bookings**: Spot ID, entry/exit time, status, linked to user
- **payments**: Linked to booking or license plate, timestamp, amount
- **parking_spots**: Spot ID, area (e.g., Underground or Overground), floor, status

Refer to `/database/schema.sql` for full SQL schema.

### ER Relationships

- `users.username` → `bookings.username`, `payments.username` (1:N)
- `bookings.id` → `payments.booking_id` (1:1)
- `parking_spots.spot_id` → `bookings.spot_id`, `payments.spot_id` (1:N)

## Installation & Deployment

### Local Setup

1. **Clone repository**:
   ```bash
   git clone https://github.com/yourname/smart-parking-system.git
   cd smart-parking-system

