import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class CustomTextEditableWidget extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;

  const CustomTextEditableWidget({super.key, required this.focusNode, required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.xGreyBorder, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Icon(Icons.person_2_outlined, color: AppColors.xBlue),
          SizedBox(width: 12),
          Expanded(
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
                hintText: 'Employee Name',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
