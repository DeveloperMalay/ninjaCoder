import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/employee/employee_model.dart';

class EmployeeDatabaseClient {
  static final EmployeeDatabaseClient instance =
      EmployeeDatabaseClient._privateConstructor();
  static Database? _database;

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
    return await db.delete(
      'employees',
      where: 'id = ?',
      whereArgs: [employeeId],
    );
  }
}
