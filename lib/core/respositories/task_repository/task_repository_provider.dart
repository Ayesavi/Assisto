import 'package:assisto/core/config/flavor_config.dart';
import 'package:assisto/core/respositories/task_repository/base_task_repository.dart';
import 'package:assisto/core/respositories/task_repository/fake_task_repository.dart';
import 'package:assisto/core/respositories/task_repository/supabase_task_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final taskRepositoryProvider = Provider<BaseTaskRepository>((ref) {
  return FlavorConfig().useFakeRepositories
      ? FakeTaskRepository()
      : SupabaseTaskRepository();
});
