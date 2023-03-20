part of 'create_report_cubit.dart';

abstract class CreateReportState extends Equatable {
  const CreateReportState();

  @override
  List<Object> get props => [];
}

class CreateReportInitial extends CreateReportState {}

class CreateReportLoading extends CreateReportState {}

class CreateReportLoaded extends CreateReportState {
  final bool result;

  const CreateReportLoaded({required this.result});
  @override
  List<Object> get props => [result];
}

class CreateReportError extends CreateReportState {
  final String errorMessage;

  const CreateReportError({
    this.errorMessage = '',
  }) : super();
  @override
  List<Object> get props => [errorMessage];
}
