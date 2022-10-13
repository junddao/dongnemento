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
  final SocialType socialType;
  final String? email;
  final String? password;
  const AuthenticationSignIn({
    required this.socialType,
    this.email,
    this.password,
  });

  @override
  List<Object> get props => [socialType, email!, password!];
}

class AuthenticationSignOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}
