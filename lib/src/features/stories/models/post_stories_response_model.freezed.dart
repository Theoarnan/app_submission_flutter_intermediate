// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'post_stories_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PostStoriesResponseModel _$PostStoriesResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PostStoriesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PostStoriesResponseModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PostStoriesResponseModelCopyWith<PostStoriesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostStoriesResponseModelCopyWith<$Res> {
  factory $PostStoriesResponseModelCopyWith(PostStoriesResponseModel value,
          $Res Function(PostStoriesResponseModel) then) =
      _$PostStoriesResponseModelCopyWithImpl<$Res, PostStoriesResponseModel>;
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class _$PostStoriesResponseModelCopyWithImpl<$Res,
        $Val extends PostStoriesResponseModel>
    implements $PostStoriesResponseModelCopyWith<$Res> {
  _$PostStoriesResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
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
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostStoriesResponseModelCopyWith<$Res>
    implements $PostStoriesResponseModelCopyWith<$Res> {
  factory _$$_PostStoriesResponseModelCopyWith(
          _$_PostStoriesResponseModel value,
          $Res Function(_$_PostStoriesResponseModel) then) =
      __$$_PostStoriesResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message});
}

/// @nodoc
class __$$_PostStoriesResponseModelCopyWithImpl<$Res>
    extends _$PostStoriesResponseModelCopyWithImpl<$Res,
        _$_PostStoriesResponseModel>
    implements _$$_PostStoriesResponseModelCopyWith<$Res> {
  __$$_PostStoriesResponseModelCopyWithImpl(_$_PostStoriesResponseModel _value,
      $Res Function(_$_PostStoriesResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
  }) {
    return _then(_$_PostStoriesResponseModel(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PostStoriesResponseModel implements _PostStoriesResponseModel {
  const _$_PostStoriesResponseModel(
      {required this.error, required this.message});

  factory _$_PostStoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_PostStoriesResponseModelFromJson(json);

  @override
  final bool error;
  @override
  final String message;

  @override
  String toString() {
    return 'PostStoriesResponseModel(error: $error, message: $message)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostStoriesResponseModel &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostStoriesResponseModelCopyWith<_$_PostStoriesResponseModel>
      get copyWith => __$$_PostStoriesResponseModelCopyWithImpl<
          _$_PostStoriesResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PostStoriesResponseModelToJson(
      this,
    );
  }
}

abstract class _PostStoriesResponseModel implements PostStoriesResponseModel {
  const factory _PostStoriesResponseModel(
      {required final bool error,
      required final String message}) = _$_PostStoriesResponseModel;

  factory _PostStoriesResponseModel.fromJson(Map<String, dynamic> json) =
      _$_PostStoriesResponseModel.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$_PostStoriesResponseModelCopyWith<_$_PostStoriesResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
