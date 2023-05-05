// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stories_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_StoriesModel _$$_StoriesModelFromJson(Map<String, dynamic> json) =>
    _$_StoriesModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      photoUrl: json['photoUrl'] as String,
      createdAt: json['createdAt'] as String,
      lat: json['lat'] as num?,
      lon: json['lon'] as num?,
    );

Map<String, dynamic> _$$_StoriesModelToJson(_$_StoriesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'photoUrl': instance.photoUrl,
      'createdAt': instance.createdAt,
      'lat': instance.lat,
      'lon': instance.lon,
    };
