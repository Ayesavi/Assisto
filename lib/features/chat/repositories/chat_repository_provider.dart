import 'package:assisto/core/config/flavor_config.dart';
import 'package:assisto/features/chat/repositories/base_chat_repository.dart';
import 'package:assisto/features/chat/repositories/fake_chat_repository.dart';
import 'package:assisto/features/chat/repositories/supabase_chat_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final chatRepositoryProvider = Provider<BaseChatRepository>((ref) {
  return FlavorConfig().useFakeRepositories
      ? FakeChatRepository()
      : SupabaseChatRepository();
});
