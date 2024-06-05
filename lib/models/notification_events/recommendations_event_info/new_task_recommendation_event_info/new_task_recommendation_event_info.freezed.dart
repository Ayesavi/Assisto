// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'new_task_recommendation_event_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewTaskRecommendationEventInfo _$NewTaskRecommendationEventInfoFromJson(
    Map<String, dynamic> json) {
  return _NewTaskRecommendationEventInfo.fromJson(json);
}

/// @nodoc
mixin _$NewTaskRecommendationEventInfo {
  @JsonKey(name: 'task_id')
  String get taskId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewTaskRecommendationEventInfoCopyWith<NewTaskRecommendationEventInfo>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewTaskRecommendationEventInfoCopyWith<$Res> {
  factory $NewTaskRecommendationEventInfoCopyWith(
          NewTaskRecommendationEventInfo value,
          $Res Function(NewTaskRecommendationEventInfo) then) =
      _$NewTaskRecommendationEventInfoCopyWithImpl<$Res,
          NewTaskRecommendationEventInfo>;
  @useResult
  $Res call({@JsonKey(name: 'task_id') String taskId});
}

/// @nodoc
class _$NewTaskRecommendationEventInfoCopyWithImpl<$Res,
        $Val extends NewTaskRecommendationEventInfo>
    implements $NewTaskRecommendationEventInfoCopyWith<$Res> {
  _$NewTaskRecommendationEventInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_value.copyWith(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewTaskRecommendationEventInfoImplCopyWith<$Res>
    implements $NewTaskRecommendationEventInfoCopyWith<$Res> {
  factory _$$NewTaskRecommendationEventInfoImplCopyWith(
          _$NewTaskRecommendationEventInfoImpl value,
          $Res Function(_$NewTaskRecommendationEventInfoImpl) then) =
      __$$NewTaskRecommendationEventInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'task_id') String taskId});
}

/// @nodoc
class __$$NewTaskRecommendationEventInfoImplCopyWithImpl<$Res>
    extends _$NewTaskRecommendationEventInfoCopyWithImpl<$Res,
        _$NewTaskRecommendationEventInfoImpl>
    implements _$$NewTaskRecommendationEventInfoImplCopyWith<$Res> {
  __$$NewTaskRecommendationEventInfoImplCopyWithImpl(
      _$NewTaskRecommendationEventInfoImpl _value,
      $Res Function(_$NewTaskRecommendationEventInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$NewTaskRecommendationEventInfoImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewTaskRecommendationEventInfoImpl
    implements _NewTaskRecommendationEventInfo {
  const _$NewTaskRecommendationEventInfoImpl(
      {@JsonKey(name: 'task_id') required this.taskId});

  factory _$NewTaskRecommendationEventInfoImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$NewTaskRecommendationEventInfoImplFromJson(json);

  @override
  @JsonKey(name: 'task_id')
  final String taskId;

  @override
  String toString() {
    return 'NewTaskRecommendationEventInfo(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewTaskRecommendationEventInfoImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewTaskRecommendationEventInfoImplCopyWith<
          _$NewTaskRecommendationEventInfoImpl>
      get copyWith => __$$NewTaskRecommendationEventInfoImplCopyWithImpl<
          _$NewTaskRecommendationEventInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewTaskRecommendationEventInfoImplToJson(
      this,
    );
  }
}

abstract class _NewTaskRecommendationEventInfo
    implements NewTaskRecommendationEventInfo {
  const factory _NewTaskRecommendationEventInfo(
          {@JsonKey(name: 'task_id') required final String taskId}) =
      _$NewTaskRecommendationEventInfoImpl;

  factory _NewTaskRecommendationEventInfo.fromJson(Map<String, dynamic> json) =
      _$NewTaskRecommendationEventInfoImpl.fromJson;

  @override
  @JsonKey(name: 'task_id')
  String get taskId;
  @override
  @JsonKey(ignore: true)
  _$$NewTaskRecommendationEventInfoImplCopyWith<
          _$NewTaskRecommendationEventInfoImpl>
      get copyWith => throw _privateConstructorUsedError;
}
