import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/cubit/employee_cubit.dart';

Future<bool?> showConfirmDismissDialog(
    DismissDirection direction, BuildContext context, int id) async {
  return await showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Confirm Delete'),
        content:
            const Text('Are you sure you want to delete this employee data?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop(false);
            },
          ),
          TextButton(
            child: const Text('Delete'),
            onPressed: () {
              context.read<EmployeeCubit>().deleteData(id).then((value) {
                if (value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.black,
                      content: const Text(
                        'Employee data has been deleted',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      action: SnackBarAction(
                          label: 'Undo',
                          textColor: Colors.blue,
                          onPressed: () {
                            try {
                              context.read<EmployeeCubit>().undoDelete();
                            } catch (e) {
                              log('error $e');
                            }
                          }),
                    ),
                  );
                  context.read<EmployeeCubit>().getAllEmployee();
                  Navigator.of(context).pop(true);
                }
              });
            },
          ),
        ],
      );
    },
  );
}
