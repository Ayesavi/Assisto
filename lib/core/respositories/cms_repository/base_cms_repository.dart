import 'package:assisto/models/carousel_item_model/carousel_item_model.dart';
import 'package:assisto/models/service_model/service_model.dart';

abstract class BaseCMSRepository {
  Future<List<CarouselItem>> getCarouselItems();
  Future<List<ServiceModel>> getAppServices();
}
