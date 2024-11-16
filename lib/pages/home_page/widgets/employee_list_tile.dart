import 'package:flutter/material.dart';
import 'package:employee_db_tracker/utils/app_colors.dart';

class CustomListTile extends StatelessWidget {
  final String Title;
  final String Position;
  final String startDate;
  final String? endDate;
  final int isPrev;

  const CustomListTile(
      {super.key,
      required this.Title,
      required this.Position,
      required this.startDate,
      this.endDate = '',
      required this.isPrev});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: ListTile(
            title: Text(
              Title,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    Position,
                    style: const TextStyle(
                        color: AppColors.xGreyTextShade, fontSize: 14),
                  ),
                ),
                Text(
                  isPrev == 0 ? 'From $startDate' : '$startDate - $endDate',
                  style: const TextStyle(
                      fontSize: 12, color: AppColors.xGreyTextShade),
                ),
              ],
            )),
      ),
    );
  }
}
