import 'dart:convert';

class EmployeeDataModel {
  final int id;
  final String name;
  final String designation;
  final String startDate;
  final String endDate;
  final int isPrevious;

  EmployeeDataModel({
    required this.id,
    required this.name,
    required this.designation,
    required this.startDate,
    required this.endDate,
    required this.isPrevious,
  });

  factory EmployeeDataModel.fromRawJson(String str) =>
      EmployeeDataModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory EmployeeDataModel.fromJson(Map<String, dynamic> json) =>
      EmployeeDataModel(
        id: json["_id"],
        name: json["name"],
        designation: json["designation"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        isPrevious: json["is_previous"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "designation": designation,
        "start_date": startDate,
        "end_date": endDate,
        "is_previous": isPrevious,
      };
}
