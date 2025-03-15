part of 'nutration_bloc.dart';

sealed class NutrationEvent extends Equatable {
  const NutrationEvent();

  @override
  List<Object> get props => [];
}

class GetUserMealsEvent extends NutrationEvent {}
