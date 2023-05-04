part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  @override
  List<Object?> get props => [];
}

class AuthInitialState extends AuthState {}

class AuthLoadingState extends AuthState {}

class RegisterSuccessState extends AuthState {
  final LoginModel data;
  const RegisterSuccessState({required this.data});
  @override
  List<Object?> get props => [data];
}

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
