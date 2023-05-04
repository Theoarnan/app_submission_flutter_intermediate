import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static late SharedPreferences _sharedPrefs;
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();
  factory SharedPreferencesHelper() => _instance;

  SharedPreferencesHelper._internal();

  Future<void> init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  String get token => _sharedPrefs.getString('token') ?? '';
  bool get state => _sharedPrefs.getBool('state') ?? false;
  String get language => _sharedPrefs.getString('language') ?? '';

  set token(String token) {
    _sharedPrefs.setString('token', token);
  }

  set state(bool state) {
    _sharedPrefs.setBool('state', state);
  }

  set language(String languageId) {
    _sharedPrefs.setString('language', languageId);
  }
}
