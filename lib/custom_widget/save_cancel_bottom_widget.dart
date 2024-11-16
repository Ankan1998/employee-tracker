import 'package:flutter/material.dart';
import 'package:employee_db_tracker/utils/app_colors.dart';

import 'custom_Button_widget.dart';

class SaveCancelBottombarWidget extends StatelessWidget {
  final String firstGroupText;
  final VoidCallback onPressedCancel;
  final VoidCallback onPressedSave;
  final bool isCalendarText;

  SaveCancelBottombarWidget({
    this.firstGroupText = "",
    required this.onPressedCancel,
    required this.onPressedSave,
    this.isCalendarText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isCalendarText
            ? Row(
                children: [
                  const Icon(Icons.calendar_today_outlined,
                      color: AppColors.xBlue),
                  const SizedBox(width: 8),
                  Text(firstGroupText),
                ],
              )
            : const SizedBox(),
        Row(
          children: [
            CustomButton(
              text: "Cancel",
              onPressed: onPressedCancel,
              backgroundColor: AppColors.xLightBlue,
              textColor: AppColors.xBlue,
              width: 75.0,
            ),
            SizedBox(width: 16),
            CustomButton(
              text: "Save",
              onPressed: onPressedSave,
              backgroundColor: AppColors.xBlue,
              textColor: AppColors.xWhite,
              width: 73.0,
            ),
          ],
        ),
      ],
    );
  }
}
