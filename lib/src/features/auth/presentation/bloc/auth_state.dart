part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {}

class LoginSuccessState extends AuthState {}

class AuthErrorState extends AuthState {
  final String error;
  const AuthErrorState({required this.error});
  @override
  List<Object?> get props => [error];
}

class AuthenticatedState extends AuthState {}

class UnAuthenticatedState extends AuthState {
  final bool? isLoggedIn;
  const UnAuthenticatedState({this.isLoggedIn});
  @override
  List<Object?> get props => [isLoggedIn];
}
