import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_result_model.freezed.dart';
part 'login_result_model.g.dart';

@freezed
class LoginResultModel with _$LoginResultModel {
  const factory LoginResultModel({
    required String userId,
    required String name,
    required String token,
  }) = _LoginResultModel;

  factory LoginResultModel.fromJson(json) => _$LoginResultModelFromJson(json);
}
