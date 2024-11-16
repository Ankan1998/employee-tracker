part of '../home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeLoading extends HomeState {}

class HomeListEmpty extends HomeState {}

class HomeSuccess extends HomeState {
  final List<EmployeeModel> empModelList;
  HomeSuccess(this.empModelList);
}

class HomeFailure extends HomeState {}
