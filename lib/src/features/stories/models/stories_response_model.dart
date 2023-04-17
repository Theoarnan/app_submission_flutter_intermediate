import 'package:app_submission_flutter_intermediate/src/features/stories/models/stories_model.dart';

class StoriesResponseModel {
  final bool error;
  final String message;
  final List<StoriesModel> dataStory;

  StoriesResponseModel({
    required this.error,
    required this.message,
    required this.dataStory,
  });

  factory StoriesResponseModel.fromMap(Map<String, dynamic> map) {
    return StoriesResponseModel(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
      dataStory: (map['listStory'] as List)
          .map((data) => StoriesModel.fromMap(data))
          .toList(),
    );
  }
}
