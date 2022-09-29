part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  const SignInState._({
    this.status = CubitStatus.initial,
    this.result,
    this.message = '',
  });
  const SignInState.initial({required List<String?> ids})
      : this._(
          status: CubitStatus.initial,
        );
  const SignInState.loading()
      : this._(
          status: CubitStatus.loading,
        );

  const SignInState.success({required SignInResult? result}) : this._(status: CubitStatus.success, result: result);

  const SignInState.failure({message = ''}) : this._(status: CubitStatus.failure, message: message);

  final CubitStatus status;
  final SignInResult? result;
  final String message;

  @override
  List<Object> get props => [
        status,
        result ?? [],
        message,
      ];
}
