import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_colors.dart';
import '../bloc/end_button_bloc.dart';

class EndDateHeaderWidget extends StatelessWidget {
  final VoidCallback onPressedToday;
  final VoidCallback onPressedNoDate;
  const EndDateHeaderWidget(
      {Key? key, required this.onPressedToday, required this.onPressedNoDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BlocBuilder<EndButtonBloc, EndButtonState>(
            builder: (context, state) {
              return Expanded(
                child: TextButton(
                  onPressed: () {
                    onPressedNoDate();
                    context.read<EndButtonBloc>().add(EndButtonPressedEvent(0));
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      state.pressedIndex == 0
                          ? AppColors.xBlue
                          : AppColors.xLightBlue,
                    ),
                    foregroundColor: WidgetStateProperty.all(
                      state.pressedIndex == 0
                          ? AppColors.xWhite
                          : AppColors.xBlue,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Adjust this value to make corners more or less round
                      ),
                    ),
                  ),
                  child: const Text("No date"),
                ),
              );
            },
          ),
          const SizedBox(
            width: 16,
          ),
          BlocBuilder<EndButtonBloc, EndButtonState>(
            builder: (context, state) {
              return Expanded(
                child: TextButton(
                  onPressed: () {
                    onPressedToday();
                    context.read<EndButtonBloc>().add(EndButtonPressedEvent(1));
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      state.pressedIndex == 1
                          ? AppColors.xBlue
                          : AppColors.xLightBlue,
                    ),
                    foregroundColor: WidgetStateProperty.all(
                      state.pressedIndex == 1
                          ? AppColors.xWhite
                          : AppColors.xBlue,
                    ),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Adjust this value to make corners more or less round
                      ),
                    ),
                  ),
                  child: const Text("Today"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
