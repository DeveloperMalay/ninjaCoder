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

  const EmployeeState({
    required this.employeedata,
    required this.status,
    required this.role,
  });
  factory EmployeeState.initial() {
    return const EmployeeState(
      employeedata: [],
      status: EmployeeStatus.INITIAL,
      role: '',
    );
  }
  @override
  List<Object?> get props => [employeedata, status, role];

  EmployeeState copyWith({
    List<EmployeeModel>? employeedata,
    EmployeeStatus? status,
    String? role,
  }) {
    return EmployeeState(
      employeedata: employeedata ?? this.employeedata,
      status: status ?? this.status,
      role: role ?? this.role,
    );
  }
}
