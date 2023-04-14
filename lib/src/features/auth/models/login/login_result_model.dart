class LoginResultModel {
  final String userId;
  final String name;
  final String token;

  LoginResultModel({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResultModel.fromMap(Map<String, dynamic> map) {
    return LoginResultModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      token: map['token'] ?? '',
    );
  }
}
