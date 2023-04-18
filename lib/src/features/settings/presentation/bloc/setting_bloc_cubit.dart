import 'package:app_submission_flutter_intermediate/src/features/settings/presentation/bloc/setting_state_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingBlocCubit extends Cubit<SettingStateCubit> {
  SettingBlocCubit() : super(SettingInitialState());

  Locale _locale = const Locale('id');
  Locale get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    emit(SetLanguageSuccessState(locale: _locale));
  }
}
