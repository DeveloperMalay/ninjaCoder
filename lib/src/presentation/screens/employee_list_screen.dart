import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          body: state.employeedata.isNotEmpty
              ? Center(
                  child: SvgPicture.asset('assets/no_employee.svg'),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: context.screenWidth,
                      height: 56,
                      decoration:
                          BoxDecoration(color: Colors.grey.withOpacity(.15)),
                      child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: state.employeedata.length,
                        itemBuilder: (context, index) {
                          return Container();
                        }),
                  ],
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
  void onInit() {}

  @override
  void onPause() {}

  @override
  void onResume() {}
}
