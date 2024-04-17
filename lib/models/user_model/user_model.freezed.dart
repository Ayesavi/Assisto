// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get userId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;
  String get gender => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  PrivateUserData? get privateData => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String userId,
      String name,
      String imageUrl,
      String gender,
      int age,
      PrivateUserData? privateData});

  $PrivateUserDataCopyWith<$Res>? get privateData;
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? gender = null,
    Object? age = null,
    Object? privateData = freezed,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      privateData: freezed == privateData
          ? _value.privateData
          : privateData // ignore: cast_nullable_to_non_nullable
              as PrivateUserData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PrivateUserDataCopyWith<$Res>? get privateData {
    if (_value.privateData == null) {
      return null;
    }

    return $PrivateUserDataCopyWith<$Res>(_value.privateData!, (value) {
      return _then(_value.copyWith(privateData: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      String name,
      String imageUrl,
      String gender,
      int age,
      PrivateUserData? privateData});

  @override
  $PrivateUserDataCopyWith<$Res>? get privateData;
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? name = null,
    Object? imageUrl = null,
    Object? gender = null,
    Object? age = null,
    Object? privateData = freezed,
  }) {
    return _then(_$UserModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      gender: null == gender
          ? _value.gender
          : gender // ignore: cast_nullable_to_non_nullable
              as String,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      privateData: freezed == privateData
          ? _value.privateData
          : privateData // ignore: cast_nullable_to_non_nullable
              as PrivateUserData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.userId,
      required this.name,
      required this.imageUrl,
      required this.gender,
      required this.age,
      this.privateData});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final String userId;
  @override
  final String name;
  @override
  final String imageUrl;
  @override
  final String gender;
  @override
  final int age;
  @override
  final PrivateUserData? privateData;

  @override
  String toString() {
    return 'UserModel(userId: $userId, name: $name, imageUrl: $imageUrl, gender: $gender, age: $age, privateData: $privateData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.gender, gender) || other.gender == gender) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.privateData, privateData) ||
                other.privateData == privateData));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, userId, name, imageUrl, gender, age, privateData);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final String userId,
      required final String name,
      required final String imageUrl,
      required final String gender,
      required final int age,
      final PrivateUserData? privateData}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  String get userId;
  @override
  String get name;
  @override
  String get imageUrl;
  @override
  String get gender;
  @override
  int get age;
  @override
  PrivateUserData? get privateData;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PrivateUserData _$PrivateUserDataFromJson(Map<String, dynamic> json) {
  return _PrivateUserData.fromJson(json);
}

/// @nodoc
mixin _$PrivateUserData {
  List<String> get categories => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get dob => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrivateUserDataCopyWith<PrivateUserData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrivateUserDataCopyWith<$Res> {
  factory $PrivateUserDataCopyWith(
          PrivateUserData value, $Res Function(PrivateUserData) then) =
      _$PrivateUserDataCopyWithImpl<$Res, PrivateUserData>;
  @useResult
  $Res call(
      {List<String> categories, String? email, String? phone, String? dob});
}

/// @nodoc
class _$PrivateUserDataCopyWithImpl<$Res, $Val extends PrivateUserData>
    implements $PrivateUserDataCopyWith<$Res> {
  _$PrivateUserDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? dob = freezed,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PrivateUserDataImplCopyWith<$Res>
    implements $PrivateUserDataCopyWith<$Res> {
  factory _$$PrivateUserDataImplCopyWith(_$PrivateUserDataImpl value,
          $Res Function(_$PrivateUserDataImpl) then) =
      __$$PrivateUserDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> categories, String? email, String? phone, String? dob});
}

/// @nodoc
class __$$PrivateUserDataImplCopyWithImpl<$Res>
    extends _$PrivateUserDataCopyWithImpl<$Res, _$PrivateUserDataImpl>
    implements _$$PrivateUserDataImplCopyWith<$Res> {
  __$$PrivateUserDataImplCopyWithImpl(
      _$PrivateUserDataImpl _value, $Res Function(_$PrivateUserDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? email = freezed,
    Object? phone = freezed,
    Object? dob = freezed,
  }) {
    return _then(_$PrivateUserDataImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: freezed == phone
          ? _value.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String?,
      dob: freezed == dob
          ? _value.dob
          : dob // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PrivateUserDataImpl implements _PrivateUserData {
  const _$PrivateUserDataImpl(
      {required final List<String> categories,
      this.email,
      this.phone,
      this.dob})
      : _categories = categories;

  factory _$PrivateUserDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PrivateUserDataImplFromJson(json);

  final List<String> _categories;
  @override
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  final String? email;
  @override
  final String? phone;
  @override
  final String? dob;

  @override
  String toString() {
    return 'PrivateUserData(categories: $categories, email: $email, phone: $phone, dob: $dob)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PrivateUserDataImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.dob, dob) || other.dob == dob));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_categories), email, phone, dob);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PrivateUserDataImplCopyWith<_$PrivateUserDataImpl> get copyWith =>
      __$$PrivateUserDataImplCopyWithImpl<_$PrivateUserDataImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PrivateUserDataImplToJson(
      this,
    );
  }
}

abstract class _PrivateUserData implements PrivateUserData {
  const factory _PrivateUserData(
      {required final List<String> categories,
      final String? email,
      final String? phone,
      final String? dob}) = _$PrivateUserDataImpl;

  factory _PrivateUserData.fromJson(Map<String, dynamic> json) =
      _$PrivateUserDataImpl.fromJson;

  @override
  List<String> get categories;
  @override
  String? get email;
  @override
  String? get phone;
  @override
  String? get dob;
  @override
  @JsonKey(ignore: true)
  _$$PrivateUserDataImplCopyWith<_$PrivateUserDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
