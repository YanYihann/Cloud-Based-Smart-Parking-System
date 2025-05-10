# Cloud-Based Smart Parking System


## Overview

The **Smart Parking System (SPS)** is a web-based platform designed to solve urban parking challenges using real-time sensor data, license plate recognition, and QR code-based payment. It supports three user roles: **Member**, **Guest**, and **Admin**, with distinct workflows and functionalities. The project is designed using a comprehensive UML-based methodology and implemented in PHP and MySQL.

## Features          

- Member and guest registration and login
- Real-time parking spot tracking via IoT sensors
- QR code-based payment system
- License Plate Recognition (LPR) simulation
- Admin panel to manage users, spots, and bookings          
- Reservation management with placeholder devices
- Full support for role-based access control          

## Tech used

| Layer                | Technology                          |
|----------------------|--------------------------------------|
| Frontend             | HTML, CSS, JavaScript                |
| Backend              | PHP 8+                               |
| Database             | MySQL 8.x                            |
| Web Server           | Apache (WAMP / XAMPP or LAMP stack) |
| Diagrams & Modeling  | PlantUML, Visual Paradigm            |

## System Structure

- **Presentation Layer**: User interface using PHP and HTML forms          
- **Application Logic Layer**: Booking, payment, authentication logic in PHP
- **Persistence Layer**: MySQL relational database

## UML Diagrams

The system is modeled using 12 UML diagrams:

- Use Case Diagram
- Class Diagrams (Analysis & Design)
- Component Diagram
- Deployment Diagram
- Object Diagram
- Activity Diagrams (3)
- Sequence Diagrams (2)
- Communication Diagrams (2)
- State Machine Diagrams (2)
- Timing Diagram
- Composite Structure Diagram          

## Database

The system uses four primary tables:          

- **users**: Stores user information, credentials, and roles
- **bookings**: Records reservations and parking session data
- **payments**: Tracks payment status and amounts
- **parking_spots**: Maintains real-time parking spot status

### ER Relationships

- `users.username` → `bookings.username`, `payments.username` (1:N)
- `bookings.id` → `payments.booking_id` (1:1)
- `parking_spots.spot_id` → `bookings.spot_id`, `payments.spot_id` (1:N)

### Example

- User "yanyihan" reserved spot "U1-1" and paid via QR code.
- Guest users are identified by license plate and can pay without registration.
- Admins can monitor reservations, payments, and spot status.

## How to Deploy

1. Clone the repository:
```bash
git clone https://github.com/YanYihann/Cloud-Based-Smart-Parking-System
cd Database & php
```

2. Set up the database:
   - Open phpMyAdmin
   - Create a new database `CPS3962`
   - Import the provided `Cloud-Based-Smart-Parking-System.sql`

3. Configure DB in `config/db_connect.php`:
```php
$host = 'localhost';
$username = 'root';
$password = '';
$database = 'CPS3962';
```


4. Access the system:
[http://localhost/CPS3962](http://localhost/CPS3962)

## Directory Structure

```
Cloud-Based-Smart-Parking-System/
├── Database & php/
│   ├── assets/
│   ├── css/                  # Stylesheets
│   ├── images/               # UI and architecture images
│   ├── config/               # DB configuration (e.g., db_connect.php)
│   ├── database/             # SQL schema and sample data
│   ├── includes/             # Shared PHP scripts (session, helpers)
│   ├── pages/                # PHP pages (index.php, main.php, payment.php, etc.)
│   ├── index.php             # Application entry point
├── Diagrams/                 # UML Diagrams (Use Case, Class, Sequence, etc.)
└── README.md                 # Project description
```




