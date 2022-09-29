part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState({
    required this.status,
    this.me,
  });
  final AuthenticationStatusType? status;
  final MeResult? me;

  @override
  List<Object> get props => [status ?? AuthenticationStatusType.unknown, me!];
}

class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial() : super(status: AuthenticationStatusType.unknown);
  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  const AuthenticationLoading() : super(status: AuthenticationStatusType.unknown);
  @override
  List<Object> get props => [];
}

class AuthenticationAuthenticated extends AuthenticationState {
  const AuthenticationAuthenticated({
    required MeResult? me,
  }) : super(status: AuthenticationStatusType.authenticated, me: me);

  @override
  List<Object> get props => [me!];
}

class AuthenticationUnAuthenticated extends AuthenticationState {
  const AuthenticationUnAuthenticated() : super(status: AuthenticationStatusType.unauthenticated);
  @override
  List<Object> get props => [];
}

class AuthenticationUnknown extends AuthenticationState {
  const AuthenticationUnknown() : super(status: AuthenticationStatusType.unknown);
  @override
  List<Object> get props => [];
}

class AuthenticationError extends AuthenticationState {
  final String errorMessage;

  const AuthenticationError({
    this.errorMessage = '',
  }) : super(status: AuthenticationStatusType.unknown);
  @override
  List<Object> get props => [];
}
