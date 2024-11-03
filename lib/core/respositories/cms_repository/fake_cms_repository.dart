import 'package:assisto/core/respositories/cms_repository/base_cms_repository.dart';
import 'package:assisto/models/carousel_item_model/carousel_item_model.dart';
import 'package:assisto/models/service_model/service_model.dart';

class FakeCmsRepository implements BaseCMSRepository {
  @override
  Future<List<ServiceModel>> getAppServices() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    return [
      const ServiceModel(
          name: 'Washing',
          imageUrl: "https://www.svgrepo.com/show/525187/washing-machine.svg"),
      const ServiceModel(
          name: 'Pickup & Drop',
          imageUrl: "https://www.svgrepo.com/show/913/truck.svg"),
      const ServiceModel(name: 'Homeworks', imageUrl: "v"),
      const ServiceModel(
          name: 'Cleaning',
          imageUrl: "https://www.svgrepo.com/show/132066/cleaning-service.svg"),
      const ServiceModel(
          name: 'Eldercare',
          imageUrl: "https://www.svgrepo.com/show/525187/washing-machine.svg"),
      const ServiceModel(
          name: 'Plumbing',
          imageUrl: "https://www.svgrepo.com/show/383191/pipe.svg"),
      const ServiceModel(
          name: 'Teaching',
          imageUrl: "https://www.svgrepo.com/show/525187/washing-machine.svg"),
      const ServiceModel(
          name: 'Driving',
          imageUrl: "https://www.svgrepo.com/show/117054/driver.svg"),
    ];
  }

  @override
  Future<List<CarouselItem>> getCarouselItems() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    return [
      const CarouselItem(
        title: 'Mountain Escape',
        subtitle: 'Experience the tranquility of the mountains',
        imageUrl:
            'https://images.unsplash.com/photo-1542856391-010fb87dcfed?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3',
      ),
      const CarouselItem(
        title: 'City Lights',
        subtitle: 'Discover the vibrant nightlife of the city',
        imageUrl:
            'https://images.unsplash.com/photo-1692264438297-e1e38a867d02?fm=jpg&q=60&w=3000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmVhdXRpZnVsJTIwbGFuZHNjYXBlfGVufDB8fDB8fHww',
      ),
      const CarouselItem(
        title: 'Sunny Beach',
        subtitle: 'Relax by the warm sandy beaches',
        imageUrl:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6IHv1GahqvOENVjykdTOOxX0kyj2eLnsFVA&s',
      ),
      const CarouselItem(
        title: 'Forest Trail',
        subtitle: 'Walk through the lush green forests',
        imageUrl:
            'https://images.unsplash.com/photo-1562107383-999fee2d5772?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
      ),
    ];
  }
}
