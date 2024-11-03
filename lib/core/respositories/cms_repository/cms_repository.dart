import 'package:assisto/core/respositories/cms_repository/base_cms_repository.dart';
import 'package:assisto/models/carousel_item_model/carousel_item_model.dart';
import 'package:assisto/models/service_model/service_model.dart';

class CMSRepository implements BaseCMSRepository {
  @override
  Future<List<ServiceModel>> getAppServices() {
    // TODO: implement getAppServices
    throw UnimplementedError();
  }

  @override
  Future<List<CarouselItem>> getCarouselItems() {
    // TODO: implement getCarouselItems
    throw UnimplementedError();
  }
}