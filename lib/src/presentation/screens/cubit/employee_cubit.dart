import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ninjacoder/src/data/model/employee/employee_model.dart';

import '../../../data/client/employee_database_client.dart';

part 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  EmployeeCubit() : super(EmployeeState.initial());

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
  void deleteData(int employeeId) async {
    emit(state.copyWith(status: EmployeeStatus.LOADING));

    await dbClient.deleteEmployee(employeeId);

    emit(state.copyWith(status: EmployeeStatus.LOADED));
  }
}
