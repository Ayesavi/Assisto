// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  String get ownerId =>
      throw _privateConstructorUsedError; // where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  ({double lat, double lng})? get attachedLocation =>
      throw _privateConstructorUsedError;
  List<String> get relevantTags => throw _privateConstructorUsedError;
  DateTime? get taskDeadline => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Gender? get gender => throw _privateConstructorUsedError;
  int? get age => throw _privateConstructorUsedError;
  double? get expectedPrice => throw _privateConstructorUsedError;
  TaskStatus get status =>
      throw _privateConstructorUsedError; // id stays an empty string when a new task is created
// id will be assigned by the server.
  String get id => throw _privateConstructorUsedError;
  String? get assigned => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call(
      {String ownerId,
      ({double lat, double lng})? attachedLocation,
      List<String> relevantTags,
      DateTime? taskDeadline,
      String title,
      String description,
      Gender? gender,
      int? age,
      double? expectedPrice,
      TaskStatus status,
      String id,
      String? assigned,
      DateTime createdAt});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerId = null,
    Object? attachedLocation = freezed,
    Object? relevantTags = null,
    Object? taskDeadline = freezed,
    Object? title = null,
    Object? description = null,
    Object? gender = freezed,
    Object? age = freezed,
    Object? expectedPrice = freezed,
    Object? status = null,
    Object? id = null,
    Object? assigned = freezed,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      attachedLocation: freezed == attachedLocation
          ? _value.attachedLocation
          : attachedLocation // ignore: cast_nullable_to_non_nullable
              as ({double lat, double lng})?,
      relevantTags: null == relevantTags
          ? _value.relevantTags
          : relevantTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      taskDeadline: freezed == taskDeadline
          ? _value.taskDeadline
          : taskDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      expectedPrice: freezed == expectedPrice
          ? _value.expectedPrice
          : expectedPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assigned: freezed == assigned
          ? _value.assigned
          : assigned // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskModelImplCopyWith<$Res>
    implements $TaskModelCopyWith<$Res> {
  factory _$$TaskModelImplCopyWith(
          _$TaskModelImpl value, $Res Function(_$TaskModelImpl) then) =
      __$$TaskModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ownerId,
      ({double lat, double lng})? attachedLocation,
      List<String> relevantTags,
      DateTime? taskDeadline,
      String title,
      String description,
      Gender? gender,
      int? age,
      double? expectedPrice,
      TaskStatus status,
      String id,
      String? assigned,
      DateTime createdAt});
}

/// @nodoc
class __$$TaskModelImplCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$TaskModelImpl>
    implements _$$TaskModelImplCopyWith<$Res> {
  __$$TaskModelImplCopyWithImpl(
      _$TaskModelImpl _value, $Res Function(_$TaskModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerId = null,
    Object? attachedLocation = freezed,
    Object? relevantTags = null,
    Object? taskDeadline = freezed,
    Object? title = null,
    Object? description = null,
    Object? gender = freezed,
    Object? age = freezed,
    Object? expectedPrice = freezed,
    Object? status = null,
    Object? id = null,
    Object? assigned = freezed,
    Object? createdAt = null,
  }) {
    return _then(_$TaskModelImpl(
      ownerId: null == ownerId
          ? _value.ownerId
          : ownerId // ignore: cast_nullable_to_non_nullable
              as String,
      attachedLocation: freezed == attachedLocation
          ? _value.attachedLocation
          : attachedLocation // ignore: cast_nullable_to_non_nullable
              as ({double lat, double lng})?,
      relevantTags: null == relevantTags
          ? _value._relevantTags
          : relevantTags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      taskDeadline: freezed == taskDeadline
          ? _value.taskDeadline
          : taskDeadline // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      gender: freezed == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender?,
      age: freezed == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int?,
      expectedPrice: freezed == expectedPrice
          ? _value.expectedPrice
          : expectedPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      assigned: freezed == assigned
          ? _value.assigned
          : assigned // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskModelImpl implements _TaskModel {
  const _$TaskModelImpl(
      {this.ownerId = '',
      this.attachedLocation,
      required final List<String> relevantTags,
      this.taskDeadline,
      required this.title,
      required this.description,
      this.gender,
      this.age,
      this.expectedPrice,
      this.status = TaskStatus.unassigned,
      this.id = '',
      this.assigned,
      required this.createdAt})
      : _relevantTags = relevantTags;

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  @JsonKey()
  final String ownerId;
// where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @override
  final ({double lat, double lng})? attachedLocation;
  final List<String> _relevantTags;
  @override
  List<String> get relevantTags {
    if (_relevantTags is EqualUnmodifiableListView) return _relevantTags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_relevantTags);
  }

  @override
  final DateTime? taskDeadline;
  @override
  final String title;
  @override
  final String description;
  @override
  final Gender? gender;
  @override
  final int? age;
  @override
  final double? expectedPrice;
  @override
  @JsonKey()
  final TaskStatus status;
// id stays an empty string when a new task is created
// id will be assigned by the server.
  @override
  @JsonKey()
  final String id;
  @override
  final String? assigned;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'TaskModel(ownerId: $ownerId, attachedLocation: $attachedLocation, relevantTags: $relevantTags, taskDeadline: $taskDeadline, title: $title, description: $description, gender: $gender, age: $age, expectedPrice: $expectedPrice, status: $status, id: $id, assigned: $assigned, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            (identical(other.attachedLocation, attachedLocation) ||
                other.attachedLocation == attachedLocation) &&
            const DeepCollectionEquality()
                .equals(other._relevantTags, _relevantTags) &&
            (identical(other.taskDeadline, taskDeadline) ||
                other.taskDeadline == taskDeadline) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.expectedPrice, expectedPrice) ||
                other.expectedPrice == expectedPrice) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.assigned, assigned) ||
                other.assigned == assigned) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      ownerId,
      attachedLocation,
      const DeepCollectionEquality().hash(_relevantTags),
      taskDeadline,
      title,
      description,
      gender,
      age,
      expectedPrice,
      status,
      id,
      assigned,
      createdAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      __$$TaskModelImplCopyWithImpl<_$TaskModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskModelImplToJson(
      this,
    );
  }
}

abstract class _TaskModel implements TaskModel {
  const factory _TaskModel(
      {final String ownerId,
      final ({double lat, double lng})? attachedLocation,
      required final List<String> relevantTags,
      final DateTime? taskDeadline,
      required final String title,
      required final String description,
      final Gender? gender,
      final int? age,
      final double? expectedPrice,
      final TaskStatus status,
      final String id,
      final String? assigned,
      required final DateTime createdAt}) = _$TaskModelImpl;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  String get ownerId;
  @override // where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  ({double lat, double lng})? get attachedLocation;
  @override
  List<String> get relevantTags;
  @override
  DateTime? get taskDeadline;
  @override
  String get title;
  @override
  String get description;
  @override
  Gender? get gender;
  @override
  int? get age;
  @override
  double? get expectedPrice;
  @override
  TaskStatus get status;
  @override // id stays an empty string when a new task is created
// id will be assigned by the server.
  String get id;
  @override
  String? get assigned;
  @override
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
