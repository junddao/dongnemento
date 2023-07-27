part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusInit extends AuthenticationEvent {
  const AuthenticationStatusInit();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {
  const AuthenticationStatusChanged({required this.status});

  final AuthenticationStatusType status;

  @override
  List<Object> get props => [status];
}

class AuthenticationSignIn extends AuthenticationEvent {
  final SocialType socialType;
  final Map<String, dynamic> input;
  const AuthenticationSignIn({
    required this.socialType,
    required this.input,
  });

  @override
  List<Object> get props => [socialType, input];
}

class AuthenticationSignOut extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationMeChange extends AuthenticationEvent {
  final ModelUser me;

  const AuthenticationMeChange({required this.me});
  @override
  List<Object> get props => [me];
}
