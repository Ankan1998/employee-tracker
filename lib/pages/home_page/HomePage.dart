import 'package:flutter/material.dart';
import 'package:employee_db_tracker/model/argument_model/add_edit_argument_model.dart';
import 'package:employee_db_tracker/pages/add_edit_page/add_edit_page.dart';
import 'package:employee_db_tracker/pages/home_page/bloc/delete_bloc.dart';
import 'package:employee_db_tracker/pages/home_page/bloc/home_bloc.dart';
import 'package:employee_db_tracker/pages/home_page/widgets/employee_list_tile.dart';
import 'package:employee_db_tracker/utils/app_colors.dart';
import 'package:employee_db_tracker/utils/helpers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../model/viewModel/EmployeeModel.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeGetEmployeeEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Employee List'),
          elevation: 0,
          backgroundColor: AppColors.xBlue,
          foregroundColor: AppColors.xWhite,
        ),
        backgroundColor: AppColors.xGreyBackground,
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Loading, please wait...',
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.xGrey,
                      ),
                    ),
                  ],
                ),
              );
            } else if (state is HomeFailure) {
              return const Center(
                child: Text(
                  'Something Went Wrong!',
                  style:
                      TextStyle(fontSize: 16, color: AppColors.xGreyTextShade),
                ),
              );
            } else if (state is HomeSuccess) {
              return BlocListener<DeleteBloc, DeleteState>(
                bloc: context.read<DeleteBloc>(),
                listener: (context, state) {
                  if (state is UndoDeleteSuccess) {
                    var snackBar = SnackBar(
                      content: const Text('Employee data has been Deleted!'),
                      duration: const Duration(seconds: 1),
                      action: SnackBarAction(
                        label: 'Undo',
                        onPressed: () {
                          context.read<DeleteBloc>().add(UndoDeleteEvent());
                        },
                        textColor: Colors.blue,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  if (state is UndoDeleteSuccessWithRefresh) {
                    context.read<HomeBloc>().add(HomeGetEmployeeEvent());
                  }
                },
                child: ListView(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: GroupListView(
                        sectionsCount: 2,
                        countOfItemInSection: (int section) {
                          return state.empModelList
                              .where((e) => e.isPreviousEmp == section)
                              .length;
                        },
                        itemBuilder: (BuildContext context, IndexPath index) {
                          EmployeeModel employee = state.empModelList
                              .where((e) => e.isPreviousEmp == index.section)
                              .toList()[index.index];
                          return GestureDetector(
                            child: Dismissible(
                              key: UniqueKey(),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) {
                                context
                                    .read<DeleteBloc>()
                                    .add(DeleteRecordEvent(employee.empId));
                              },
                              background: Container(
                                alignment: Alignment.centerRight,
                                color: Colors.red,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 24),
                                child: const Icon(
                                  Icons.delete_forever_outlined,
                                  color: Colors.white,
                                  size: 24,
                                ),
                              ),
                              child: Column(
                                children: [
                                  CustomListTile(
                                    Title: employee.empName,
                                    Position: employee.empDesignation,
                                    startDate: HelperUtil.formatDate_dMMMy(
                                        employee.startDate),
                                    endDate: HelperUtil.formatDate_dMMMy(
                                        employee.endDate),
                                    isPrev: employee.isPreviousEmp,
                                  ),
                                  const Divider(height: 1)
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddEditPage(
                                    addEditArgumentModel: AddEditArgumentModel(
                                      empId: employee.empId,
                                      employeeName: employee.empName,
                                      employeeDesignation:
                                          employee.empDesignation,
                                      employeeStartDate: employee.startDate,
                                      employeeEndDate: employee.endDate,
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        groupHeaderBuilder:
                            (BuildContext context, int section) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 18),
                            child: Text(
                              section == 0
                                  ? 'Current employees'
                                  : 'Previous employees',
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.xBlue),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      color: AppColors
                          .xGreyBackground, // Adjust the color as needed
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: const Text(
                        "Swipe left to delete",
                        style: TextStyle(color: AppColors.xGreyTextShade),
                      ), // Replace with your sticky widget
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                  ),
                  SvgPicture.asset(
                    'assets/no_record.svg',
                  ),
                  const Text(
                    "No employee records found",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddEditPage(),
              ),
            );
          },
          backgroundColor: AppColors.xBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
