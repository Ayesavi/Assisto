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
  @JsonKey(includeToJson: false)
  TaskUser get owner =>
      throw _privateConstructorUsedError; // where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @JsonKey(name: 'address_id', includeToJson: true, includeFromJson: false)
  int? get addressId => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  TaskAddress? get address => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Gender get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'age_group')
  String? get ageGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'expected_price')
  int? get expectedPrice => throw _privateConstructorUsedError;
  TaskStatus get status =>
      throw _privateConstructorUsedError; // id stays an empty string when a new task is created
// id will be assigned by the server.
  @JsonKey(includeToJson: false)
  int get id => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  BidModel? get bid => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  double? get distance => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Serializes this TaskModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call(
      {@JsonKey(includeToJson: false) TaskUser owner,
      @JsonKey(name: 'address_id', includeToJson: true, includeFromJson: false)
      int? addressId,
      @JsonKey(includeToJson: false) TaskAddress? address,
      List<String> tags,
      DateTime? deadline,
      String title,
      String description,
      Gender gender,
      @JsonKey(name: 'age_group') String? ageGroup,
      @JsonKey(name: 'expected_price') int? expectedPrice,
      TaskStatus status,
      @JsonKey(includeToJson: false) int id,
      @JsonKey(includeToJson: false) BidModel? bid,
      @JsonKey(includeToJson: false) double? distance,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt});

  $TaskUserCopyWith<$Res> get owner;
  $TaskAddressCopyWith<$Res>? get address;
  $BidModelCopyWith<$Res>? get bid;
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? addressId = freezed,
    Object? address = freezed,
    Object? tags = null,
    Object? deadline = freezed,
    Object? title = null,
    Object? description = null,
    Object? gender = null,
    Object? ageGroup = freezed,
    Object? expectedPrice = freezed,
    Object? status = null,
    Object? id = null,
    Object? bid = freezed,
    Object? distance = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as TaskUser,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as TaskAddress?,
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
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedPrice: freezed == expectedPrice
          ? _value.expectedPrice
          : expectedPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      bid: freezed == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as BidModel?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskUserCopyWith<$Res> get owner {
    return $TaskUserCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $TaskAddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $TaskAddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $BidModelCopyWith<$Res>? get bid {
    if (_value.bid == null) {
      return null;
    }

    return $BidModelCopyWith<$Res>(_value.bid!, (value) {
      return _then(_value.copyWith(bid: value) as $Val);
    });
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
      {@JsonKey(includeToJson: false) TaskUser owner,
      @JsonKey(name: 'address_id', includeToJson: true, includeFromJson: false)
      int? addressId,
      @JsonKey(includeToJson: false) TaskAddress? address,
      List<String> tags,
      DateTime? deadline,
      String title,
      String description,
      Gender gender,
      @JsonKey(name: 'age_group') String? ageGroup,
      @JsonKey(name: 'expected_price') int? expectedPrice,
      TaskStatus status,
      @JsonKey(includeToJson: false) int id,
      @JsonKey(includeToJson: false) BidModel? bid,
      @JsonKey(includeToJson: false) double? distance,
      @JsonKey(name: 'created_at', includeToJson: false) DateTime? createdAt});

  @override
  $TaskUserCopyWith<$Res> get owner;
  @override
  $TaskAddressCopyWith<$Res>? get address;
  @override
  $BidModelCopyWith<$Res>? get bid;
}

