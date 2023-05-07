import 'dart:convert';
import 'dart:io';

import 'package:app_submission_flutter_intermediate/src/common/constants/constants_name.dart';
import 'package:app_submission_flutter_intermediate/src/common/utils/shared_preference_helper.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/login/login_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/login/login_response_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/register/register_model.dart';
import 'package:app_submission_flutter_intermediate/src/features/auth/models/register/register_response_model.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String registerEndpoint = '${ConstantsName.baseUrl}/register';
  final String loginEndpoint = '${ConstantsName.baseUrl}/login';

  Future<bool?> isLoggedIn() async {
    return SharedPreferencesHelper().state;
  }

  Future<RegisterResponseModel> register(
      {required RegisterModel registerModel}) async {
    final response = await http.post(
      Uri.parse(registerEndpoint),
      body: registerModel.toJson(),
    );
    if (response.statusCode == HttpStatus.created ||
        response.statusCode == HttpStatus.badRequest) {
      final data = RegisterResponseModel.fromJson(json.decode(response.body));
      return data;
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<LoginResponseModel> login({required LoginModel loginModel}) async {
    final response = await http.post(
      Uri.parse(loginEndpoint),
      body: loginModel.toJson(),
    );
    if (response.statusCode == HttpStatus.ok) {
      final data = LoginResponseModel.fromJson(json.decode(response.body));
      SharedPreferencesHelper().state = true;
      SharedPreferencesHelper().token = data.result.token;
      return data;
    } else {
      throw Exception('Failed to login user');
    }
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 2));
    SharedPreferencesHelper().state = false;
    SharedPreferencesHelper().token = '';
  }
}
