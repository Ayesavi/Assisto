// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_profile_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskProfilePageControllerHash() =>
    r'01c003f5c15fe0504212985373de4ecba62e9306';

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

abstract class _$TaskProfilePageController
    extends BuildlessAutoDisposeNotifier<TaskProfilePageState> {
  late final int taskId;

  TaskProfilePageState build(
    int taskId,
  );
}

/// See also [TaskProfilePageController].
@ProviderFor(TaskProfilePageController)
const taskProfilePageControllerProvider = TaskProfilePageControllerFamily();

/// See also [TaskProfilePageController].
class TaskProfilePageControllerFamily extends Family<TaskProfilePageState> {
  /// See also [TaskProfilePageController].
  const TaskProfilePageControllerFamily();

  /// See also [TaskProfilePageController].
  TaskProfilePageControllerProvider call(
    int taskId,
  ) {
    return TaskProfilePageControllerProvider(
      taskId,
    );
  }

  @override
  TaskProfilePageControllerProvider getProviderOverride(
    covariant TaskProfilePageControllerProvider provider,
  ) {
    return call(
      provider.taskId,
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
  String? get name => r'taskProfilePageControllerProvider';
}

/// See also [TaskProfilePageController].
class TaskProfilePageControllerProvider extends AutoDisposeNotifierProviderImpl<
    TaskProfilePageController, TaskProfilePageState> {
  /// See also [TaskProfilePageController].
  TaskProfilePageControllerProvider(
    int taskId,
  ) : this._internal(
          () => TaskProfilePageController()..taskId = taskId,
          from: taskProfilePageControllerProvider,
          name: r'taskProfilePageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskProfilePageControllerHash,
          dependencies: TaskProfilePageControllerFamily._dependencies,
          allTransitiveDependencies:
              TaskProfilePageControllerFamily._allTransitiveDependencies,
          taskId: taskId,
        );

  TaskProfilePageControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.taskId,
  }) : super.internal();

  final int taskId;

  @override
  TaskProfilePageState runNotifierBuild(
    covariant TaskProfilePageController notifier,
  ) {
    return notifier.build(
      taskId,
    );
  }

  @override
  Override overrideWith(TaskProfilePageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskProfilePageControllerProvider._internal(
        () => create()..taskId = taskId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        taskId: taskId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<TaskProfilePageController,
      TaskProfilePageState> createElement() {
    return _TaskProfilePageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskProfilePageControllerProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskProfilePageControllerRef
    on AutoDisposeNotifierProviderRef<TaskProfilePageState> {
  /// The parameter `taskId` of this provider.
  int get taskId;
}

class _TaskProfilePageControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TaskProfilePageController,
        TaskProfilePageState> with TaskProfilePageControllerRef {
  _TaskProfilePageControllerProviderElement(super.provider);

  @override
  int get taskId => (origin as TaskProfilePageControllerProvider).taskId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
