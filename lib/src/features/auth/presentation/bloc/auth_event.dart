part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class IsLoggedIn extends AuthEvent {}

class SetIsLoggedIn extends AuthEvent {
  final bool stateKey;
  const SetIsLoggedIn({required this.stateKey});
  @override
  List<Object> get props => [stateKey];
}

class RegisterAccountEvent extends AuthEvent {
  final RegisterModel registerModel;
  const RegisterAccountEvent({required this.registerModel});
  @override
  List<Object> get props => [registerModel];
}

class LoginAccountEvent extends AuthEvent {
  final LoginModel loginModel;
  const LoginAccountEvent({required this.loginModel});
  @override
  List<Object> get props => [loginModel];
}

class LogoutAccountEvent extends AuthEvent {
  const LogoutAccountEvent();
  @override
  List<Object> get props => [];
}
