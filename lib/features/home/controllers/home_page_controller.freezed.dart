// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_page_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomePageControllerState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<TaskModel> models, List<TaskFilterType> filters)
        tasks,
    required TResult Function(Object e) error,
    required TResult Function() networkError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult? Function(Object e)? error,
    TResult? Function()? networkError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult Function(Object e)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Tasks value) tasks,
    required TResult Function(_Error value) error,
    required TResult Function(_NetworkError value) networkError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Tasks value)? tasks,
    TResult? Function(_Error value)? error,
    TResult? Function(_NetworkError value)? networkError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Tasks value)? tasks,
    TResult Function(_Error value)? error,
    TResult Function(_NetworkError value)? networkError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageControllerStateCopyWith<$Res> {
  factory $HomePageControllerStateCopyWith(HomePageControllerState value,
          $Res Function(HomePageControllerState) then) =
      _$HomePageControllerStateCopyWithImpl<$Res, HomePageControllerState>;
}

/// @nodoc
class _$HomePageControllerStateCopyWithImpl<$Res,
        $Val extends HomePageControllerState>
    implements $HomePageControllerStateCopyWith<$Res> {
  _$HomePageControllerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HomePageControllerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$LoadingImplCopyWith<$Res> {
  factory _$$LoadingImplCopyWith(
          _$LoadingImpl value, $Res Function(_$LoadingImpl) then) =
      __$$LoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$LoadingImplCopyWithImpl<$Res>
    extends _$HomePageControllerStateCopyWithImpl<$Res, _$LoadingImpl>
    implements _$$LoadingImplCopyWith<$Res> {
  __$$LoadingImplCopyWithImpl(
      _$LoadingImpl _value, $Res Function(_$LoadingImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageControllerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$LoadingImpl implements _Loading {
  const _$LoadingImpl();

  @override
  String toString() {
    return 'HomePageControllerState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<TaskModel> models, List<TaskFilterType> filters)
        tasks,
    required TResult Function(Object e) error,
    required TResult Function() networkError,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult? Function(Object e)? error,
    TResult? Function()? networkError,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult Function(Object e)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Tasks value) tasks,
    required TResult Function(_Error value) error,
    required TResult Function(_NetworkError value) networkError,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Tasks value)? tasks,
    TResult? Function(_Error value)? error,
    TResult? Function(_NetworkError value)? networkError,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Tasks value)? tasks,
    TResult Function(_Error value)? error,
    TResult Function(_NetworkError value)? networkError,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading implements HomePageControllerState {
  const factory _Loading() = _$LoadingImpl;
}

/// @nodoc
abstract class _$$TasksImplCopyWith<$Res> {
  factory _$$TasksImplCopyWith(
          _$TasksImpl value, $Res Function(_$TasksImpl) then) =
      __$$TasksImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<TaskModel> models, List<TaskFilterType> filters});
}

/// @nodoc
class __$$TasksImplCopyWithImpl<$Res>
    extends _$HomePageControllerStateCopyWithImpl<$Res, _$TasksImpl>
    implements _$$TasksImplCopyWith<$Res> {
  __$$TasksImplCopyWithImpl(
      _$TasksImpl _value, $Res Function(_$TasksImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageControllerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? models = null,
    Object? filters = null,
  }) {
    return _then(_$TasksImpl(
      null == models
          ? _value._models
          : models // ignore: cast_nullable_to_non_nullable
              as List<TaskModel>,
      null == filters
          ? _value._filters
          : filters // ignore: cast_nullable_to_non_nullable
              as List<TaskFilterType>,
    ));
  }
}

/// @nodoc

class _$TasksImpl implements _Tasks {
  const _$TasksImpl(
      final List<TaskModel> models, final List<TaskFilterType> filters)
      : _models = models,
        _filters = filters;

  final List<TaskModel> _models;
  @override
  List<TaskModel> get models {
    if (_models is EqualUnmodifiableListView) return _models;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_models);
  }

  final List<TaskFilterType> _filters;
  @override
  List<TaskFilterType> get filters {
    if (_filters is EqualUnmodifiableListView) return _filters;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_filters);
  }

  @override
  String toString() {
    return 'HomePageControllerState.tasks(models: $models, filters: $filters)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TasksImpl &&
            const DeepCollectionEquality().equals(other._models, _models) &&
            const DeepCollectionEquality().equals(other._filters, _filters));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_models),
      const DeepCollectionEquality().hash(_filters));

  /// Create a copy of HomePageControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TasksImplCopyWith<_$TasksImpl> get copyWith =>
      __$$TasksImplCopyWithImpl<_$TasksImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<TaskModel> models, List<TaskFilterType> filters)
        tasks,
    required TResult Function(Object e) error,
    required TResult Function() networkError,
  }) {
    return tasks(models, filters);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult? Function(Object e)? error,
    TResult? Function()? networkError,
  }) {
    return tasks?.call(models, filters);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult Function(Object e)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) {
    if (tasks != null) {
      return tasks(models, filters);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Tasks value) tasks,
    required TResult Function(_Error value) error,
    required TResult Function(_NetworkError value) networkError,
  }) {
    return tasks(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Tasks value)? tasks,
    TResult? Function(_Error value)? error,
    TResult? Function(_NetworkError value)? networkError,
  }) {
    return tasks?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Tasks value)? tasks,
    TResult Function(_Error value)? error,
    TResult Function(_NetworkError value)? networkError,
    required TResult orElse(),
  }) {
    if (tasks != null) {
      return tasks(this);
    }
    return orElse();
  }
}

