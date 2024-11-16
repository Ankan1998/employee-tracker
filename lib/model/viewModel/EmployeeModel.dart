class EmployeeModel {
  int empId;
  String empName;
  String empDesignation;
  DateTime startDate;
  DateTime endDate;
  int isPreviousEmp;

  EmployeeModel(
      {required this.empId,
      required this.empName,
      required this.empDesignation,
      required this.startDate,
      required this.endDate,
      required this.isPreviousEmp});
}
