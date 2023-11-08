// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

part of 'employee_cubit.dart';

enum EmployeeStatus {
  INITIAL,
  LOADING,
  LOADED,
  ERROR,
}

class EmployeeState extends Equatable {
  final List<EmployeeModel> employeedata;
  final EmployeeStatus status;
  final String role;
  final DateTime startDate;
  final DateTime endDate;
  final List<EmployeeModel> deletedEmployees;
  final List<EmployeeModel> currentEmployee;
  final List<EmployeeModel> previousEmployee;
  const EmployeeState({
    required this.employeedata,
    required this.status,
    required this.role,
    required this.startDate,
    required this.endDate,
    required this.deletedEmployees,
    required this.currentEmployee,
    required this.previousEmployee,
  });
  factory EmployeeState.initial() {
    return EmployeeState(
      employeedata: const [],
      status: EmployeeStatus.INITIAL,
      role: '',
      startDate: DateTime.now(),
      endDate: DateTime(0),
      deletedEmployees: const [],
      currentEmployee: const [],
      previousEmployee: const [],
    );
  }
  @override
  List<Object?> get props => [
        employeedata,
        status,
        role,
        startDate,
        endDate,
        deletedEmployees,
        currentEmployee,
        previousEmployee
      ];

  EmployeeState copyWith({
    List<EmployeeModel>? employeedata,
    EmployeeStatus? status,
    String? role,
    DateTime? startDate,
    DateTime? endDate,
    List<EmployeeModel>? deletedEmployees,
    List<EmployeeModel>? currentEmployee,
    List<EmployeeModel>? previousEmployee,
  }) {
    return EmployeeState(
      employeedata: employeedata ?? this.employeedata,
      status: status ?? this.status,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      deletedEmployees: deletedEmployees ?? this.deletedEmployees,
      currentEmployee: currentEmployee ?? this.currentEmployee,
      previousEmployee: previousEmployee ?? this.previousEmployee,
    );
  }
}
