import 'package:assisto/models/service_category/service_category_model.dart';

abstract class CategoriesRepository {
  Future<List<ServiceCategoryModel>> fetchCategories();
  Future<List<ServiceCategoryModel>> fetchCategoryByKey(String key);
}

class FakeCategoriesRepository implements CategoriesRepository {
  final List<ServiceCategoryModel> categories = [
    ServiceCategoryModel(
        description:
            'ride, safar, commute, carpool, drive, drop-off, pick-up, सवारी',
        label: 'driving'),
    ServiceCategoryModel(
        description:
            'meal prep, nashta, recipe, food, cook, chef, dinner, lunch, पकवान',
        label: 'cooking'),
    ServiceCategoryModel(
        description:
            'makeup, sundarta, hair, nails, skincare, salon, style, grooming, सौंदर्य',
        label: 'beauty'),
    ServiceCategoryModel(
        description:
            'childcare, parvarish, babysit, toddler, infant, playtime, bedtime, kids, बच्चा',
        label: 'babysitting'),
    ServiceCategoryModel(
        description:
            'senior, swasthya, elderly, companion, caregiver, assistance, support, aging, बुजुर्ग',
        label: 'eldercare'),
    ServiceCategoryModel(
        description:
            'schoolwork, padhai, study, tutor, help, learning, education, assignment, गयान',
        label: 'homework'),
    ServiceCategoryModel(
        description:
            'educate, gyan, learn, tutor, instructor, lesson, study, guide, शिक्षा',
        label: 'teaching'),
    ServiceCategoryModel(
        description:
            'clean, safai, house, ghar, chores, kaam, tidy, organize, घर',
        label: 'househelp'),
    ServiceCategoryModel(
        description:
            'paint, rang, color, wall, interior, exterior, room, design, पेंट',
        label: 'paint'),
    ServiceCategoryModel(
        description:
            'clean, safai, tidy, dust, sweep, mop, scrub, vacuum, पोछना',
        label: 'cleaning'),
    ServiceCategoryModel(
        description:
            'plumber, nal, pipe, leak, fix, water, drain, repair, पाइप',
        label: 'plumbing'),
    ServiceCategoryModel(
        description:
            'henna, mehendi, design, tattoo, bride, festive, ceremony, art, मेहंदी',
        label: 'mehendi'),
    ServiceCategoryModel(
        description:
            'silai, alteration, sew, stitch, fit, tailor, clothing, dress, कपड़े',
        label: 'tailoring'),
    ServiceCategoryModel(
        description:
            'electrician, bijli, wire, fix, outlet, light, appliance, repair, बिजली',
        label: 'electrical repairing'),
    ServiceCategoryModel(
        description:
            'event, karyakram, party, wedding, plan, organize, coordinate, celebration, इवेंट',
        label: 'event management'),
    ServiceCategoryModel(
        description:
            'food, kirana, shop, grocery, list, purchase, market, delivery, ग्राहक',
        label: 'groceries'),
    ServiceCategoryModel(
        description:
            'care, dekhbhal, assist, help, support, groom, bath, dress, हेल्प',
        label: 'personal care'),
    ServiceCategoryModel(
        description:
            'vishesh, specific, personal, unique, special, individual, customized, tailored, विशेष',
        label: 'custom'),
  ];

  @override
  Future<List<ServiceCategoryModel>> fetchCategories() async {
    // Simulate delay to mimic asynchronous behavior
    await Future.delayed(const Duration(milliseconds: 500));
    return categories;
  }

  @override
  Future<List<ServiceCategoryModel>> fetchCategoryByKey(String key) async {
    // Find category by key
    categories
        .where(
          (element) => (element.label.contains(key) ||
              element.description.contains(key)),
        )
        .toList();

    await Future.delayed(const Duration(milliseconds: 500));

    return categories;
  }
}
