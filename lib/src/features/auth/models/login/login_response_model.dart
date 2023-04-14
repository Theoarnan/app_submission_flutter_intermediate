import 'package:app_submission_flutter_intermediate/src/features/auth/models/login/login_result_model.dart';

class LoginResponseModel {
  final bool error;
  final String message;
  final LoginResultModel result;

  LoginResponseModel({
    required this.error,
    required this.message,
    required this.result,
  });

  factory LoginResponseModel.fromMap(Map<String, dynamic> map) {
    return LoginResponseModel(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
      result: LoginResultModel.fromMap(map['loginResult']),
    );
  }
}
