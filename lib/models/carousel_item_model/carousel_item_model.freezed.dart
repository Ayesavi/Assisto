// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'carousel_item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CarouselItem _$CarouselItemFromJson(Map<String, dynamic> json) {
  return _CarouselItem.fromJson(json);
}

/// @nodoc
mixin _$CarouselItem {
  String get title => throw _privateConstructorUsedError;
  String get subtitle => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  /// Serializes this CarouselItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CarouselItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CarouselItemCopyWith<CarouselItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CarouselItemCopyWith<$Res> {
  factory $CarouselItemCopyWith(
          CarouselItem value, $Res Function(CarouselItem) then) =
      _$CarouselItemCopyWithImpl<$Res, CarouselItem>;
  @useResult
  $Res call({String title, String subtitle, String imageUrl});
}

/// @nodoc
class _$CarouselItemCopyWithImpl<$Res, $Val extends CarouselItem>
    implements $CarouselItemCopyWith<$Res> {
  _$CarouselItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CarouselItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? imageUrl = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CarouselItemImplCopyWith<$Res>
    implements $CarouselItemCopyWith<$Res> {
  factory _$$CarouselItemImplCopyWith(
          _$CarouselItemImpl value, $Res Function(_$CarouselItemImpl) then) =
      __$$CarouselItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String subtitle, String imageUrl});
}

/// @nodoc
class __$$CarouselItemImplCopyWithImpl<$Res>
    extends _$CarouselItemCopyWithImpl<$Res, _$CarouselItemImpl>
    implements _$$CarouselItemImplCopyWith<$Res> {
  __$$CarouselItemImplCopyWithImpl(
      _$CarouselItemImpl _value, $Res Function(_$CarouselItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of CarouselItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? subtitle = null,
    Object? imageUrl = null,
  }) {
    return _then(_$CarouselItemImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      subtitle: null == subtitle
          ? _value.subtitle
          : subtitle // ignore: cast_nullable_to_non_nullable
              as String,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CarouselItemImpl implements _CarouselItem {
  const _$CarouselItemImpl(
      {required this.title, required this.subtitle, required this.imageUrl});

  factory _$CarouselItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CarouselItemImplFromJson(json);

  @override
  final String title;
  @override
  final String subtitle;
  @override
  final String imageUrl;

  @override
  String toString() {
    return 'CarouselItem(title: $title, subtitle: $subtitle, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CarouselItemImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.subtitle, subtitle) ||
                other.subtitle == subtitle) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, title, subtitle, imageUrl);

  /// Create a copy of CarouselItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CarouselItemImplCopyWith<_$CarouselItemImpl> get copyWith =>
      __$$CarouselItemImplCopyWithImpl<_$CarouselItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CarouselItemImplToJson(
      this,
    );
  }
}

abstract class _CarouselItem implements CarouselItem {
  const factory _CarouselItem(
      {required final String title,
      required final String subtitle,
      required final String imageUrl}) = _$CarouselItemImpl;

  factory _CarouselItem.fromJson(Map<String, dynamic> json) =
      _$CarouselItemImpl.fromJson;

  @override
  String get title;
  @override
  String get subtitle;
  @override
  String get imageUrl;

  /// Create a copy of CarouselItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CarouselItemImplCopyWith<_$CarouselItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
