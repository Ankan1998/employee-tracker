import 'package:flutter/material.dart';
import 'package:employee_db_tracker/pages/add_edit_page/cubits/bottom_modal_option_cubit.dart';
import 'package:employee_db_tracker/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDropdownWidget extends StatefulWidget {
  final VoidCallback onPressedx;

  const CustomDropdownWidget({super.key, required this.onPressedx});
  @override
  _CustomDropdownWidgetState createState() => _CustomDropdownWidgetState();
}

class _CustomDropdownWidgetState extends State<CustomDropdownWidget> {
  final List<String> options = [
    'Product designer',
    'Flutter Developer',
    'QA Tester',
    'Product Owner',
    'Senior Software Developer',
    'Full-stack Developer'
  ];

  void _showRoleSelectionModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.275,
          child: SingleChildScrollView(
            child: Column(
              children: options.map((role) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        role,
                        textAlign: TextAlign.center,
                      ),
                      onTap: () {
                        context.read<BottomModalOptionCubit>().updateOption(role);
                        Navigator.pop(context);
                      },
                    ),
                    const Divider(height: 0),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomModalOptionCubit, String>(builder: (context, selectedOption) {
      return GestureDetector(
        onTap: () {
          widget.onPressedx();
          _showRoleSelectionModal(context);
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
                Icons.shopping_bag_outlined,
                color: AppColors.xBlue,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  selectedOption,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      );
    });
  }
}
