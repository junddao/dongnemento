part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged(this.status);

  final AuthenticationStatusType status;

  @override
  List<Object> get props => [status];
}

class AuthenticationSignIn extends AuthenticationEvent {
  final SignInInput input;
  const AuthenticationSignIn({
    required this.input,
  });

  @override
  List<Object> get props => [input];
}

class AuthenticationSignOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
