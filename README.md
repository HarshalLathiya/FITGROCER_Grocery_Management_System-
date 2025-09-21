# FITGROCER Grocery Management System

A comprehensive grocery management system built with Node.js and MySQL for managing products, users, orders, and nutritional information.

## Features

- User authentication and authorization (Admin/Customer roles)
- Product catalog management with categories (Fruits, Vegetables, Dairy)
- Shopping cart functionality
- Order management system
- Nutritional information tracking
- User profile and address management

## Prerequisites

- Node.js (v14 or higher)
- Docker and Docker Compose
- npm or yarn package manager

## Installation

### 1. Clone the repository

```bash
git clone <repository-url>
cd FITGROCER_Grocery_Management_System-
```

### 2. Install dependencies

```bash
npm install
```

### 3. Environment setup

Copy the environment example file and configure your settings:

```bash
cp .env.example .env
```

Edit the `.env` file with your configuration:

```
PORT=3000
SECRATE_KEY=your_secret_key_here

DB_HOST=localhost
DB_USER=fitgrocer
DB_PASSWORD=fitgrocer123
DB_NAME=fitgrocer
```

### 4. Database setup

Start the MySQL database using Docker Compose:

```bash
docker-compose up -d
```

Import the database schema and sample data:

```bash
docker exec -i fitgrocer_mysql mysql -u fitgrocer -pfitgrocer123 fitgrocer < fitgrocer.sql
```

Verify the database connection:

```bash
docker exec fitgrocer_mysql mysql -u fitgrocer -pfitgrocer123 fitgrocer -e "SHOW TABLES;"
```

## Running the application

### Development mode

```bash
npm run dev
```

### Production mode

```bash
npm start
```

The application will be available at `http://localhost:3000`

## Database Schema

The system includes the following tables:

- **users**: User accounts with authentication
- **products**: Product catalog with pricing and categories
- **cart**: Shopping cart items
- **order**: Order history and details
- **nutritions**: Nutritional information for products
- **user_details**: User shipping addresses

## Default Users

The database comes with pre-configured users:

- **Admin**: harshalplathiya@gmail.com
- **Customer**: mihirlathiya@gmail.com

Note: Passwords are encrypted using bcrypt. Use the registration feature to create new accounts.

## API Endpoints

The application provides RESTful APIs for:

- User authentication
- Product management
- Cart operations
- Order processing
- User profile management

## Technology Stack

- **Backend**: Node.js, Express.js
- **Database**: MySQL 8.0
- **Authentication**: JWT, bcrypt
- **Template Engine**: EJS
- **Environment**: Docker (MySQL only)

## Development

The application uses the following npm scripts:

- `npm start`: Run the application in production mode
- `npm run dev`: Run the application in development mode with nodemon

## Database Management

To stop the database:

```bash
docker compose down
```

To reset the database (removes all data):

```bash
docker compose down -v
docker compose up -d
```

Then re-import the SQL file as shown in the setup steps.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is for educational purposes.