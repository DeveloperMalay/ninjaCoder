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

  const EmployeeState({
    required this.employeedata,
    required this.status,
    required this.role,
    required this.startDate,
    required this.endDate,
  });
  factory EmployeeState.initial() {
    return EmployeeState(
      employeedata: const [],
      status: EmployeeStatus.INITIAL,
      role: '',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );
  }
  @override
  List<Object?> get props => [employeedata, status, role, startDate, endDate];

  EmployeeState copyWith({
    List<EmployeeModel>? employeedata,
    EmployeeStatus? status,
    String? role,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return EmployeeState(
      employeedata: employeedata ?? this.employeedata,
      status: status ?? this.status,
      role: role ?? this.role,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }
}
