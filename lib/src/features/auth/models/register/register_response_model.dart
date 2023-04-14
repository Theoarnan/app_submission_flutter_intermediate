class RegisterResponseModel {
  final bool error;
  final String message;

  RegisterResponseModel({
    required this.error,
    required this.message,
  });

  factory RegisterResponseModel.fromMap(Map<String, dynamic> map) {
    return RegisterResponseModel(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }
}
