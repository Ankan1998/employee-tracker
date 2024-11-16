import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:employee_db_tracker/model/viewModel/EmployeeAddEditModel.dart';
import 'package:employee_db_tracker/utils/helpers.dart';
import 'package:meta/meta.dart';

import '../../../database/sqflite_database.dart';

part 'add_edit_bloc_files/add_edit_event.dart';
part 'add_edit_bloc_files/add_edit_state.dart';

class AddEditBloc extends Bloc<AddEditEvent, AddEditState> {
  AddEditBloc() : super(AddEditInitial()) {
    on<AddEmployeeDetailEvent>(_addEmployeeDetailEvent);
    on<EditEmployeeDetailEvent>(_editEmployeeDetailEvent);
  }

  Future<int?> _insertEmployee(EmployeeAddEditModel emp) async {
    int isPrevEmployee = HelperUtil.isPrevEmployee(emp.endDate);
    String startDateTime = HelperUtil.formatDateToCustomString(emp.startDate);
    String endDateTime = HelperUtil.formatDateToCustomString(emp.endDate);

    try {
      DatabaseHelper helper = DatabaseHelper.instance;
      Map<String, dynamic> row = {
        DatabaseHelper.columnName: emp.empName,
        DatabaseHelper.columnDesignation: emp.empDesignation,
        DatabaseHelper.columnStartDate: startDateTime,
        DatabaseHelper.columnEndDate: endDateTime,
        DatabaseHelper.columnIsPrevious: isPrevEmployee,
      };
      int id = await helper.insert(row);
      return id;
    } catch (e) {
      print("Something Went Wrong");
      return null;
    }
  }

  Future<int?> _updateEmployee(EmployeeAddEditModel emp) async {
    int isPrevEmployee = emp.endDate.year == 1980
        ? 0
        : DateTime.now().isAfter(emp.endDate)
            ? 1
            : 0;
    String startDateTime = HelperUtil.formatDateToCustomString(emp.startDate);
    String endDateTime = HelperUtil.formatDateToCustomString(emp.endDate);

    try {
      DatabaseHelper helper = DatabaseHelper.instance;
      Map<String, dynamic> row = {
        DatabaseHelper.columnId: emp.empId,
        DatabaseHelper.columnName: emp.empName,
        DatabaseHelper.columnDesignation: emp.empDesignation,
        DatabaseHelper.columnStartDate: startDateTime,
        DatabaseHelper.columnEndDate: endDateTime,
        DatabaseHelper.columnIsPrevious: isPrevEmployee,
      };
      int id = await helper.update(row);
      return id;
    } catch (e) {
      print("Something Went Wrong");
      return null;
    }
  }

  Future<void> _addEmployeeDetailEvent(
      AddEmployeeDetailEvent event, Emitter<AddEditState> emit) async {
    int? empId = await _insertEmployee(event.employeeModel);
    if (empId != null) {
      emit(AddEditSuccess());
    } else {
      emit(AddEditFailure());
    }
  }

  void _editEmployeeDetailEvent(
      EditEmployeeDetailEvent event, Emitter<AddEditState> emit) async {
    int? empId = await _updateEmployee(event.employeeModel);
    if (empId != null) {
      emit(AddEditSuccess());
    } else {
      emit(AddEditFailure());
    }
  }
}
