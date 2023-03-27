part of 'me_cubit.dart';

abstract class MeState extends Equatable {
  const MeState();

  @override
  List<Object> get props => [];
}

class MeInitial extends MeState {
  @override
  List<Object> get props => [];
}

class MeLoading extends MeState {
  @override
  List<Object> get props => [];
}

class MeLoaded extends MeState {
  final ModelUser? me;

  const MeLoaded({required this.me});
  @override
  List<Object> get props => [me!];
}

class MeError extends MeState {
  final String errorMessage;
  const MeError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
