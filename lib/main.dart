import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjacoder/src/data/client/employee_database_client.dart';
import 'package:ninjacoder/src/presentation/screens/cubit/employee_cubit.dart';

import 'src/presentation/screens/employee_list_screen.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter bindings are initialized.

  // Initialize the database
  final dbHelper = EmployeeDatabaseClient.instance;
  await dbHelper.initDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmployeeCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: false,
        ),
        home: const EmployeeListScreen(),
      ),
    );
  }
}