/// @nodoc
class __$$TaskModelImplCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$TaskModelImpl>
    implements _$$TaskModelImplCopyWith<$Res> {
  __$$TaskModelImplCopyWithImpl(
      _$TaskModelImpl _value, $Res Function(_$TaskModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? owner = null,
    Object? addressId = freezed,
    Object? address = freezed,
    Object? tags = null,
    Object? deadline = freezed,
    Object? title = null,
    Object? description = null,
    Object? gender = null,
    Object? ageGroup = freezed,
    Object? expectedPrice = freezed,
    Object? status = null,
    Object? id = null,
    Object? bid = freezed,
    Object? distance = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$TaskModelImpl(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as TaskUser,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as int?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as TaskAddress?,
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
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as Gender,
      ageGroup: freezed == ageGroup
          ? _value.ageGroup
          : ageGroup // ignore: cast_nullable_to_non_nullable
              as String?,
      expectedPrice: freezed == expectedPrice
          ? _value.expectedPrice
          : expectedPrice // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as TaskStatus,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      bid: freezed == bid
          ? _value.bid
          : bid // ignore: cast_nullable_to_non_nullable
              as BidModel?,
      distance: freezed == distance
          ? _value.distance
          : distance // ignore: cast_nullable_to_non_nullable
              as double?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskModelImpl implements _TaskModel {
  const _$TaskModelImpl(
      {@JsonKey(includeToJson: false) required this.owner,
      @JsonKey(name: 'address_id', includeToJson: true, includeFromJson: false)
      this.addressId,
      @JsonKey(includeToJson: false) this.address,
      required final List<String> tags,
      this.deadline,
      required this.title,
      required this.description,
      this.gender = Gender.any,
      @JsonKey(name: 'age_group') this.ageGroup,
      @JsonKey(name: 'expected_price') this.expectedPrice,
      this.status = TaskStatus.unassigned,
      @JsonKey(includeToJson: false) this.id = 0,
      @JsonKey(includeToJson: false) this.bid,
      @JsonKey(includeToJson: false) this.distance,
      @JsonKey(name: 'created_at', includeToJson: false) this.createdAt})
      : _tags = tags;

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final TaskUser owner;
// where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @override
  @JsonKey(name: 'address_id', includeToJson: true, includeFromJson: false)
  final int? addressId;
  @override
  @JsonKey(includeToJson: false)
  final TaskAddress? address;
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
  @JsonKey()
  final Gender gender;
  @override
  @JsonKey(name: 'age_group')
  final String? ageGroup;
  @override
  @JsonKey(name: 'expected_price')
  final int? expectedPrice;
  @override
  @JsonKey()
  final TaskStatus status;
// id stays an empty string when a new task is created
// id will be assigned by the server.
  @override
  @JsonKey(includeToJson: false)
  final int id;
  @override
  @JsonKey(includeToJson: false)
  final BidModel? bid;
  @override
  @JsonKey(includeToJson: false)
  final double? distance;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  final DateTime? createdAt;

  @override
  String toString() {
    return 'TaskModel(owner: $owner, addressId: $addressId, address: $address, tags: $tags, deadline: $deadline, title: $title, description: $description, gender: $gender, ageGroup: $ageGroup, expectedPrice: $expectedPrice, status: $status, id: $id, bid: $bid, distance: $distance, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.owner, owner) || other.owner == owner) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.address, address) || other.address == address) &&
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
            (identical(other.bid, bid) || other.bid == bid) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      owner,
      addressId,
      address,
      const DeepCollectionEquality().hash(_tags),
      deadline,
      title,
      description,
      gender,
      ageGroup,
      expectedPrice,
      status,
      id,
      bid,
      distance,
      createdAt);

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
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
      {@JsonKey(includeToJson: false) required final TaskUser owner,
      @JsonKey(name: 'address_id', includeToJson: true, includeFromJson: false)
      final int? addressId,
      @JsonKey(includeToJson: false) final TaskAddress? address,
      required final List<String> tags,
      final DateTime? deadline,
      required final String title,
      required final String description,
      final Gender gender,
      @JsonKey(name: 'age_group') final String? ageGroup,
      @JsonKey(name: 'expected_price') final int? expectedPrice,
      final TaskStatus status,
      @JsonKey(includeToJson: false) final int id,
      @JsonKey(includeToJson: false) final BidModel? bid,
      @JsonKey(includeToJson: false) final double? distance,
      @JsonKey(name: 'created_at', includeToJson: false)
      final DateTime? createdAt}) = _$TaskModelImpl;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  TaskUser get owner; // where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @override
  @JsonKey(name: 'address_id', includeToJson: true, includeFromJson: false)
  int? get addressId;
  @override
  @JsonKey(includeToJson: false)
  TaskAddress? get address;
  @override
  List<String> get tags;
  @override
  DateTime? get deadline;
  @override
  String get title;
  @override
  String get description;
  @override
  Gender get gender;
  @override
  @JsonKey(name: 'age_group')
  String? get ageGroup;
  @override
  @JsonKey(name: 'expected_price')
  int? get expectedPrice;
  @override
  TaskStatus get status; // id stays an empty string when a new task is created
// id will be assigned by the server.
  @override
  @JsonKey(includeToJson: false)
  int get id;
  @override
  @JsonKey(includeToJson: false)
  BidModel? get bid;
  @override
  @JsonKey(includeToJson: false)
  double? get distance;
  @override
  @JsonKey(name: 'created_at', includeToJson: false)
  DateTime? get createdAt;

  /// Create a copy of TaskModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskUser _$TaskUserFromJson(Map<String, dynamic> json) {
  return _TaskUser.fromJson(json);
}

/// @nodoc
mixin _$TaskUser {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this TaskUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskUserCopyWith<TaskUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskUserCopyWith<$Res> {
  factory $TaskUserCopyWith(TaskUser value, $Res Function(TaskUser) then) =
      _$TaskUserCopyWithImpl<$Res, TaskUser>;
  @useResult
  $Res call({String id, @JsonKey(name: 'avatar_url') String? imageUrl});
}

/// @nodoc
class _$TaskUserCopyWithImpl<$Res, $Val extends TaskUser>
    implements $TaskUserCopyWith<$Res> {
  _$TaskUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskUserImplCopyWith<$Res>
    implements $TaskUserCopyWith<$Res> {
  factory _$$TaskUserImplCopyWith(
          _$TaskUserImpl value, $Res Function(_$TaskUserImpl) then) =
      __$$TaskUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, @JsonKey(name: 'avatar_url') String? imageUrl});
}

/// @nodoc
class __$$TaskUserImplCopyWithImpl<$Res>
    extends _$TaskUserCopyWithImpl<$Res, _$TaskUserImpl>
    implements _$$TaskUserImplCopyWith<$Res> {
  __$$TaskUserImplCopyWithImpl(
      _$TaskUserImpl _value, $Res Function(_$TaskUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$TaskUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskUserImpl implements _TaskUser {
  const _$TaskUserImpl(
      {required this.id, @JsonKey(name: 'avatar_url') this.imageUrl});

  factory _$TaskUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskUserImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'avatar_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'TaskUser(id: $id, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, imageUrl);

  /// Create a copy of TaskUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskUserImplCopyWith<_$TaskUserImpl> get copyWith =>
      __$$TaskUserImplCopyWithImpl<_$TaskUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskUserImplToJson(
      this,
    );
  }
}

abstract class _TaskUser implements TaskUser {
  const factory _TaskUser(
      {required final String id,
      @JsonKey(name: 'avatar_url') final String? imageUrl}) = _$TaskUserImpl;

  factory _TaskUser.fromJson(Map<String, dynamic> json) =
      _$TaskUserImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'avatar_url')
  String? get imageUrl;

  /// Create a copy of TaskUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskUserImplCopyWith<_$TaskUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskAddress _$TaskAddressFromJson(Map<String, dynamic> json) {
  return _TaskAddress.fromJson(json);
}

/// @nodoc
mixin _$TaskAddress {
  int get id => throw _privateConstructorUsedError;
  ({double lat, double lng}) get latlng => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'house_number')
  String get houseNumber => throw _privateConstructorUsedError;

  /// Serializes this TaskAddress to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskAddressCopyWith<TaskAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskAddressCopyWith<$Res> {
  factory $TaskAddressCopyWith(
          TaskAddress value, $Res Function(TaskAddress) then) =
      _$TaskAddressCopyWithImpl<$Res, TaskAddress>;
  @useResult
  $Res call(
      {int id,
      ({double lat, double lng}) latlng,
      String address,
      @JsonKey(name: 'house_number') String houseNumber});
}

/// @nodoc
class _$TaskAddressCopyWithImpl<$Res, $Val extends TaskAddress>
    implements $TaskAddressCopyWith<$Res> {
  _$TaskAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latlng = null,
    Object? address = null,
    Object? houseNumber = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      latlng: null == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as ({double lat, double lng}),
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      houseNumber: null == houseNumber
          ? _value.houseNumber
          : houseNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TaskAddressImplCopyWith<$Res>
    implements $TaskAddressCopyWith<$Res> {
  factory _$$TaskAddressImplCopyWith(
          _$TaskAddressImpl value, $Res Function(_$TaskAddressImpl) then) =
      __$$TaskAddressImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      ({double lat, double lng}) latlng,
      String address,
      @JsonKey(name: 'house_number') String houseNumber});
}

/// @nodoc
class __$$TaskAddressImplCopyWithImpl<$Res>
    extends _$TaskAddressCopyWithImpl<$Res, _$TaskAddressImpl>
    implements _$$TaskAddressImplCopyWith<$Res> {
  __$$TaskAddressImplCopyWithImpl(
      _$TaskAddressImpl _value, $Res Function(_$TaskAddressImpl) _then)
      : super(_value, _then);

  /// Create a copy of TaskAddress
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? latlng = null,
    Object? address = null,
    Object? houseNumber = null,
  }) {
    return _then(_$TaskAddressImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      latlng: null == latlng
          ? _value.latlng
          : latlng // ignore: cast_nullable_to_non_nullable
              as ({double lat, double lng}),
      address: null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
      houseNumber: null == houseNumber
          ? _value.houseNumber
          : houseNumber // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskAddressImpl implements _TaskAddress {
  const _$TaskAddressImpl(
      {required this.id,
      required this.latlng,
      required this.address,
      @JsonKey(name: 'house_number') required this.houseNumber});

  factory _$TaskAddressImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskAddressImplFromJson(json);

  @override
  final int id;
  @override
  final ({double lat, double lng}) latlng;
  @override
  final String address;
  @override
  @JsonKey(name: 'house_number')
  final String houseNumber;

  @override
  String toString() {
    return 'TaskAddress(id: $id, latlng: $latlng, address: $address, houseNumber: $houseNumber)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskAddressImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latlng, latlng) || other.latlng == latlng) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.houseNumber, houseNumber) ||
                other.houseNumber == houseNumber));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, latlng, address, houseNumber);

  /// Create a copy of TaskAddress
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskAddressImplCopyWith<_$TaskAddressImpl> get copyWith =>
      __$$TaskAddressImplCopyWithImpl<_$TaskAddressImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskAddressImplToJson(
      this,
    );
  }
}

abstract class _TaskAddress implements TaskAddress {
  const factory _TaskAddress(
          {required final int id,
          required final ({double lat, double lng}) latlng,
          required final String address,
          @JsonKey(name: 'house_number') required final String houseNumber}) =
      _$TaskAddressImpl;

  factory _TaskAddress.fromJson(Map<String, dynamic> json) =
      _$TaskAddressImpl.fromJson;

  @override
  int get id;
  @override
  ({double lat, double lng}) get latlng;
  @override
  String get address;
  @override
  @JsonKey(name: 'house_number')
  String get houseNumber;

  /// Create a copy of TaskAddress
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskAddressImplCopyWith<_$TaskAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
