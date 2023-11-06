import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../screens/cubit/employee_cubit.dart';

class MxBlankAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MxBlankAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 30,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(0);
}

class MxAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MxAppBar({
    Key? key,
    this.title,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.elevation,
    this.centerTitle,
  }) : super(key: key);

  final Widget? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final double? elevation;
  final bool? centerTitle;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? Colors.blue,
      elevation: elevation ?? 0,
      leadingWidth: 35,
      titleSpacing: 0,
      title: title,
      centerTitle: centerTitle,
      leading: leading ??
          IconButton(
            onPressed: () {
              context.read<EmployeeCubit>().getAllEmployee();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 16,
            ),
          ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
