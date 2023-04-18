import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class SettingStateCubit extends Equatable {
  const SettingStateCubit();
  @override
  List<Object> get props => [];
}

class SettingInitialState extends SettingStateCubit {}

class SetLanguageSuccessState extends SettingStateCubit {
  final Locale locale;
  const SetLanguageSuccessState({required this.locale});
  @override
  List<Object> get props => [locale];
}
