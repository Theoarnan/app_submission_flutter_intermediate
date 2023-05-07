import 'dart:convert';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_stories_response_model.freezed.dart';
part 'post_stories_response_model.g.dart';

@freezed
class PostStoriesResponseModel with _$PostStoriesResponseModel {
  const factory PostStoriesResponseModel({
    required bool error,
    required String message,
  }) = _PostStoriesResponseModel;

  factory PostStoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PostStoriesResponseModelFromJson(json);

  factory PostStoriesResponseModel.fromMap(String source) =>
      _$PostStoriesResponseModelFromJson(
        json.decode(source),
      );
}
