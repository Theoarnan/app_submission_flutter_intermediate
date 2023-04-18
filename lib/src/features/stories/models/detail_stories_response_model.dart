import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';

class DetailStoriesResponseModel {
  final bool error;
  final String message;
  final StoriesModel dataStory;

  DetailStoriesResponseModel({
    required this.error,
    required this.message,
    required this.dataStory,
  });

  factory DetailStoriesResponseModel.fromMap(Map<String, dynamic> map) {
    return DetailStoriesResponseModel(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
      dataStory: StoriesModel.fromMap(
        map['story'],
      ),
    );
  }
}
