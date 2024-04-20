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
  @JsonKey(name: 'owner_id', includeToJson: false)
  String get ownerId =>
      throw _privateConstructorUsedError; // where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @JsonKey(name: 'address_id')
  dynamic get addressId => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Gender? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'age_group')
  String? get ageGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'expected_price')
  double? get expectedPrice => throw _privateConstructorUsedError;
  TaskStatus get status =>
      throw _privateConstructorUsedError; // id stays an empty string when a new task is created
// id will be assigned by the server.
  @JsonKey(includeToJson: false)
  int get id => throw _privateConstructorUsedError;
  String? get assigned => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
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
      {@JsonKey(name: 'owner_id', includeToJson: false) String ownerId,
      @JsonKey(name: 'address_id') dynamic addressId,
      List<String> tags,
      DateTime? deadline,
      String title,
      String description,
      Gender? gender,
      @JsonKey(name: 'age_group') String? ageGroup,
      @JsonKey(name: 'expected_price') double? expectedPrice,
      TaskStatus status,
      @JsonKey(includeToJson: false) int id,
      String? assigned,
      @JsonKey(name: 'created_at') DateTime createdAt});
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
    Object? addressId = freezed,
    Object? tags = null,
    Object? deadline = freezed,
    Object? title = null,
    Object? description = null,
    Object? gender = freezed,
    Object? ageGroup = freezed,
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
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as dynamic,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
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
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as int,
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
      {@JsonKey(name: 'owner_id', includeToJson: false) String ownerId,
      @JsonKey(name: 'address_id') dynamic addressId,
      List<String> tags,
      DateTime? deadline,
      String title,
      String description,
      Gender? gender,
      @JsonKey(name: 'age_group') String? ageGroup,
      @JsonKey(name: 'expected_price') double? expectedPrice,
      TaskStatus status,
      @JsonKey(includeToJson: false) int id,
      String? assigned,
      @JsonKey(name: 'created_at') DateTime createdAt});
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
    Object? addressId = freezed,
    Object? tags = null,
    Object? deadline = freezed,
    Object? title = null,
    Object? description = null,
    Object? gender = freezed,
    Object? ageGroup = freezed,
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
      addressId: freezed == addressId ? _value.addressId! : addressId,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
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
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
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
              as int,
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
      {@JsonKey(name: 'owner_id', includeToJson: false) this.ownerId = '',
      @JsonKey(name: 'address_id') this.addressId,
      required final List<String> tags,
      this.deadline,
      required this.title,
      required this.description,
      this.gender,
      @JsonKey(name: 'age_group') this.ageGroup,
      @JsonKey(name: 'expected_price') this.expectedPrice,
      this.status = TaskStatus.unassigned,
      @JsonKey(includeToJson: false) this.id = 0,
      this.assigned,
      @JsonKey(name: 'created_at') required this.createdAt})
      : _tags = tags;

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  @JsonKey(name: 'owner_id', includeToJson: false)
  final String ownerId;
// where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @override
  @JsonKey(name: 'address_id')
  final dynamic addressId;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final DateTime? deadline;
  @override
  final String title;
  @override
  final String description;
  @override
  final Gender? gender;
  @override
  @JsonKey(name: 'age_group')
  final String? ageGroup;
  @override
  @JsonKey(name: 'expected_price')
  final double? expectedPrice;
  @override
  @JsonKey()
  final TaskStatus status;
// id stays an empty string when a new task is created
// id will be assigned by the server.
  @override
  @JsonKey(includeToJson: false)
  final int id;
  @override
  final String? assigned;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  @override
  String toString() {
    return 'TaskModel(ownerId: $ownerId, addressId: $addressId, tags: $tags, deadline: $deadline, title: $title, description: $description, gender: $gender, ageGroup: $ageGroup, expectedPrice: $expectedPrice, status: $status, id: $id, assigned: $assigned, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.ownerId, ownerId) || other.ownerId == ownerId) &&
            const DeepCollectionEquality().equals(other.addressId, addressId) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.ageGroup, ageGroup) ||
                other.ageGroup == ageGroup) &&
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
      const DeepCollectionEquality().hash(addressId),
      const DeepCollectionEquality().hash(_tags),
      deadline,
      title,
      description,
      gender,
      ageGroup,
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
      {@JsonKey(name: 'owner_id', includeToJson: false) final String ownerId,
      @JsonKey(name: 'address_id') final dynamic addressId,
      required final List<String> tags,
      final DateTime? deadline,
      required final String title,
      required final String description,
      final Gender? gender,
      @JsonKey(name: 'age_group') final String? ageGroup,
      @JsonKey(name: 'expected_price') final double? expectedPrice,
      final TaskStatus status,
      @JsonKey(includeToJson: false) final int id,
      final String? assigned,
      @JsonKey(name: 'created_at')
      required final DateTime createdAt}) = _$TaskModelImpl;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  @JsonKey(name: 'owner_id', includeToJson: false)
  String get ownerId;
  @override // where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @JsonKey(name: 'address_id')
  dynamic get addressId;
  @override
  List<String> get tags;
  @override
  DateTime? get deadline;
  @override
  String get title;
  @override
  String get description;
  @override
  Gender? get gender;
  @override
  @JsonKey(name: 'age_group')
  String? get ageGroup;
  @override
  @JsonKey(name: 'expected_price')
  double? get expectedPrice;
  @override
  TaskStatus get status;
  @override // id stays an empty string when a new task is created
// id will be assigned by the server.
  @JsonKey(includeToJson: false)
  int get id;
  @override
  String? get assigned;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
