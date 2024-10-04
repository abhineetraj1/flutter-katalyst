# Katalyst

https://github.com/user-attachments/assets/0fbee4cd-89b5-441e-b046-e7af07f0bbc9


Katalyst is a dynamic platform for hosting workshops, allowing users to easily sign up and manage their own events. Users can create, modify, and cancel workshops, as well as book spots in other sessions.

## Features:
* User Registration and Login
* Create, edit, and delete workshops
* Access booking history, cancel booked workshop and view hosted workshops
* Update personal information—name, email, and password

# Installation

### Installation of Flutter

1. **Install Flutter:**
   - Visit the [Flutter installation page](https://flutter.dev/docs/get-started/install) and follow the instructions specific to your operating system (Windows, macOS, or Linux).
   - Make sure to add Flutter to your system's PATH.

2. **Verify Installation:**
   - Open a terminal or command prompt and run:
     ```bash
     flutter doctor
     ```
   - Follow any prompts to install missing dependencies.

### Installation of MongoDB

1. **Install MongoDB:**
   - Visit the [MongoDB installation page](https://docs.mongodb.com/manual/installation/) and choose your operating system.
   - Follow the instructions to download and install MongoDB.

2. **Start MongoDB:**
   - After installation, start the MongoDB server using the command:
     ```bash
     mongod
     ```
   - The default data directory is `/data/db`, so ensure that this directory exists, or you can specify a different one in your MongoDB configuration.

### Setting Up the Database

1. **Open MongoDB Shell:**
   - Open a new terminal and run:
     ```bash
     mongo
     ```

2. **Create the Database:**
   - In the MongoDB shell, run:
     ```javascript
     use katalyst
     ```

3. **Create Collections:**
   - Create the required collections:
     ```javascript
     db.createCollection("bookings")
     db.createCollection("events")
     db.createCollection("users")
     ```

### Upload Sample Data

1. **Import Sample Data:**
   - If you have a folder named `SampleDatabaseData` that contains JSON or BSON files, you can import them into your MongoDB database.
   - Use the following command in your terminal, adjusting the file paths as necessary:
     ```bash
     mongoimport --db katalyst --collection bookings --file /path/to/SampleDatabaseData/bookings.json --jsonArray
     mongoimport --db katalyst --collection events --file /path/to/SampleDatabaseData/events.json --jsonArray
     mongoimport --db katalyst --collection users --file /path/to/SampleDatabaseData/users.json --jsonArray
     ```
   - Make sure the JSON files are in the correct format for MongoDB.


<h3 align="left">Languages and Tools:</h3>
<p align="left"> <a href="https://dart.dev" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/dartlang/dartlang-icon.svg" alt="dart" width="40" height="40"/> </a> <a href="https://flutter.dev" target="_blank" rel="noreferrer"> <img src="https://www.vectorlogo.zone/logos/flutterio/flutterio-icon.svg" alt="flutter" width="40" height="40"/> </a> <a href="https://www.mongodb.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/mongodb/mongodb-original-wordmark.svg" alt="mongodb" width="40" height="40"/> </a> </p>

# Developer

*   [@abhineetraj1](https://github.com/abhineetraj1)
