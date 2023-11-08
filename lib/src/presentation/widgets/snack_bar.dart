import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/cubit/employee_cubit.dart';

void showSnackbarWithUndoButton() {
  BotToast.showText(
    text: 'Employee data has been deleted',
    contentColor: Colors.white,
    backgroundColor: Colors.black,
    contentPadding: const EdgeInsets.all(16),
    duration: const Duration(seconds: 4),
    clickClose: true,
    backButtonBehavior: BackButtonBehavior.ignore,
    crossPage: true,
  );
}

Widget customSnackBar(BuildContext context) {
  Timer(const Duration(seconds: 3), () {
    Navigator.pop(context);
  });
  return Container(
    decoration: const BoxDecoration(color: Colors.black),
    child: Row(
      children: [
        const Text(
          'Employee data has been deleted',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        TextButton(
          onPressed: () {
            context.read<EmployeeCubit>().undoDelete();
          },
          child: const Text(
            'Undo',
            style: TextStyle(
              color: Colors.blue,
            ),
          ),
        )
      ],
    ),
  );
}
