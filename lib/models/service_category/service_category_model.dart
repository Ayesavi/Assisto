import 'package:freezed_annotation/freezed_annotation.dart';

part 'service_category_model.freezed.dart';
part 'service_category_model.g.dart';

@freezed
abstract class ServiceCategoryModel with _$ServiceCategoryModel {
  factory ServiceCategoryModel({
    required String description,
    required String label,
  }) = _ServiceCategoryModel;

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) =>
      _$ServiceCategoryModelFromJson(json);
}
