import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ninjacoder/src/presentation/screens/add_employee_details_screen.dart';
import 'package:ninjacoder/src/presentation/screens/cubit/employee_cubit.dart';
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
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
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
                      Container(
                        width: context.screenWidth,
                        height: 56,
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(.15)),
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
                      const SizedBox(height: 15),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.employeedata.length,
                          itemBuilder: (context, index) {
                            var data = state.employeedata[index];
                            return Slidable(
                              key: ValueKey((data.id ?? -1).toString()),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (c) {
                                        var snackbar = SnackBar(
                                          key: _scaffoldKey,
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
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                    ),
                                  ]),
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
                                          data.started ?? '',
                                          style: const TextStyle(
                                            color: Color(0xFF949C9E),
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          data.end ?? '',
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
                                    )
                                ],
                              ),
                            );
                          }),
                      Container(
                        width: context.screenWidth,
                        height: 56,
                        decoration:
                            BoxDecoration(color: Colors.grey.withOpacity(.15)),
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
                          itemCount: state.employeedata.length,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var data = state.employeedata[index];
                            return Slidable(
                              key: ValueKey((data.id ?? -1).toString()),
                              endActionPane: ActionPane(
                                  motion: const ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (c) {
                                        var snackbar = SnackBar(
                                          key: _scaffoldKey,
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
                                              ScaffoldMessenger.of(context)
                                                  .hideCurrentSnackBar();
                                            },
                                          ),
                                        );
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackbar);
                                      },
                                      backgroundColor: Colors.red,
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                    ),
                                  ]),
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
                                          data.started ?? '',
                                          style: const TextStyle(
                                            color: Color(0xFF949C9E),
                                            fontSize: 12,
                                            fontFamily: 'Roboto',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        Text(
                                          data.end ?? '',
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
                                    )
                                ],
                              ),
                            );
                          }),
                    ],
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
