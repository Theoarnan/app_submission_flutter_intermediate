// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_stories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_DetailStoriesResponseModel _$$_DetailStoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_DetailStoriesResponseModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      dataStory: StoriesModel.fromJson(json['story']),
    );

Map<String, dynamic> _$$_DetailStoriesResponseModelToJson(
        _$_DetailStoriesResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'story': instance.dataStory,
    };
