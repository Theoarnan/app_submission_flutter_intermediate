import 'dart:convert';

class PostStoriesResponseModel {
  final bool error;
  final String message;

  PostStoriesResponseModel({
    required this.error,
    required this.message,
  });

  factory PostStoriesResponseModel.fromMap(Map<String, dynamic> map) {
    return PostStoriesResponseModel(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }

  factory PostStoriesResponseModel.fromJson(String source) =>
      PostStoriesResponseModel.fromMap(
        json.decode(source),
      );
}
