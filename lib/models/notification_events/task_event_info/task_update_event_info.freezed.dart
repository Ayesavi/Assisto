// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_update_event_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskUpdateEventInfo _$TaskUpdateEventInfoFromJson(Map<String, dynamic> json) {
  return _TaskUpdateEventInfo.fromJson(json);
}

/// @nodoc
mixin _$TaskUpdateEventInfo {
  @JsonKey(name: "task_id")
  String get taskId => throw _privateConstructorUsedError;

  /// Serializes this TaskUpdateEventInfo to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskUpdateEventInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskUpdateEventInfoCopyWith<TaskUpdateEventInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskUpdateEventInfoCopyWith<$Res> {
  factory $TaskUpdateEventInfoCopyWith(
          TaskUpdateEventInfo value, $Res Function(TaskUpdateEventInfo) then) =
      _$TaskUpdateEventInfoCopyWithImpl<$Res, TaskUpdateEventInfo>;
  @useResult
  $Res call({@JsonKey(name: "task_id") String taskId});
}

/// @nodoc
class _$TaskUpdateEventInfoCopyWithImpl<$Res, $Val extends TaskUpdateEventInfo>
    implements $TaskUpdateEventInfoCopyWith<$Res> {
  _$TaskUpdateEventInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskUpdateEventInfo
  /// with the given fields replaced by the non-null parameter values.
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
abstract class _$$TaskUpdateEventInfoImplCopyWith<$Res>
    implements $TaskUpdateEventInfoCopyWith<$Res> {
  factory _$$TaskUpdateEventInfoImplCopyWith(_$TaskUpdateEventInfoImpl value,
          $Res Function(_$TaskUpdateEventInfoImpl) then) =
      __$$TaskUpdateEventInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: "task_id") String taskId});
}

/// @nodoc
class __$$TaskUpdateEventInfoImplCopyWithImpl<$Res>
    extends _$TaskUpdateEventInfoCopyWithImpl<$Res, _$TaskUpdateEventInfoImpl>
    implements _$$TaskUpdateEventInfoImplCopyWith<$Res> {
  __$$TaskUpdateEventInfoImplCopyWithImpl(_$TaskUpdateEventInfoImpl _value,
      $Res Function(_$TaskUpdateEventInfoImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskUpdateEventInfo
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? taskId = null,
  }) {
    return _then(_$TaskUpdateEventInfoImpl(
      taskId: null == taskId
          ? _value.taskId
          : taskId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskUpdateEventInfoImpl implements _TaskUpdateEventInfo {
  const _$TaskUpdateEventInfoImpl(
      {@JsonKey(name: "task_id") required this.taskId});

  factory _$TaskUpdateEventInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskUpdateEventInfoImplFromJson(json);

  @override
  @JsonKey(name: "task_id")
  final String taskId;

  @override
  String toString() {
    return 'TaskUpdateEventInfo(taskId: $taskId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskUpdateEventInfoImpl &&
            (identical(other.taskId, taskId) || other.taskId == taskId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, taskId);

  /// Create a copy of TaskUpdateEventInfo
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskUpdateEventInfoImplCopyWith<_$TaskUpdateEventInfoImpl> get copyWith =>
      __$$TaskUpdateEventInfoImplCopyWithImpl<_$TaskUpdateEventInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskUpdateEventInfoImplToJson(
      this,
    );
  }
}

abstract class _TaskUpdateEventInfo implements TaskUpdateEventInfo {
  const factory _TaskUpdateEventInfo(
          {@JsonKey(name: "task_id") required final String taskId}) =
      _$TaskUpdateEventInfoImpl;

  factory _TaskUpdateEventInfo.fromJson(Map<String, dynamic> json) =
      _$TaskUpdateEventInfoImpl.fromJson;

  @override
  @JsonKey(name: "task_id")
  String get taskId;

  /// Create a copy of TaskUpdateEventInfo
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskUpdateEventInfoImplCopyWith<_$TaskUpdateEventInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
