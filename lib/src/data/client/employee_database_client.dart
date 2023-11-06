import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/employee/employee_model.dart';

class EmployeeDatabaseClient {
  static final EmployeeDatabaseClient instance =
      EmployeeDatabaseClient._privateConstructor();
  static Database? _database;
  static Stack<EmployeeModel> _deletedEmployeesStack = Stack();
  EmployeeDatabaseClient._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<void> initDatabase() async {
    _database = await _initDatabase();
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'employee_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE employees(
        id INTEGER PRIMARY KEY,
        full_name TEXT,
        role TEXT,
        started TEXT,
        end TEXT
      )
    ''');
  }

  Future<int> insertEmployee(EmployeeModel employee) async {
    final db = await database;
    var res = await db.insert('employees', employee.toJson());
    log('insert data response $res');
    return res;
  }

  Future<List<EmployeeModel>> getAllEmployees() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('employees');
    return List.generate(maps.length, (i) {
      log('map ----> ${maps[i]}');
      return EmployeeModel.fromJson(maps[i]);
    });
  }

  Future<int> updateEmployee(EmployeeModel employee) async {
    final db = await database;
    return await db.update(
      'employees',
      employee.toJson(),
      where: 'id = ?',
      whereArgs: [employee.id],
    );
  }

  Future<int> deleteEmployee(int employeeId) async {
    final db = await database;
    final deletedEmployee = await getEmployeeById(employeeId);
    if (deletedEmployee != null) {
      _deletedEmployeesStack.push(deletedEmployee);
    }
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [employeeId],
    );
  }

  Future<int> undoDelete() async {
    if (_deletedEmployeesStack.isEmpty()) return 0;
    final db = await database;
    final restoredEmployee = _deletedEmployeesStack.pop();
    if (restoredEmployee != null) {
      return await db.insert('employees', restoredEmployee.toJson());
    }
    return 0;
  }

  Future<EmployeeModel?> getEmployeeById(int employeeId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'employees',
      where: 'id = ?',
      whereArgs: [employeeId],
    );
    if (maps.isNotEmpty) {
      return EmployeeModel.fromJson(maps.first);
    } else {
      return null;
    }
  }
}

class Stack<T> {
  final List<T> _list = [];

  void push(T item) {
    _list.add(item);
  }

  T? pop() {
    if (_list.isNotEmpty) {
      return _list.removeLast();
    }
    return null;
  }

  bool isEmpty() {
    return _list.isEmpty;
  }
}
