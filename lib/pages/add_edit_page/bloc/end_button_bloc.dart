import 'package:flutter_bloc/flutter_bloc.dart';

enum EndButtonColor { normal, pressed }

class EndButtonState {
  final EndButtonColor color;
  final int pressedIndex;

  EndButtonState(this.color, this.pressedIndex);
}

class EndButtonEvent {}

class EndButtonPressedEvent extends EndButtonEvent {
  final int buttonIndex;

  EndButtonPressedEvent(this.buttonIndex);
}

class EndButtonBloc extends Bloc<EndButtonEvent, EndButtonState> {
  EndButtonBloc() : super(EndButtonState(EndButtonColor.normal, -1)) {
    on<EndButtonPressedEvent>((event, emit) {
      if (state.pressedIndex == event.buttonIndex) {
        emit(EndButtonState(EndButtonColor.normal, -1));
      } else {
        emit(EndButtonState(EndButtonColor.pressed, event.buttonIndex));
      }
    });
  }
}
