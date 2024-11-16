import 'package:bloc/bloc.dart';

abstract class DateCubit {
  void updateDate(DateTime dt);
}

class StartDateCubit extends Cubit<DateTime> implements DateCubit {
  StartDateCubit() : super(DateTime.now());

  void updateDate(DateTime dateTime) {
    emit(dateTime);
  }

  void resetCubit() {
    emit(DateTime.now());
  }
}

class EndDateCubit extends Cubit<DateTime> implements DateCubit {
  EndDateCubit() : super(DateTime(1980));

  void updateDate(DateTime dateTime) {
    emit(dateTime);
  }

  void resetCubit() {
    emit(DateTime(1980));
  }
}
