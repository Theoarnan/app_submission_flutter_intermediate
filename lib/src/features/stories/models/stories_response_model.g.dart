// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoriesResponseModel _$$_StoriesResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_StoriesResponseModel(
      error: json['error'] as bool,
      message: json['message'] as String,
      dataStory: (json['listStory'] as List<dynamic>)
          .map(StoriesModel.fromJson)
          .toList(),
    );

Map<String, dynamic> _$$_StoriesResponseModelToJson(
        _$_StoriesResponseModel instance) =>
    <String, dynamic>{
      'error': instance.error,
      'message': instance.message,
      'listStory': instance.dataStory,
    };
