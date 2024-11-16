import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../database/sqflite_database.dart';

part 'delete_bloc_files/delete_event.dart';
part 'delete_bloc_files/delete_state.dart';

class DeleteBloc extends Bloc<DeleteEvent, DeleteState> {
  DeleteBloc() : super(DeleteInitial()) {
    on<DeleteRecordEvent>(_deleteRecordEvent);
    on<UndoDeleteEvent>(_undoDeleteEvent);
  }

  Timer? _undoTimer;

  Future<void> _deleteRecordEvent(
      DeleteRecordEvent event, Emitter<DeleteState> emit) async {
    try {
      DatabaseHelper helper = DatabaseHelper.instance;
      emit(UndoDeleteSuccess());
      _undoTimer = Timer(Duration(seconds: 2), () async {
        await helper.delete(event.empId);
      });
    } catch (e) {
      print("Something Went Wrong");
      emit(DeleteFailure());
    }
  }

  Future<void> _undoDeleteEvent(
      UndoDeleteEvent event, Emitter<DeleteState> emit) async {
    try {
      _undoTimer?.cancel();
      emit(UndoDeleteSuccessWithRefresh());
    } catch (e) {
      print("Undo failed");
      emit(DeleteFailure());
    }
  }
}
