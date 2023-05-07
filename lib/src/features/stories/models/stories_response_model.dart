import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stories_response_model.freezed.dart';
part 'stories_response_model.g.dart';

@freezed
class StoriesResponseModel with _$StoriesResponseModel {
  const factory StoriesResponseModel({
    required bool error,
    required String message,
    @JsonKey(name: "listStory") required List<StoriesModel> dataStory,
  }) = _StoriesResponseModel;

  factory StoriesResponseModel.fromJson(json) =>
      _$StoriesResponseModelFromJson(json);
}
