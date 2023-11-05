// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'employee_model.freezed.dart';
part 'employee_model.g.dart';

@freezed
class EmployeeModel with _$EmployeeModel {
  const factory EmployeeModel({
    @JsonKey(name: 'id', includeFromJson: true, includeToJson: true) int? id,
    @JsonKey(name: 'full_name') String? fullName,
    @JsonKey(name: 'role') String? role,
    @JsonKey(name: 'started', includeFromJson: true, includeToJson: false)
    String? started,
    @JsonKey(name: 'end', includeFromJson: true, includeToJson: false)
    String? end,
  }) = _EmployeeModel;

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  // empty user
  static EmployeeModel empty() => const EmployeeModel(
        id: null,
        fullName: null,
        role: null,
        started: null,
        end: null,
      );
}
