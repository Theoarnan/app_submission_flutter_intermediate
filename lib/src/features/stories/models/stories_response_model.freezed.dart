// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stories_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StoriesResponseModel _$StoriesResponseModelFromJson(Map<String, dynamic> json) {
  return _StoriesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$StoriesResponseModel {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: "listStory")
  List<StoriesModel> get dataStory => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StoriesResponseModelCopyWith<StoriesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoriesResponseModelCopyWith<$Res> {
  factory $StoriesResponseModelCopyWith(StoriesResponseModel value,
          $Res Function(StoriesResponseModel) then) =
      _$StoriesResponseModelCopyWithImpl<$Res, StoriesResponseModel>;
  @useResult
  $Res call(
      {bool error,
      String message,
      @JsonKey(name: "listStory") List<StoriesModel> dataStory});
}

/// @nodoc
class _$StoriesResponseModelCopyWithImpl<$Res,
        $Val extends StoriesResponseModel>
    implements $StoriesResponseModelCopyWith<$Res> {
  _$StoriesResponseModelCopyWithImpl(this._value, this._then);

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
              as List<StoriesModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_StoriesResponseModelCopyWith<$Res>
    implements $StoriesResponseModelCopyWith<$Res> {
  factory _$$_StoriesResponseModelCopyWith(_$_StoriesResponseModel value,
          $Res Function(_$_StoriesResponseModel) then) =
      __$$_StoriesResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool error,
      String message,
      @JsonKey(name: "listStory") List<StoriesModel> dataStory});
}

/// @nodoc
class __$$_StoriesResponseModelCopyWithImpl<$Res>
    extends _$StoriesResponseModelCopyWithImpl<$Res, _$_StoriesResponseModel>
    implements _$$_StoriesResponseModelCopyWith<$Res> {
  __$$_StoriesResponseModelCopyWithImpl(_$_StoriesResponseModel _value,
      $Res Function(_$_StoriesResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? dataStory = null,
  }) {
    return _then(_$_StoriesResponseModel(
      error: null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as bool,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      dataStory: null == dataStory
          ? _value._dataStory
          : dataStory // ignore: cast_nullable_to_non_nullable
              as List<StoriesModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_StoriesResponseModel implements _StoriesResponseModel {
  const _$_StoriesResponseModel(
      {required this.error,
      required this.message,
      @JsonKey(name: "listStory") required final List<StoriesModel> dataStory})
      : _dataStory = dataStory;

  factory _$_StoriesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_StoriesResponseModelFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  final List<StoriesModel> _dataStory;
  @override
  @JsonKey(name: "listStory")
  List<StoriesModel> get dataStory {
    if (_dataStory is EqualUnmodifiableListView) return _dataStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dataStory);
  }

  @override
  String toString() {
    return 'StoriesResponseModel(error: $error, message: $message, dataStory: $dataStory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_StoriesResponseModel &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality()
                .equals(other._dataStory, _dataStory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, error, message,
      const DeepCollectionEquality().hash(_dataStory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_StoriesResponseModelCopyWith<_$_StoriesResponseModel> get copyWith =>
      __$$_StoriesResponseModelCopyWithImpl<_$_StoriesResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_StoriesResponseModelToJson(
      this,
    );
  }
}

abstract class _StoriesResponseModel implements StoriesResponseModel {
  const factory _StoriesResponseModel(
          {required final bool error,
          required final String message,
          @JsonKey(name: "listStory")
              required final List<StoriesModel> dataStory}) =
      _$_StoriesResponseModel;

  factory _StoriesResponseModel.fromJson(Map<String, dynamic> json) =
      _$_StoriesResponseModel.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  @JsonKey(name: "listStory")
  List<StoriesModel> get dataStory;
  @override
  @JsonKey(ignore: true)
  _$$_StoriesResponseModelCopyWith<_$_StoriesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
