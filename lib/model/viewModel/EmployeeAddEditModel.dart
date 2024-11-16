class EmployeeAddEditModel {
  int? empId;
  String empName;
  String empDesignation;
  DateTime startDate;
  DateTime endDate;

  EmployeeAddEditModel(
      {this.empId,
      required this.empName,
      required this.empDesignation,
      required this.startDate,
      required this.endDate});
}
