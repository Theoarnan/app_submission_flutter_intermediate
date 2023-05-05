// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'detail_stories_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

DetailStoriesResponseModel _$DetailStoriesResponseModelFromJson(
    Map<String, dynamic> json) {
  return _DetailStoriesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$DetailStoriesResponseModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: "story")
  StoriesModel get dataStory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DetailStoriesResponseModelCopyWith<DetailStoriesResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetailStoriesResponseModelCopyWith<$Res> {
  factory $DetailStoriesResponseModelCopyWith(DetailStoriesResponseModel value,
          $Res Function(DetailStoriesResponseModel) then) =
      _$DetailStoriesResponseModelCopyWithImpl<$Res,
          DetailStoriesResponseModel>;
  @useResult
  $Res call(
      {bool error,
      String message,
      @JsonKey(name: "story") StoriesModel dataStory});

  $StoriesModelCopyWith<$Res> get dataStory;
}

/// @nodoc
class _$DetailStoriesResponseModelCopyWithImpl<$Res,
        $Val extends DetailStoriesResponseModel>
    implements $DetailStoriesResponseModelCopyWith<$Res> {
  _$DetailStoriesResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? dataStory = null,
  }) {
    return _then(_value.copyWith(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      dataStory: null == dataStory
          ? _value.dataStory
          : dataStory // ignore: cast_nullable_to_non_nullable
              as StoriesModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $StoriesModelCopyWith<$Res> get dataStory {
    return $StoriesModelCopyWith<$Res>(_value.dataStory, (value) {
      return _then(_value.copyWith(dataStory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_DetailStoriesResponseModelCopyWith<$Res>
    implements $DetailStoriesResponseModelCopyWith<$Res> {
  factory _$$_DetailStoriesResponseModelCopyWith(
          _$_DetailStoriesResponseModel value,
          $Res Function(_$_DetailStoriesResponseModel) then) =
      __$$_DetailStoriesResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool error,
      String message,
      @JsonKey(name: "story") StoriesModel dataStory});

  @override
  $StoriesModelCopyWith<$Res> get dataStory;
}

/// @nodoc
class __$$_DetailStoriesResponseModelCopyWithImpl<$Res>
    extends _$DetailStoriesResponseModelCopyWithImpl<$Res,
        _$_DetailStoriesResponseModel>
    implements _$$_DetailStoriesResponseModelCopyWith<$Res> {
  __$$_DetailStoriesResponseModelCopyWithImpl(
      _$_DetailStoriesResponseModel _value,
      $Res Function(_$_DetailStoriesResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? dataStory = null,
  }) {
    return _then(_$_DetailStoriesResponseModel(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      dataStory: null == dataStory
          ? _value.dataStory
          : dataStory // ignore: cast_nullable_to_non_nullable
              as StoriesModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_DetailStoriesResponseModel implements _DetailStoriesResponseModel {
  const _$_DetailStoriesResponseModel(
      {required this.error,
      required this.message,
      @JsonKey(name: "story") required this.dataStory});

  factory _$_DetailStoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_DetailStoriesResponseModelFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  @override
  @JsonKey(name: "story")
  final StoriesModel dataStory;

  @override
  String toString() {
    return 'DetailStoriesResponseModel(error: $error, message: $message, dataStory: $dataStory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_DetailStoriesResponseModel &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.dataStory, dataStory) ||
                other.dataStory == dataStory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, dataStory);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_DetailStoriesResponseModelCopyWith<_$_DetailStoriesResponseModel>
      get copyWith => __$$_DetailStoriesResponseModelCopyWithImpl<
          _$_DetailStoriesResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_DetailStoriesResponseModelToJson(
      this,
    );
  }
}

abstract class _DetailStoriesResponseModel
    implements DetailStoriesResponseModel {
  const factory _DetailStoriesResponseModel(
          {required final bool error,
          required final String message,
          @JsonKey(name: "story") required final StoriesModel dataStory}) =
      _$_DetailStoriesResponseModel;

  factory _DetailStoriesResponseModel.fromJson(Map<String, dynamic> json) =
      _$_DetailStoriesResponseModel.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(name: "story")
  StoriesModel get dataStory;
  @override
  @JsonKey(ignore: true)
  _$$_DetailStoriesResponseModelCopyWith<_$_DetailStoriesResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
