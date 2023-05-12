import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_stories_response_model.freezed.dart';
part 'detail_stories_response_model.g.dart';

@freezed
class DetailStoriesResponseModel with _$DetailStoriesResponseModel {
  const factory DetailStoriesResponseModel({
    required bool error,
    required String message,
    // ignore: invalid_annotation_target
    @JsonKey(name: "story") required StoriesModel dataStory,
  }) = _DetailStoriesResponseModel;

  factory DetailStoriesResponseModel.fromJson(json) =>
      _$DetailStoriesResponseModelFromJson(json);
}
