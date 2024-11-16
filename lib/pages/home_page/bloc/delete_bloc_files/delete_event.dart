part of '../delete_bloc.dart';

@immutable
abstract class DeleteEvent {}

class DeleteRecordEvent extends DeleteEvent {
  final int empId;

  DeleteRecordEvent(this.empId);
}

class DeleteRecordFromEditEvent extends DeleteEvent {
  final int empId;

  DeleteRecordFromEditEvent(this.empId);
}

class UndoDeleteEvent extends DeleteEvent {}
