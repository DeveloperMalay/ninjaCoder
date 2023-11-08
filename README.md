# Employee Management App

**Employee Management App** is a Flutter application for managing employee data. It allows users to add, edit, and delete employee records. The app uses BLoC/Cubit for state management and persists data using a local database. Additionally, it includes a date picker that is designed to look and work as expected.

## Table of Contents

- [Features](#features)
- [State Management](#state-management)
- [Database](#database)
- [Date Picker](#date-picker)


## Features

- Add new employee records with details such as name, role, started date, and ending date information.
- Edit existing employee records to update their information.
- Delete employee records from the database.
- BLoC/Cubit state management for managing application state.
- Local database for persisting employee data.
- Customized date picker that adheres to the design requirements.

# State Management
The application uses the BLoC/Cubit pattern for state management. State management logic can be found in the lib/bloc directory. You can customize and extend this logic as needed.

# Database
The app uses a local database to persist employee data. The database setup can be found in the lib/data directory. You can configure the database settings to meet your requirements. I am using SQLite to make the local database.

# Date Picker
The date picker component has been customized to match the design requirements. It allows users to select dates for employee records. The code for the date picker can be found in the lib/widgets directory I am using the table_calendar package for creating this feature.


# Project Demo Video



https://github.com/DeveloperMalay/ninjaCoder/assets/94185006/747cf2d3-38b7-4ee5-a9e8-22e357725fae



https://github.com/DeveloperMalay/ninjaCoder/assets/94185006/868754a9-4c41-49e9-9fca-08c1707956bc







