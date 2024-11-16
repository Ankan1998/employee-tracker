import 'package:flutter_bloc/flutter_bloc.dart';

enum StartButtonColor { normal, pressed }

class StartButtonState {
  final StartButtonColor color;
  final int pressedIndex;

  StartButtonState(this.color, this.pressedIndex);
}

class StartButtonEvent {}

class StartButtonPressedEvent extends StartButtonEvent {
  final int buttonIndex;

  StartButtonPressedEvent(this.buttonIndex);
}

class StartButtonBloc extends Bloc<StartButtonEvent, StartButtonState> {
  StartButtonBloc() : super(StartButtonState(StartButtonColor.normal, -1)) {
    on<StartButtonPressedEvent>((event, emit) {
      if (state.pressedIndex == event.buttonIndex) {
        emit(StartButtonState(StartButtonColor.normal, -1));
      } else {
        emit(StartButtonState(StartButtonColor.pressed, event.buttonIndex));
      }
    });
  }
}
