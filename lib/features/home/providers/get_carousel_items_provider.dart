import 'package:assisto/core/respositories/cms_repository/cms_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final getCarouselItemsProvider = FutureProvider((ref) async {
  return ref.read(cmsRepositoryProvider).getCarouselItems();
});
