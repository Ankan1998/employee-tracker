part of '../add_edit_bloc.dart';

@immutable
abstract class AddEditState {}

class AddEditInitial extends AddEditState {}

class AddEditSuccess extends AddEditState {}

class AddEditFailure extends AddEditState {}
