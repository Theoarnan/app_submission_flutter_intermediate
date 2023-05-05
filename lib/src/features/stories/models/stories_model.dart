import 'package:freezed_annotation/freezed_annotation.dart';

part 'stories_model.freezed.dart';
part 'stories_model.g.dart';

@freezed
class StoriesModel with _$StoriesModel {
  const factory StoriesModel({
    required String id,
    required String name,
    required String description,
    required String photoUrl,
    required String createdAt,
    required num? lat,
    required num? lon,
  }) = _StoriesModel;

  factory StoriesModel.fromJson(json) => _$StoriesModelFromJson(json);
}
