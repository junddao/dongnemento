part of 'singleton_me_cubit.dart';

abstract class SingletonMeState extends Equatable {
  const SingletonMeState();

  @override
  List<Object> get props => [];
}

class SingletonMeInitial extends SingletonMeState {}

class SingletonMeLoading extends SingletonMeState {
  @override
  List<Object> get props => [];
}

class SingletonMeLoaded extends SingletonMeState {
  final ModelUser singletonMe;

  const SingletonMeLoaded({required this.singletonMe});
  @override
  List<Object> get props => [singletonMe];
}

class SingletonMeError extends SingletonMeState {}
