import 'package:app_submission_flutter_intermediate/src/common/utils/shared_preference_helper.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/login/login_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/register/register_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    on<LoginAccountEvent>((event, emit) => _loginAccount(event, emit));
    on<LogoutAccountEvent>((event, emit) => _logoutAccount(event, emit));
  }

  void _checkIsLoggedIn(
    IsLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final bool? data = await authRepository.isLoggedIn();
      if (data == true) {
        emit(AuthenticatedState());
      } else {
        emit(UnAuthenticatedState(isLoggedIn: data));
      }
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void _setIsLoggedIn(
    SetIsLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    try {
      SharedPreferencesHelper().state = event.stateKey;
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
      final data = await authRepository.register(
        registerModel: event.registerModel,
      );
      if (data.error) return emit(AuthErrorState(error: data.message));
      emit(
        RegisterSuccessState(
          data: LoginModel(
            email: event.registerModel.email,
            password: event.registerModel.password,
          ),
        ),
      );
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void _loginAccount(
    LoginAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingState());
      await authRepository.login(loginModel: event.loginModel);
      emit(LoginSuccessState());
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }

  void _logoutAccount(
    LogoutAccountEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoadingState());
      await authRepository.logout();
      emit(const UnAuthenticatedState(isLoggedIn: false));
    } catch (e) {
      emit(AuthErrorState(error: e.toString()));
    }
  }
}
