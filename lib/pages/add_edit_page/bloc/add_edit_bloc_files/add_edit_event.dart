part of '../add_edit_bloc.dart';

@immutable
abstract class AddEditEvent {}

class AddEmployeeDetailEvent extends AddEditEvent {
  final EmployeeAddEditModel employeeModel;

  AddEmployeeDetailEvent(this.employeeModel);
}

class EditEmployeeDetailEvent extends AddEditEvent {
  final EmployeeAddEditModel employeeModel;

  EditEmployeeDetailEvent(this.employeeModel);
}
