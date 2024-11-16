part of '../delete_bloc.dart';

@immutable
abstract class DeleteEvent {}

class DeleteRecordEvent extends DeleteEvent {
  final int empId;

  DeleteRecordEvent(this.empId);
}

class UndoDeleteEvent extends DeleteEvent {}
