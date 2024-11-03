import 'package:assisto/core/respositories/cms_repository/cms_repository_provider.dart';
import 'package:assisto/models/service_model/service_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final getServicesProvider = FutureProvider<List<ServiceModel>>(
  (ref) async {
    return await Future.delayed(const Duration(seconds: 2), () {
      final repository = ref.read(cmsRepositoryProvider);
      return repository.getAppServices();
    });
  },
);
