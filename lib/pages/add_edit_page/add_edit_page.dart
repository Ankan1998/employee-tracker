import 'package:flutter/material.dart';
import 'package:employee_db_tracker/model/argument_model/add_edit_argument_model.dart';
import 'package:employee_db_tracker/pages/add_edit_page/bloc/add_edit_bloc.dart';
import 'package:employee_db_tracker/pages/add_edit_page/cubits/bottom_modal_option_cubit.dart';
import 'package:employee_db_tracker/model/viewModel/EmployeeAddEditModel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../home_page/HomePage.dart';
import '../home_page/bloc/delete_bloc.dart';
import 'cubits/date_cubit.dart';
import 'widgets/custom_bottom_modal_sheet.dart';
import 'widgets/custom_date_picker_main_modal_widget.dart';
import 'widgets/custom_editable_text_widget.dart';
import '../../custom_widget/save_cancel_bottom_widget.dart';
import '../../utils/app_colors.dart';

class AddEditPage extends StatefulWidget {
  final AddEditArgumentModel? addEditArgumentModel;

  const AddEditPage({Key? key, this.addEditArgumentModel}) : super(key: key);

  @override
  State<AddEditPage> createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleTap() {
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.addEditArgumentModel != null) {
      print(widget.addEditArgumentModel!.employeeEndDate);
      _textEditingController.text = widget.addEditArgumentModel!.employeeName;
      context
          .read<BottomModalOptionCubit>()
          .updateOption(widget.addEditArgumentModel!.employeeDesignation);
      context
          .read<StartDateCubit>()
          .updateDate(widget.addEditArgumentModel!.employeeStartDate);
      context
          .read<EndDateCubit>()
          .updateDate(widget.addEditArgumentModel!.employeeEndDate);
    }
    return BlocConsumer<AddEditBloc, AddEditState>(
      listener: (context, state) {
        if (state is AddEditSuccess) {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomePage()),
              (Route<dynamic> route) => false);
        } else if (state is AddEditFailure) {
          const snackBar = SnackBar(
            content: Text('Employee data cannot be added right now!'),
            duration: Duration(seconds: 3),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        return PopScope(
          onPopInvokedWithResult: (bool didPop, Object? result) async {
            context.read<StartDateCubit>().resetCubit();
            context.read<EndDateCubit>().resetCubit();
            context.read<BottomModalOptionCubit>().resetCubit();
            return Future.value(true);
          },
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.xWhite,
              appBar: AppBar(
                title: widget.addEditArgumentModel != null
                    ? const Text('Edit Employee Details')
                    : const Text('Add Employee Details'),
                elevation: 0,
                backgroundColor: AppColors.xBlue,
                foregroundColor: AppColors.xWhite,
                actions: [
                  widget.addEditArgumentModel != null
                      ? Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: InkWell(
                            onTap: () {
                              context.read<DeleteBloc>().add(
                                    DeleteRecordEvent(
                                        widget.addEditArgumentModel!.empId),
                                  );
                              context.read<StartDateCubit>().resetCubit();
                              context.read<EndDateCubit>().resetCubit();
                              context
                                  .read<BottomModalOptionCubit>()
                                  .resetCubit();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (Route<dynamic> route) => false);
                            },
                            child: const Icon(
                              Icons.delete_forever_outlined,
                              color: AppColors.xWhite,
                            ),
                          ),
                        )
                      : const SizedBox()
                ],
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Column(children: [
                      const SizedBox(
                        height: 12.0,
                      ),
                      CustomTextEditableWidget(
                        focusNode: _focusNode,
                        controller: _textEditingController,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomDropdownWidget(
                        onPressedx: _handleTap,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          BlocBuilder<StartDateCubit, DateTime>(
                              builder: (context, selectedDate) {
                            final startDateCubit =
                                context.read<StartDateCubit>();
                            return Expanded(
                              child: CustomDatePickerMainModalWidget(
                                calendarBloc: startDateCubit,
                                selectedDate: selectedDate,
                                isEndDateWidget: false,
                              ),
                            );
                          }),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Icon(
                              Icons.arrow_right_alt_outlined,
                              color: AppColors.xBlue,
                            ),
                          ),
                          BlocBuilder<EndDateCubit, DateTime>(
                              builder: (context, selectedDate) {
                            final endDateCubit = context.read<EndDateCubit>();
                            return Expanded(
                              child: CustomDatePickerMainModalWidget(
                                calendarBloc: endDateCubit,
                                selectedDate: selectedDate,
                                isEndDateWidget: true,
                              ),
                            );
                          })
                        ],
                      ),
                    ]),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: SaveCancelBottombarWidget(
                      onPressedCancel: () {
                        Navigator.of(context).pop();
                        context.read<StartDateCubit>().resetCubit();
                        context.read<EndDateCubit>().resetCubit();
                        context.read<BottomModalOptionCubit>().resetCubit();
                      },
                      onPressedSave: () {
                        final EmployeeAddEditModel emp = EmployeeAddEditModel(
                            empId: widget.addEditArgumentModel != null
                                ? widget.addEditArgumentModel!.empId
                                : null,
                            empName: _textEditingController.text,
                            empDesignation:
                                context.read<BottomModalOptionCubit>().state,
                            startDate: context.read<StartDateCubit>().state,
                            endDate: context.read<EndDateCubit>().state);
                        if (widget.addEditArgumentModel == null) {
                          context
                              .read<AddEditBloc>()
                              .add(AddEmployeeDetailEvent(emp));
                        } else {
                          context
                              .read<AddEditBloc>()
                              .add(EditEmployeeDetailEvent(emp));
                        }
                        context.read<StartDateCubit>().resetCubit();
                        context.read<EndDateCubit>().resetCubit();
                        context.read<BottomModalOptionCubit>().resetCubit();
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
