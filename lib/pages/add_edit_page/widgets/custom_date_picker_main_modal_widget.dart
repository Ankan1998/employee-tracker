import 'package:flutter/material.dart';
import 'package:employee_db_tracker/pages/add_edit_page/cubits/date_cubit.dart';
import 'package:employee_db_tracker/utils/app_colors.dart';
import 'package:employee_db_tracker/utils/helpers.dart';

import 'custom_date_picker_widget.dart';

class CustomDatePickerMainModalWidget extends StatelessWidget {
  final DateCubit calendarBloc;
  final DateTime selectedDate;
  final bool isEndDateWidget;

  const CustomDatePickerMainModalWidget({
    super.key,
    required this.calendarBloc,
    required this.selectedDate,
    required this.isEndDateWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDialogPopup(context, calendarBloc, isEndDateWidget, selectedDate);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.xGreyBorder, width: 1),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_outlined,
              color: AppColors.xBlue,
            ),
            const SizedBox(width: 8),
            // 9987 Issue
            Expanded(
              child: selectedDate == DateTime(1980)
                  ? Text(
                      "No Date",
                      style: TextStyle(color: AppColors.xGreyTextShade),
                    )
                  : HelperUtil.isNotToday(selectedDate)
                      ? Text(HelperUtil.formatDate_dMMMy(selectedDate))
                      : Text("Today"),
            ),
          ],
        ),
      ),
    );
  }
}

void _showDialogPopup(BuildContext context, DateCubit calendarCubit, bool isEndDateWidget, DateTime selectedDate) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide.none, // No border
        ),
        insetPadding: EdgeInsets.zero,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.90,
          height: isEndDateWidget ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.65,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: CustomCalendarDatePicker(
            initialDate: selectedDate == DateTime(1980) ? DateTime.now() : selectedDate,
            firstDate: DateTime(1980),
            lastDate: DateTime(2090),
            onDateChanged: (DateTime value) {
              calendarCubit.updateDate(value);
            },
            isEndDate: isEndDateWidget,
            endDateOrginalValue: selectedDate,
          ),
        ),
      );
    },
  );
}
