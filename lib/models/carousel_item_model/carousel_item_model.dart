import 'package:freezed_annotation/freezed_annotation.dart';

part 'carousel_item_model.freezed.dart';
part 'carousel_item_model.g.dart';

@freezed
class CarouselItem with _$CarouselItem {
  const factory CarouselItem({
    required String title,
    required String subtitle,
    required String imageUrl,
  }) = _CarouselItem;

  factory CarouselItem.fromJson(Map<String, dynamic> json) => _$CarouselItemFromJson(json);
}
