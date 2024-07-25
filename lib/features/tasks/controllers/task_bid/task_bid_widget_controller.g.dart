// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_bid_widget_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskBidWidgetControllerHash() =>
    r'dcab11d926608aaa6b25996dcc8812db1693381c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$TaskBidWidgetController
    extends BuildlessAutoDisposeNotifier<TaskBidWidgetControllerState> {
  late final int bidId;

  TaskBidWidgetControllerState build(
    int bidId,
  );
}

/// See also [TaskBidWidgetController].
@ProviderFor(TaskBidWidgetController)
const taskBidWidgetControllerProvider = TaskBidWidgetControllerFamily();

/// See also [TaskBidWidgetController].
class TaskBidWidgetControllerFamily
    extends Family<TaskBidWidgetControllerState> {
  /// See also [TaskBidWidgetController].
  const TaskBidWidgetControllerFamily();

  /// See also [TaskBidWidgetController].
  TaskBidWidgetControllerProvider call(
    int bidId,
  ) {
    return TaskBidWidgetControllerProvider(
      bidId,
    );
  }

  @override
  TaskBidWidgetControllerProvider getProviderOverride(
    covariant TaskBidWidgetControllerProvider provider,
  ) {
    return call(
      provider.bidId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'taskBidWidgetControllerProvider';
}

/// See also [TaskBidWidgetController].
class TaskBidWidgetControllerProvider extends AutoDisposeNotifierProviderImpl<
    TaskBidWidgetController, TaskBidWidgetControllerState> {
  /// See also [TaskBidWidgetController].
  TaskBidWidgetControllerProvider(
    int bidId,
  ) : this._internal(
          () => TaskBidWidgetController()..bidId = bidId,
          from: taskBidWidgetControllerProvider,
          name: r'taskBidWidgetControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskBidWidgetControllerHash,
          dependencies: TaskBidWidgetControllerFamily._dependencies,
          allTransitiveDependencies:
              TaskBidWidgetControllerFamily._allTransitiveDependencies,
          bidId: bidId,
        );

  TaskBidWidgetControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.bidId,
  }) : super.internal();

  final int bidId;

  @override
  TaskBidWidgetControllerState runNotifierBuild(
    covariant TaskBidWidgetController notifier,
  ) {
    return notifier.build(
      bidId,
    );
  }

  @override
  Override overrideWith(TaskBidWidgetController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskBidWidgetControllerProvider._internal(
        () => create()..bidId = bidId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        bidId: bidId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TaskBidWidgetController,
      TaskBidWidgetControllerState> createElement() {
    return _TaskBidWidgetControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskBidWidgetControllerProvider && other.bidId == bidId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, bidId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskBidWidgetControllerRef
    on AutoDisposeNotifierProviderRef<TaskBidWidgetControllerState> {
  /// The parameter `bidId` of this provider.
  int get bidId;
}

class _TaskBidWidgetControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TaskBidWidgetController,
        TaskBidWidgetControllerState> with TaskBidWidgetControllerRef {
  _TaskBidWidgetControllerProviderElement(super.provider);

  @override
  int get bidId => (origin as TaskBidWidgetControllerProvider).bidId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
