import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:employee_db_tracker/model/data_model/employee_list_data_model.dart';
import 'package:employee_db_tracker/model/viewModel/EmployeeModel.dart';
import 'package:employee_db_tracker/utils/helpers.dart';
import 'package:meta/meta.dart';

import '../../../database/sqflite_database.dart';

part 'home_bloc_files/home_event.dart';
part 'home_bloc_files/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeLoading()) {
    on<HomeGetEmployeeEvent>(_homeGetEmployeeEvent);
  }

  List<EmployeeModel> employeeListMapper(List<Map<String, dynamic>> data) {
    List<EmployeeModel> empList = [];
    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        EmployeeDataModel emp = EmployeeDataModel.fromJson(data[i]);
        empList.add(
          EmployeeModel(
            empId: emp.id,
            empName: emp.name,
            empDesignation: emp.designation,
            startDate: HelperUtil.parseCustomStringToDate(emp.startDate),
            endDate: HelperUtil.parseCustomStringToDate(emp.endDate),
            isPreviousEmp: emp.isPrevious,
          ),
        );
      }
      return empList;
    } else {
      return [];
    }
  }

  Future<List<EmployeeModel>?> _getAllEmployees() async {
    try {
      DatabaseHelper helper = DatabaseHelper.instance;
      List<Map<String, dynamic>> data = await helper.queryAllRows();
      return employeeListMapper(data);
    } catch (e) {
      print("Something Went Wrong");
      return null;
    }
  }

  Future<void> _homeGetEmployeeEvent(
      HomeGetEmployeeEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    List<EmployeeModel>? empModelList = await _getAllEmployees();
    if (empModelList != null) {
      if (empModelList.isEmpty) {
        emit(HomeListEmpty());
      } else {
        emit(HomeSuccess(empModelList));
      }
    } else {
      emit(HomeFailure());
    }
  }
}
