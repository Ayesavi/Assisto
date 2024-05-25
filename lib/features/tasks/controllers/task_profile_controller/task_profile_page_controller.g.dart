// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_profile_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$taskProfilePageHash() => r'ffe84fa49ee652a4446735cc5fe9638bb549ad66';

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

abstract class _$TaskProfilePage
    extends BuildlessAutoDisposeNotifier<TaskProfilePageState> {
  late final int taskId;

  TaskProfilePageState build(
    int taskId,
  );
}

/// See also [TaskProfilePage].
@ProviderFor(TaskProfilePage)
const taskProfilePageProvider = TaskProfilePageFamily();

/// See also [TaskProfilePage].
class TaskProfilePageFamily extends Family<TaskProfilePageState> {
  /// See also [TaskProfilePage].
  const TaskProfilePageFamily();

  /// See also [TaskProfilePage].
  TaskProfilePageProvider call(
    int taskId,
  ) {
    return TaskProfilePageProvider(
      taskId,
    );
  }

  @override
  TaskProfilePageProvider getProviderOverride(
    covariant TaskProfilePageProvider provider,
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
  String? get name => r'taskProfilePageProvider';
}

/// See also [TaskProfilePage].
class TaskProfilePageProvider extends AutoDisposeNotifierProviderImpl<
    TaskProfilePage, TaskProfilePageState> {
  /// See also [TaskProfilePage].
  TaskProfilePageProvider(
    int taskId,
  ) : this._internal(
          () => TaskProfilePage()..taskId = taskId,
          from: taskProfilePageProvider,
          name: r'taskProfilePageProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$taskProfilePageHash,
          dependencies: TaskProfilePageFamily._dependencies,
          allTransitiveDependencies:
              TaskProfilePageFamily._allTransitiveDependencies,
          taskId: taskId,
        );

  TaskProfilePageProvider._internal(
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
    covariant TaskProfilePage notifier,
  ) {
    return notifier.build(
      taskId,
    );
  }

  @override
  Override overrideWith(TaskProfilePage Function() create) {
    return ProviderOverride(
      origin: this,
      override: TaskProfilePageProvider._internal(
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
  AutoDisposeNotifierProviderElement<TaskProfilePage, TaskProfilePageState>
      createElement() {
    return _TaskProfilePageProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TaskProfilePageProvider && other.taskId == taskId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, taskId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TaskProfilePageRef
    on AutoDisposeNotifierProviderRef<TaskProfilePageState> {
  /// The parameter `taskId` of this provider.
  int get taskId;
}

class _TaskProfilePageProviderElement
    extends AutoDisposeNotifierProviderElement<TaskProfilePage,
        TaskProfilePageState> with TaskProfilePageRef {
  _TaskProfilePageProviderElement(super.provider);

  @override
  int get taskId => (origin as TaskProfilePageProvider).taskId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