abstract class _Tasks implements HomePageControllerState {
  const factory _Tasks(
          final List<TaskModel> models, final List<TaskFilterType> filters) =
      _$TasksImpl;

  List<TaskModel> get models;
  List<TaskFilterType> get filters;

  /// Create a copy of HomePageControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TasksImplCopyWith<_$TasksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ErrorImplCopyWith<$Res> {
  factory _$$ErrorImplCopyWith(
          _$ErrorImpl value, $Res Function(_$ErrorImpl) then) =
      __$$ErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Object e});
}

/// @nodoc
class __$$ErrorImplCopyWithImpl<$Res>
    extends _$HomePageControllerStateCopyWithImpl<$Res, _$ErrorImpl>
    implements _$$ErrorImplCopyWith<$Res> {
  __$$ErrorImplCopyWithImpl(
      _$ErrorImpl _value, $Res Function(_$ErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageControllerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? e = null,
  }) {
    return _then(_$ErrorImpl(
      null == e ? _value.e : e,
    ));
  }
}

/// @nodoc

class _$ErrorImpl implements _Error {
  const _$ErrorImpl(this.e);

  @override
  final Object e;

  @override
  String toString() {
    return 'HomePageControllerState.error(e: $e)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ErrorImpl &&
            const DeepCollectionEquality().equals(other.e, e));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(e));

  /// Create a copy of HomePageControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      __$$ErrorImplCopyWithImpl<_$ErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<TaskModel> models, List<TaskFilterType> filters)
        tasks,
    required TResult Function(Object e) error,
    required TResult Function() networkError,
  }) {
    return error(e);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult? Function(Object e)? error,
    TResult? Function()? networkError,
  }) {
    return error?.call(e);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult Function(Object e)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(e);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Tasks value) tasks,
    required TResult Function(_Error value) error,
    required TResult Function(_NetworkError value) networkError,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Tasks value)? tasks,
    TResult? Function(_Error value)? error,
    TResult? Function(_NetworkError value)? networkError,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Tasks value)? tasks,
    TResult Function(_Error value)? error,
    TResult Function(_NetworkError value)? networkError,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error implements HomePageControllerState {
  const factory _Error(final Object e) = _$ErrorImpl;

  Object get e;

  /// Create a copy of HomePageControllerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ErrorImplCopyWith<_$ErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NetworkErrorImplCopyWith<$Res> {
  factory _$$NetworkErrorImplCopyWith(
          _$NetworkErrorImpl value, $Res Function(_$NetworkErrorImpl) then) =
      __$$NetworkErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NetworkErrorImplCopyWithImpl<$Res>
    extends _$HomePageControllerStateCopyWithImpl<$Res, _$NetworkErrorImpl>
    implements _$$NetworkErrorImplCopyWith<$Res> {
  __$$NetworkErrorImplCopyWithImpl(
      _$NetworkErrorImpl _value, $Res Function(_$NetworkErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of HomePageControllerState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NetworkErrorImpl implements _NetworkError {
  const _$NetworkErrorImpl();

  @override
  String toString() {
    return 'HomePageControllerState.networkError()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NetworkErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loading,
    required TResult Function(
            List<TaskModel> models, List<TaskFilterType> filters)
        tasks,
    required TResult Function(Object e) error,
    required TResult Function() networkError,
  }) {
    return networkError();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loading,
    TResult? Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult? Function(Object e)? error,
    TResult? Function()? networkError,
  }) {
    return networkError?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loading,
    TResult Function(List<TaskModel> models, List<TaskFilterType> filters)?
        tasks,
    TResult Function(Object e)? error,
    TResult Function()? networkError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Loading value) loading,
    required TResult Function(_Tasks value) tasks,
    required TResult Function(_Error value) error,
    required TResult Function(_NetworkError value) networkError,
  }) {
    return networkError(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Loading value)? loading,
    TResult? Function(_Tasks value)? tasks,
    TResult? Function(_Error value)? error,
    TResult? Function(_NetworkError value)? networkError,
  }) {
    return networkError?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Loading value)? loading,
    TResult Function(_Tasks value)? tasks,
    TResult Function(_Error value)? error,
    TResult Function(_NetworkError value)? networkError,
    required TResult orElse(),
  }) {
    if (networkError != null) {
      return networkError(this);
    }
    return orElse();
  }
}

abstract class _NetworkError implements HomePageControllerState {
  const factory _NetworkError() = _$NetworkErrorImpl;
}
