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
  TaskOwner get owner =>
      throw _privateConstructorUsedError; // where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @JsonKey(name: 'address_id', includeFromJson: false)
  dynamic get addressId => throw _privateConstructorUsedError;
  @JsonKey(includeToJson: false)
  TaskAddress? get address => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  DateTime? get deadline => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Gender? get gender => throw _privateConstructorUsedError;
  @JsonKey(name: 'age_group')
  String? get ageGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'expected_price')
  int? get expectedPrice => throw _privateConstructorUsedError;
  TaskStatus get status =>
      throw _privateConstructorUsedError; // id stays an empty string when a new task is created
// id will be assigned by the server.
  @JsonKey(includeToJson: false)
  int get id => throw _privateConstructorUsedError;
  String? get assigned => throw _privateConstructorUsedError;
  double? get distance => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime? get createdAt => throw _privateConstructorUsedError;

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
      {@JsonKey(includeToJson: false) TaskOwner owner,
      @JsonKey(name: 'address_id', includeFromJson: false) dynamic addressId,
      @JsonKey(includeToJson: false) TaskAddress? address,
      List<String> tags,
      DateTime? deadline,
      String title,
      String description,
      Gender? gender,
      @JsonKey(name: 'age_group') String? ageGroup,
      @JsonKey(name: 'expected_price') int? expectedPrice,
      TaskStatus status,
      @JsonKey(includeToJson: false) int id,
      String? assigned,
      double? distance,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  $TaskOwnerCopyWith<$Res> get owner;
  $TaskAddressCopyWith<$Res>? get address;
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
    Object? owner = null,
    Object? addressId = freezed,
    Object? address = freezed,
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
    Object? distance = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_value.copyWith(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as TaskOwner,
      addressId: freezed == addressId
          ? _value.addressId
          : addressId // ignore: cast_nullable_to_non_nullable
              as dynamic,
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
              as int?,
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

  @override
  @pragma('vm:prefer-inline')
  $TaskOwnerCopyWith<$Res> get owner {
    return $TaskOwnerCopyWith<$Res>(_value.owner, (value) {
      return _then(_value.copyWith(owner: value) as $Val);
    });
  }

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
      {@JsonKey(includeToJson: false) TaskOwner owner,
      @JsonKey(name: 'address_id', includeFromJson: false) dynamic addressId,
      @JsonKey(includeToJson: false) TaskAddress? address,
      List<String> tags,
      DateTime? deadline,
      String title,
      String description,
      Gender? gender,
      @JsonKey(name: 'age_group') String? ageGroup,
      @JsonKey(name: 'expected_price') int? expectedPrice,
      TaskStatus status,
      @JsonKey(includeToJson: false) int id,
      String? assigned,
      double? distance,
      @JsonKey(name: 'created_at') DateTime? createdAt});

  @override
  $TaskOwnerCopyWith<$Res> get owner;
  @override
  $TaskAddressCopyWith<$Res>? get address;
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
    Object? owner = null,
    Object? addressId = freezed,
    Object? address = freezed,
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
    Object? distance = freezed,
    Object? createdAt = freezed,
  }) {
    return _then(_$TaskModelImpl(
      owner: null == owner
          ? _value.owner
          : owner // ignore: cast_nullable_to_non_nullable
              as TaskOwner,
      addressId: freezed == addressId ? _value.addressId! : addressId,
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
              as int?,
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
      @JsonKey(name: 'address_id', includeFromJson: false) this.addressId,
      @JsonKey(includeToJson: false) this.address,
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
      this.distance,
      @JsonKey(name: 'created_at') this.createdAt})
      : _tags = tags;

  factory _$TaskModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskModelImplFromJson(json);

  @override
  @JsonKey(includeToJson: false)
  final TaskOwner owner;
// where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @override
  @JsonKey(name: 'address_id', includeFromJson: false)
  final dynamic addressId;
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
  final Gender? gender;
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
  final String? assigned;
  @override
  final double? distance;
  @override
  @JsonKey(name: 'created_at')
  final DateTime? createdAt;

  @override
  String toString() {
    return 'TaskModel(owner: $owner, addressId: $addressId, address: $address, tags: $tags, deadline: $deadline, title: $title, description: $description, gender: $gender, ageGroup: $ageGroup, expectedPrice: $expectedPrice, status: $status, id: $id, assigned: $assigned, distance: $distance, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskModelImpl &&
            (identical(other.owner, owner) || other.owner == owner) &&
            const DeepCollectionEquality().equals(other.addressId, addressId) &&
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
            (identical(other.assigned, assigned) ||
                other.assigned == assigned) &&
            (identical(other.distance, distance) ||
                other.distance == distance) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      owner,
      const DeepCollectionEquality().hash(addressId),
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
      assigned,
      distance,
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
          {@JsonKey(includeToJson: false) required final TaskOwner owner,
          @JsonKey(name: 'address_id', includeFromJson: false)
          final dynamic addressId,
          @JsonKey(includeToJson: false) final TaskAddress? address,
          required final List<String> tags,
          final DateTime? deadline,
          required final String title,
          required final String description,
          final Gender? gender,
          @JsonKey(name: 'age_group') final String? ageGroup,
          @JsonKey(name: 'expected_price') final int? expectedPrice,
          final TaskStatus status,
          @JsonKey(includeToJson: false) final int id,
          final String? assigned,
          final double? distance,
          @JsonKey(name: 'created_at') final DateTime? createdAt}) =
      _$TaskModelImpl;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$TaskModelImpl.fromJson;

  @override
  @JsonKey(includeToJson: false)
  TaskOwner get owner;
  @override // where the task has to be performed or the assigned
// user has to be report when the task is completed.
// attachedLocation
  @JsonKey(name: 'address_id', includeFromJson: false)
  dynamic get addressId;
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
  Gender? get gender;
  @override
  @JsonKey(name: 'age_group')
  String? get ageGroup;
  @override
  @JsonKey(name: 'expected_price')
  int? get expectedPrice;
  @override
  TaskStatus get status;
  @override // id stays an empty string when a new task is created
// id will be assigned by the server.
  @JsonKey(includeToJson: false)
  int get id;
  @override
  String? get assigned;
  @override
  double? get distance;
  @override
  @JsonKey(name: 'created_at')
  DateTime? get createdAt;
  @override
  @JsonKey(ignore: true)
  _$$TaskModelImplCopyWith<_$TaskModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskOwner _$TaskOwnerFromJson(Map<String, dynamic> json) {
  return _TaskOwner.fromJson(json);
}

/// @nodoc
mixin _$TaskOwner {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskOwnerCopyWith<TaskOwner> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskOwnerCopyWith<$Res> {
  factory $TaskOwnerCopyWith(TaskOwner value, $Res Function(TaskOwner) then) =
      _$TaskOwnerCopyWithImpl<$Res, TaskOwner>;
  @useResult
  $Res call({String id, @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class _$TaskOwnerCopyWithImpl<$Res, $Val extends TaskOwner>
    implements $TaskOwnerCopyWith<$Res> {
  _$TaskOwnerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

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
abstract class _$$TaskOwnerImplCopyWith<$Res>
    implements $TaskOwnerCopyWith<$Res> {
  factory _$$TaskOwnerImplCopyWith(
          _$TaskOwnerImpl value, $Res Function(_$TaskOwnerImpl) then) =
      __$$TaskOwnerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, @JsonKey(name: 'image_url') String? imageUrl});
}

/// @nodoc
class __$$TaskOwnerImplCopyWithImpl<$Res>
    extends _$TaskOwnerCopyWithImpl<$Res, _$TaskOwnerImpl>
    implements _$$TaskOwnerImplCopyWith<$Res> {
  __$$TaskOwnerImplCopyWithImpl(
      _$TaskOwnerImpl _value, $Res Function(_$TaskOwnerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? imageUrl = freezed,
  }) {
    return _then(_$TaskOwnerImpl(
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
class _$TaskOwnerImpl implements _TaskOwner {
  const _$TaskOwnerImpl(
      {required this.id, @JsonKey(name: 'image_url') this.imageUrl});

  factory _$TaskOwnerImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskOwnerImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'TaskOwner(id: $id, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskOwnerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskOwnerImplCopyWith<_$TaskOwnerImpl> get copyWith =>
      __$$TaskOwnerImplCopyWithImpl<_$TaskOwnerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskOwnerImplToJson(
      this,
    );
  }
}

abstract class _TaskOwner implements TaskOwner {
  const factory _TaskOwner(
      {required final String id,
      @JsonKey(name: 'image_url') final String? imageUrl}) = _$TaskOwnerImpl;

  factory _TaskOwner.fromJson(Map<String, dynamic> json) =
      _$TaskOwnerImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$TaskOwnerImplCopyWith<_$TaskOwnerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

TaskAddress _$TaskAddressFromJson(Map<String, dynamic> json) {
  return _TaskAddress.fromJson(json);
}

/// @nodoc
mixin _$TaskAddress {
  String get id => throw _privateConstructorUsedError;
  ({double lat, double lng}) get latlng => throw _privateConstructorUsedError;
  String get address => throw _privateConstructorUsedError;
  @JsonKey(name: 'house_number')
  String get houseNumber => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
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
      {String id,
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
              as String,
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
      {String id,
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
              as String,
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
  final String id;
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

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, latlng, address, houseNumber);

  @JsonKey(ignore: true)
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
          {required final String id,
          required final ({double lat, double lng}) latlng,
          required final String address,
          @JsonKey(name: 'house_number') required final String houseNumber}) =
      _$TaskAddressImpl;

  factory _TaskAddress.fromJson(Map<String, dynamic> json) =
      _$TaskAddressImpl.fromJson;

  @override
  String get id;
  @override
  ({double lat, double lng}) get latlng;
  @override
  String get address;
  @override
  @JsonKey(name: 'house_number')
  String get houseNumber;
  @override
  @JsonKey(ignore: true)
  _$$TaskAddressImplCopyWith<_$TaskAddressImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
