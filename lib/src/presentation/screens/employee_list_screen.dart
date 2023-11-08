import 'dart:developer';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ninjacoder/src/presentation/screens/add_employee_details_screen.dart';
import 'package:ninjacoder/src/presentation/screens/cubit/employee_cubit.dart';
import 'package:ninjacoder/src/shared/extension/string_ext.dart';
import 'package:ninjacoder/src/shared/shared.dart';

import '../base/base_state_wrapper.dart';
import '../widgets/mx_appbar.dart';

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends BaseStateWrapper<EmployeeListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget onBuild(
      BuildContext context, BoxConstraints constraints, PlatformType platform) {
    return BlocConsumer<EmployeeCubit, EmployeeState>(
      listener: (context, state) {
        log(state.status.toString());
        if (state.status == EmployeeStatus.LOADING) {
          BotToast.showLoading();
        } else {
          BotToast.closeAllLoading();
        }
      },
      builder: (context, state) {
        var currentEmployee = state.employeedata.where(
          (e) {
            return e.end == 'No date';
          },
        ).toList();
        var previousEmployee = state.employeedata.where(
          (e) {
            if (e.end != 'No date') {
              var sd = (e.started ?? '').toString().toDate();
              log('stared $sd');
              var ed = (e.end ?? '').toString().toDate();
              log('stared $ed');
              var show = ed.isAfter(sd);
              log('show $show');
              return show;
            } else {
              return false;
            }
          },
        ).toList();
        log('state.employeedata ${state.employeedata}');
        return Scaffold(
          key: _scaffoldKey,
          appBar: MxAppBar(
            leading: Container(),
            title: const Text('Employee List'),
          ),
          body: state.employeedata.isEmpty
              ? Center(
                  child: SvgPicture.asset('assets/no_employee.svg'),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (currentEmployee.isNotEmpty)
                        Container(
                          width: context.screenWidth,
                          height: 56,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.15)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Text(
                              'Current employees',
                              style: TextStyle(
                                color: Color(0xFF1DA1F2),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      if (currentEmployee.isNotEmpty)
                        const SizedBox(height: 15),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: currentEmployee.length,
                          itemBuilder: (context, index) {
                            var data = currentEmployee[index];
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) =>
                                  showConfirmDismissDialog(
                                direction,
                                context,
                                data.id ?? -1,
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      data.fullName ?? '',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Text(
                                      data.role ?? '',
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
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "from ${data.started ?? ''}",
                                          style: const TextStyle(
                                            color: Color(0xFF949C9E),
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  if (index != state.employeedata.length - 1)
                                    Divider(
                                      color: Colors.grey.withOpacity(.15),
                                      thickness: 1,
                                      height: 0,
                                    )
                                ],
                              ),
                            );
                          }),
                      if (previousEmployee.isNotEmpty)
                        Container(
                          width: context.screenWidth,
                          height: 56,
                          decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(.15)),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: Text(
                              'Previous employees',
                              style: TextStyle(
                                color: Color(0xFF1DA1F2),
                                fontSize: 16,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 15),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: previousEmployee.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = previousEmployee[index];
                            return Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) =>
                                  showConfirmDismissDialog(
                                direction,
                                context,
                                data.id ?? -1,
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        data.fullName ?? '',
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        data.role ?? '',
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: Text(
                                        "${data.started ?? ''} - ${data.end ?? ''}",
                                        style: const TextStyle(
                                          color: Color(0xFF949C9E),
                                          fontSize: 12,
                                          fontFamily: 'Roboto',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    if (index != state.employeedata.length - 1)
                                      Divider(
                                        color: Colors.grey.withOpacity(.15),
                                        thickness: 1,
                                        height: 0,
                                      )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
          bottomSheet: Container(
            height: 60,
            width: context.screenWidth,
            padding: const EdgeInsets.only(top: 12, left: 16),
            decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
            child: const Text(
              'Swipe left to delete',
              style: TextStyle(
                color: Color(0xFF949C9E),
                fontSize: 15,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const AddEmpoyeeDetailsScreen();
              }));
            },
          ),
        );
      },
    );
  }

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
                            context.read<EmployeeCubit>().undoDelete();
                          },
                        ),
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

  @override
  void onDispose() {}

  @override
  void onInit() {
    context.read<EmployeeCubit>().getAllEmployee();
  }

  @override
  void onPause() {}

  @override
  void onResume() {}
}
