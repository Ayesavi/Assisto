import 'package:assisto/core/respositories/cms_repository/base_cms_repository.dart';
import 'package:assisto/core/respositories/cms_repository/fake_cms_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final cmsRepositoryProvider = Provider<BaseCMSRepository>((ref) {
  // return FlavorConfig().useFakeRepositories
  //     ? FakeCmsRepository()
  //     : CMSRepository();
  return FakeCmsRepository();
});
