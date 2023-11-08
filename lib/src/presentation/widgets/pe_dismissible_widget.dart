import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ninjacoder/src/shared/shared.dart';

import '../../data/model/employee/employee_model.dart';
import 'confirm_dismiss_dialog.dart';

class PeDismissibleWidget extends StatefulWidget {
  const PeDismissibleWidget({
    super.key,
    required this.c,
    required this.data,
    required this.showDivider,
  });
  final BuildContext? c;
  final EmployeeModel data;
  final bool showDivider;

  @override
  State<PeDismissibleWidget> createState() => _PeDismissibleWidgetState();
}

class _PeDismissibleWidgetState extends State<PeDismissibleWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) => showConfirmDismissDialog(
        direction,
        widget.c ?? context,
        widget.data.id ?? -1,
      ),
      onUpdate: (DismissUpdateDetails progress) {
        log('progress ${progress.progress}');
      },
      onDismissed: (direction) {},
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        child: const Padding(
          padding: EdgeInsets.only(right: 20.0),
          child: Icon(
            Icons.delete_outline,
            color: Colors.white,
          ),
        ),
      ),
      child: SizedBox(
        width: context.screenWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.data.fullName ?? '',
                style: const TextStyle(
                  color: Color(0xFF323238),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                widget.data.role ?? '',
                style: const TextStyle(
                  color: Color(0xFF949C9E),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "${widget.data.started ?? ''} - ${widget.data.end ?? ''}",
                style: const TextStyle(
                  color: Color(0xFF949C9E),
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(height: 10),
            if (widget.showDivider)
              Divider(
                color: Colors.grey.withOpacity(.15),
                thickness: 1,
                height: 0,
              )
          ],
        ),
      ),
    );
  }
}
