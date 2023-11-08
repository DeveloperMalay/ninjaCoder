import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ninjacoder/src/data/model/employee/employee_model.dart';

import '../../../data/client/employee_database_client.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeState.initial());

//*initial state

  void getInitialState() {
    emit(EmployeeState.initial());
  }

//* selecting employee role
  void selectRole(String role) {
    emit(state.copyWith(role: role));
  }

  void selectStartDate(DateTime date) {
    emit(state.copyWith(startDate: date));
  }

  void selectEndDate(DateTime date) {
    emit(state.copyWith(endDate: date));
  }

  final dbClient = EmployeeDatabaseClient.instance;
  //*inserting data to local DB
  void insertData(EmployeeModel model) async {
    emit(state.copyWith(status: EmployeeStatus.LOADING));

    await dbClient.insertEmployee(model);
    emit(state.copyWith(status: EmployeeStatus.LOADED));
  }

  //*getting data from local DB
  void getAllEmployee() async {
    emit(state.copyWith(status: EmployeeStatus.LOADING));
    var res = await dbClient.getAllEmployees();

    emit(state.copyWith(status: EmployeeStatus.LOADED, employeedata: res));
  }

  //*updating data to local DB
  void updateData(EmployeeModel model) async {
    emit(state.copyWith(status: EmployeeStatus.LOADING));

    await dbClient.updateEmployee(model);

    emit(state.copyWith(status: EmployeeStatus.LOADED));
  }

  //*deleting data from local DB
  Future<bool> deleteData(int employeeId) async {
    emit(state.copyWith(status: EmployeeStatus.LOADING));
    try {
      var res = await dbClient.deleteEmployee(employeeId);
      log('delete res $res');
      emit(state.copyWith(status: EmployeeStatus.LOADED));
      return true;
    } catch (e) {
      return false;
    }
  }

  //*undoing deleted data from local DB
  void undoDelete() async {
    emit(state.copyWith(status: EmployeeStatus.LOADING));
    try {
      await dbClient.undoDelete();
    } catch (e) {
      log('undo delete error $e');
    }

    emit(state.copyWith(status: EmployeeStatus.LOADED));
  }
}
