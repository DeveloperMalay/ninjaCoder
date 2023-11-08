import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ninjacoder/src/data/model/employee/employee_model.dart';
import 'package:ninjacoder/src/presentation/base/base_state_wrapper.dart';
import 'package:ninjacoder/src/presentation/screens/cubit/employee_cubit.dart';
import 'package:ninjacoder/src/presentation/widgets/end_calender_dialog.dart';
import 'package:ninjacoder/src/presentation/widgets/start_calender_dialog.dart';
import 'package:ninjacoder/src/presentation/widgets/mx_appbar.dart';
import 'package:ninjacoder/src/shared/extension/string_ext.dart';
import 'package:ninjacoder/src/shared/shared.dart';

class UpdateEmployeeDetailsScreen extends StatefulWidget {
  const UpdateEmployeeDetailsScreen({
    super.key,
    required this.model,
    required this.id,
  });
  final EmployeeModel model;
  final int id;
  @override
  State<UpdateEmployeeDetailsScreen> createState() =>
      _UpdateEmployeeDetailsScreenState();
}

class _UpdateEmployeeDetailsScreenState
    extends BaseStateWrapper<UpdateEmployeeDetailsScreen> {
  late TextEditingController _controller;
  @override
  void onInit() {
    _controller = TextEditingController(text: widget.model.fullName);

    context.read<EmployeeCubit>().getInitialState();
  }

  @override
  Widget onBuild(
      BuildContext context, BoxConstraints constraints, PlatformType platform) {
    context.read<EmployeeCubit>().selectRole(widget.model.role ?? '');
    context
        .read<EmployeeCubit>()
        .selectStartDate(widget.model.started.toString().toDate());
    log(widget.model.end.toString());
    if (widget.model.end.toString() != "No date") {
      context
          .read<EmployeeCubit>()
          .selectEndDate(widget.model.end.toString().toDate());
    }
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        if (state.status == EmployeeStatus.LOADING) {
          showLoading();
        } else {
          hideLoading();
        }
      },
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            context.read<EmployeeCubit>().getAllEmployee();
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: const MxAppBar(
              title: Text('Update Employee Details'),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      prefixIcon: const Icon(
                        Icons.person_outlined,
                        color: Colors.blue,
                      ),
                      hintText: 'Employee name',
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                        ),
                        builder: (context) {
                          return bottomSheetWidget();
                        },
                      );
                    },
                    child: Container(
                      height: 45,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey)),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.work_outline,
                            color: Colors.blue,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            state.role == '' ? widget.model.role! : state.role,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.blue,
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 23),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const StartCalenderDialog();
                              });
                        },
                        child: Container(
                          width: context.screenWidth * .4,
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.event,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                state.startDate
                                            .toString()
                                            .formatToCustomDate() ==
                                        DateTime.now()
                                            .toString()
                                            .formatToCustomDate()
                                    ? "Today"
                                    : state.startDate
                                        .toString()
                                        .formatToCustomDate(),
                                style: const TextStyle(
                                  color: Color(0xFF323238),
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward,
                        size: 20,
                        color: Colors.blue,
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return const EndCalenderDialog();
                              });
                        },
                        child: Container(
                          width: context.screenWidth * .4,
                          padding: const EdgeInsets.only(
                            left: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.grey)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.event,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 10),
                              Text(
                                state.endDate == DateTime(0)
                                    ? 'No date'
                                    : state.endDate
                                        .toString()
                                        .formatToCustomDate(),
                                style: TextStyle(
                                  color: state.endDate == DateTime(0)
                                      ? Colors.grey
                                      : Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            bottomSheet: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Divider(
                    height: 0,
                    thickness: 1,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFFEDF8FF),
                          ),
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                              color: Color(0xFF1DA1F2),
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: () {
                          var show = state.endDate.isAfter(state.startDate);

                          if (_controller.text.isEmpty) {
                            BotToast.showText(text: 'Please enter your name');
                          } else if (state.role == '') {
                            BotToast.showText(text: 'Please select your role');
                          } else if (state.endDate
                                      .toString()
                                      .formatToCustomDate() !=
                                  '1 Jan 0' &&
                              !show) {
                            BotToast.showText(
                                text: 'Start date cannot be after end date.');
                          } else if (_controller.text.isNotEmpty &&
                              state.role != '' &&
                              state.startDate.toString().isNotEmpty) {
                            var model = EmployeeModel(
                              id: widget.id,
                              fullName: _controller.text,
                              role: state.role == ''
                                  ? widget.model.role!
                                  : state.role,
                              started: state.startDate
                                  .toString()
                                  .formatToCustomDate(),
                              end: state.endDate == DateTime(0)
                                  ? 'No date'
                                  : state.endDate
                                      .toString()
                                      .formatToCustomDate(),
                            );
                            context.read<EmployeeCubit>().updateData(model);
                            Navigator.pop(context);
                            context.read<EmployeeCubit>().getAllEmployee();
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: const Color(0xFF1DA1F2),
                          ),
                          child: const Text(
                            'Update',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10)
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget bottomSheetWidget() {
    List<String> roles = [
      'Product Designer',
      'Flutter Developer',
      'QA Tester',
      'Product Owner'
    ];
    return ListView.builder(
        shrinkWrap: true,
        itemCount: roles.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              context.read<EmployeeCubit>().selectRole(roles[index]);
              Navigator.pop(context);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    roles[index],
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                if (index != roles.length - 1)
                  Divider(
                    color: Colors.grey.withOpacity(.5),
                    thickness: 1,
                    height: 0,
                  ),
              ],
            ),
          );
        });
  }

  @override
  void onDispose() {}

  @override
  void onPause() {}

  @override
  void onResume() {}
}
