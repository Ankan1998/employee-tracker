part of '../delete_bloc.dart';

@immutable
abstract class DeleteState {}

class DeleteInitial extends DeleteState {}

class DeleteFailure extends DeleteState {}

class UndoDeleteSuccess extends DeleteState {}

class UndoDeleteSuccessWithRefresh extends DeleteState {}