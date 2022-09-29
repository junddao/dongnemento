part of 'me_cubit.dart';

class MeState extends Equatable {
  const MeState._({
    this.status = CubitStatus.initial,
    this.result,
    this.message = '',
  });
  const MeState.initial({required List<String?> ids})
      : this._(
          status: CubitStatus.initial,
        );
  const MeState.loading()
      : this._(
          status: CubitStatus.loading,
        );

  const MeState.success({required MeResult? result}) : this._(status: CubitStatus.success, result: result);

  const MeState.failure({message = ''}) : this._(status: CubitStatus.failure, message: message);

  final CubitStatus status;
  final MeResult? result;
  final String message;

  @override
  List<Object> get props => [
        status,
        result ?? [],
        message,
      ];
}