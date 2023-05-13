import 'package:app_submission_flutter_intermediate/src/features/auth/models/login/login_result_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_response_model.freezed.dart';
part 'login_response_model.g.dart';

@freezed
class LoginResponseModel with _$LoginResponseModel {
  const factory LoginResponseModel({
    required bool error,
    required String message,
    // ignore: invalid_annotation_target
    @JsonKey(name: "loginResult") required LoginResultModel result,
  }) = _LoginResponseModel;

  factory LoginResponseModel.fromJson(json) =>
      _$LoginResponseModelFromJson(json);
}
