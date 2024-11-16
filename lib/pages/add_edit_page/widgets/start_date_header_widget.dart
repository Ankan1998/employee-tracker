import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/app_colors.dart';
import '../bloc/start_button_bloc.dart';

class StartDateHeder extends StatelessWidget {
  final VoidCallback onPressedToday;
  final VoidCallback onPressedNextMonday;
  final VoidCallback onPressedNextTuseday;
  final VoidCallback onPressedAfterWeek;

  const StartDateHeder(
      {super.key,
      required this.onPressedToday,
      required this.onPressedNextMonday,
      required this.onPressedNextTuseday,
      required this.onPressedAfterWeek});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<StartButtonBloc, StartButtonState>(
                builder: (context, state) {
                  return Expanded(
                    child: TextButton(
                      onPressed: () {
                        onPressedToday();
                        context
                            .read<StartButtonBloc>()
                            .add(StartButtonPressedEvent(0));
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
                            borderRadius: BorderRadius.circular(
                                8), // Adjust this value to make corners more or less round
                          ),
                        ),
                      ),
                      child: const Text("Today"),
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 16,
              ),
              BlocBuilder<StartButtonBloc, StartButtonState>(
                builder: (context, state) {
                  return Expanded(
                    child: TextButton(
                      onPressed: () {
                        onPressedNextMonday();
                        context
                            .read<StartButtonBloc>()
                            .add(StartButtonPressedEvent(1));
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
                            borderRadius: BorderRadius.circular(
                                8), // Adjust this value to make corners more or less round
                          ),
                        ),
                      ),
                      child: const Text("Next Monday"),
                    ),
                  );
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              BlocBuilder<StartButtonBloc, StartButtonState>(
                builder: (context, state) {
                  return Expanded(
                    child: TextButton(
                      onPressed: () {
                        onPressedNextTuseday();
                        context
                            .read<StartButtonBloc>()
                            .add(StartButtonPressedEvent(2));
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          state.pressedIndex == 2
                              ? AppColors.xBlue
                              : AppColors.xLightBlue,
                        ),
                        foregroundColor: WidgetStateProperty.all(
                          state.pressedIndex == 2
                              ? AppColors.xWhite
                              : AppColors.xBlue,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                8), // Adjust this value to make corners more or less round
                          ),
                        ),
                      ),
                      child: const Text("Next Tuesday"),
                    ),
                  );
                },
              ),
              const SizedBox(
                width: 16,
              ),
              BlocBuilder<StartButtonBloc, StartButtonState>(
                builder: (context, state) {
                  return Expanded(
                    child: TextButton(
                      onPressed: () {
                        onPressedAfterWeek();
                        context
                            .read<StartButtonBloc>()
                            .add(StartButtonPressedEvent(3));
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          state.pressedIndex == 3
                              ? AppColors.xBlue
                              : AppColors.xLightBlue,
                        ),
                        foregroundColor: WidgetStateProperty.all(
                          state.pressedIndex == 3
                              ? AppColors.xWhite
                              : AppColors.xBlue,
                        ),
                        shape: WidgetStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8), // Adjust this value to make corners more or less round
                          ),
                        ),
                      ),
                      child: const Text("After 1 week"),
                    ),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
