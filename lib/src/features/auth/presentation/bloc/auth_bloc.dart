import 'package:app_submission_flutter_intermediate/src/features/auth/models/login/login_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/register/register_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_state.dart';
part 'auth_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({
    required this.authRepository,
  }) : super(AuthInitialState()) {
    on<IsLoggedIn>((event, emit) => _checkIsLoggedIn(event, emit));
    on<SetIsLoggedIn>((event, emit) => _setIsLoggedIn(event, emit));
    on<RegisterAccountEvent>((event, emit) => _registerAccount(event, emit));
    on<LogginAccountEvent>((event, emit) => _loginAccount(event, emit));
  }

  void _checkIsLoggedIn(
    IsLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final data = await authRepository.isLoggedIn();
      if (data == true) {
        emit(AuthenticatedState());
      }
      emit(UnAuthenticatedState(isLoggedIn: data));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void _setIsLoggedIn(
    SetIsLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoadingState());
    try {
      final preferences = await SharedPreferences.getInstance();
      await Future.delayed(const Duration(seconds: 3));
      preferences.setBool('state', false);
      add(IsLoggedIn());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void _registerAccount(
    RegisterAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      final data = await authRepository.register(
        registerModel: event.registerModel,
      );
      if (data.error) {
        emit(AuthErrorState(error: data.message));
      } else {
        emit(RegisterSuccessState());
      }
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void _loginAccount(
    LogginAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingState());
      await Future.delayed(const Duration(seconds: 2));
      await authRepository.login(
        loginModel: event.loginModel,
      );
      emit(LoginSuccessState());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
