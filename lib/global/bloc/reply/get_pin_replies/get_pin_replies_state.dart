part of 'get_pin_replies_cubit.dart';

abstract class GetPinRepliesState extends Equatable {
  const GetPinRepliesState();

  @override
  List<Object> get props => [];
}

class GetPinRepliesInitial extends GetPinRepliesState {}

class GetPinRepliesLoading extends GetPinRepliesState {}

class GetPinRepliesLoaded extends GetPinRepliesState {
  final ModelResponseGetPinReplies result;

  const GetPinRepliesLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class GetPinRepliesError extends GetPinRepliesState {
  final String errorMessage;

  const GetPinRepliesError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
