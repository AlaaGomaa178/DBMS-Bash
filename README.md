# DBMS-Bash

Welcome to DBMS-Bash, a powerful database management system implemented entirely in Bash scripting language. This README provides an in-depth guide to understanding, installing, and using the DBMS-Bash project. We'll cover its features, architecture, project structure, installation instructions, usage guide, scripts overview, contribution guidelines, and licensing information.


## Table of Contents
1. [Introduction](#introduction)
2. [Features](#features)
3. [Project Structure](#project-structure)
4. [Installation](#installation)
5. [Usage](#usage)
6. [Scripts Overview](#scripts-overview)
7. [Contributing](#contributing)
8. [License](#license)

## Introduction
DBMS-Bash is a lightweight yet robust database management system designed entirely in Bash scripting language. It offers essential functionalities for managing databases, creating and modifying tables, and performing data operations such as insertion, selection, update, and deletion. The project aims to provide a user-friendly and portable solution for handling data management tasks directly from the terminal, making it suitable for small to medium-scale projects and educational purposes.

## Features
### Database Management
- **Create Databases:** Users can create new databases with custom names to organize their data efficiently. Each database is a separate entity containing its tables and data.
- **List Databases:** DBMS-Bash provides a command to list all existing databases, allowing users to view and select the desired database for further operations.
- **Drop Databases:** This feature enables users to delete entire databases, including all associated tables and data, ensuring a clean and organized database environment.

### Table Management
- **Create Tables:** Within each database, users can create tables with custom column names, data types, and primary keys. Tables define the structure of data storage, facilitating organized data management.
- **List Tables:** DBMS-Bash allows users to list all tables within a selected database. This functionality aids in navigating and selecting specific tables for data operations.
- **Drop Tables:** Users can drop (delete) tables from databases when they are no longer needed, providing flexibility in managing data structure and organization.

### Data Operations
- **Insert Data:** DBMS-Bash supports inserting data into tables with validations and constraints. Users can add rows of data while ensuring data type integrity and adherence to primary key constraints.
- **Select Data:** This feature enables users to retrieve data from tables based on various criteria, including selecting all rows, specifying conditions for data selection, or choosing specific columns to display.
- **Update Data:** Users can modify existing data in tables based on specified conditions. This functionality is crucial for updating records and maintaining data accuracy.
- **Delete Data:** DBMS-Bash allows users to delete rows from tables individually or based on specific conditions. This capability helps in data cleanup and maintaining data consistency.

### User Interaction
- **Interactive CLI:** DBMS-Bash provides an interactive command-line interface (CLI) with intuitive menus and prompts. Users can navigate through options and perform operations seamlessly.
- **Input Validation:** The system validates user inputs to ensure data integrity and prevent errors during operations. It checks input formats, data types, and primary key uniqueness, providing a robust user experience.
- **Error Handling:** DBMS-Bash includes robust error handling mechanisms to detect and notify users of any issues or incorrect inputs. Detailed error messages guide users to rectify errors and ensure smooth execution of commands.

## Project Structure
The DBMS-Bash project follows a structured organization to maintain clarity and modularity. Here's an expanded overview of the project structure:

1. **DBMS_Bash.sh:** The main script serving as the entry point to the DBMS-Bash CLI. It orchestrates user interactions and menu navigation.
   
2. **Database Management:**
   - **createDatabase.sh:** Creates a new database within the system.
   - **listDatabases.sh:** Lists all existing databases for user selection.
   - **dropDatabase.sh:** Deletes a specified database and all its associated tables and data.

3. **Table Management:**
   - **tablesMenu.sh:** The main menu for interacting with tables, providing options to create, list, and drop tables.
   - **createTable.sh:** Creates a new table within the selected database, defining its structure.
   - **listTables.sh:** Lists all tables within the selected database for user reference.
   - **dropTable.sh:** Drops (deletes) a specified table from the selected database.

4. **Data Operations:**
   - **insertIntoTables.sh:** Inserts data into tables with validations, ensuring data integrity.
   - **selectFromTables.sh:** Retrieves data from tables based on user-defined criteria, including conditions and column selection.
   - **updateTable.sh:** Updates existing data in tables based on specified conditions.
   - **deleteFromTable.sh:** Deletes rows from tables based on conditions, facilitating data cleanup.

5. **Documentation:**
   - **README.md:** The project's main documentation file providing an overview, installation instructions, usage guide, and contribution guidelines.
   - **LICENSE:** Contains the project's licensing information (e.g., MIT License) for users and contributors.

## Installation
To install and run DBMS-Bash on your system, follow these steps:
1. Clone the repository to your local machine using Git:
   ```bash
   git clone https://github.com/AlaaGomaa178/DBMS-Bash.git
   ```
2. Navigate to the project directory:
   ```bash
   cd DBMS-Bash
   ```
3. Ensure that all Bash scripts have executable permissions:
   ```bash
   chmod +x *.sh
   ```

## Usage
1. Run the main script to start the DBMS-Bash CLI:
   ```bash
   ./DBMS_Bash.sh
   ```
2. Follow the on-screen instructions and menu options to perform various database and table operations.
3. Enter the required information such as database names, table details, data to insert, conditions for selection or deletion, etc., as prompted by the scripts.

## Scripts Overview
### Main Scripts
- **DBMS_Bash.sh:** Entry point script to start the DBMS-Bash CLI.
- **createDatabase.sh:** Creates a new database.
- **listDatabases.sh:** Lists all existing databases.
- **dropDatabase.sh:** Deletes a database.
- **tablesMenu.sh:** Main menu for table-related operations.

### Table Operations
- **createTable.sh:** Creates a new table within the selected database.
- **listTables.sh:** Lists all tables within the selected database.
- **dropTable.sh:** Drops (deletes) a table from the selected database.
- **insertIntoTables.sh:** Inserts data into tables.
- **selectFromTables.sh:** Selects data from tables based on criteria.
- **updateTable.sh:** Updates data in tables based on conditions.
- **deleteFromTable.sh:** Deletes rows from tables based on conditions.

## Contributing
Contributions to DBMS-Bash are highly appreciated! If you have suggestions, improvements, bug fixes, or new features to add, please follow these guidelines:
1. Fork the repository and create a new branch for your feature or bug fix.
2. Make your changes and ensure they follow the project's coding style and conventions.
3. Test your changes thoroughly.
4. Commit your changes with clear and descriptive commit messages.
5. Push your changes to your fork and submit a pull request to the main repository.

## License
DBMS-Bash is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---
Thank you for using DBMS-Bash! We hope this README provides comprehensive information to help you understand, install, and use the project effectively. If you have any questions or feedback, please don't hesitate to reach out or open an issue on GitHub. Happy scripting!
