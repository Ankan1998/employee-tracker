import 'package:bloc/bloc.dart';

class BottomModalOptionCubit extends Cubit<String> {
  BottomModalOptionCubit() : super('Select Role');

  void updateOption(String option) {
    emit(option);
  }

  void resetCubit() {
    emit('Select Role');
  }
}
