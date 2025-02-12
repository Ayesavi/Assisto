import 'package:assisto/core/services/app_functions.dart';
import 'package:assisto/features/home/controllers/select_catoegories_controller/select_categories_controller.dart';
import 'package:assisto/models/service_category/service_category_model.dart';
import 'package:assisto/shared/show_snackbar.dart';
import 'package:assisto/widgets/app_filled_button.dart';
import 'package:assisto/widgets/category_chip.dart';
import 'package:assisto/widgets/search_textfield.dart';
import 'package:assisto/widgets/text_widgets.dart';
import 'package:assisto/widgets/typing_ai_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectCategoriesPage extends ConsumerWidget {
  final VoidCallback? onBack;
  final Future<void> Function(List<ServiceCategoryModel> categories)
      onCategorySelected;

  const SelectCategoriesPage(
      {super.key, required this.onBack, required this.onCategorySelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ignore: unused_local_variable
    List<ServiceCategoryModel> selectedList = [];
    final state = ref.watch(selectCategoriesControllerProvider);
    final controller = ref.read(selectCategoriesControllerProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            if (onBack != null)
              BackButton(
                onPressed: () {
                  onBack?.call();
                },
              ),
            const SizedBox(
              width: 10,
            ),
            const TitleLarge(
              text: 'Select Services',
              weight: FontWeight.bold,
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SearchTextField(
                hintTexts: const ['Washing', 'Driving', 'Cooking'],
                triggerSearchOnChange: true,
                onSearch: (key) {
                  controller.searchCategoriesByKeys(key);
                },
              ),
              const SizedBox(height: 16.0),
              // Wrapped list of Chips
              state.when(loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }, data: (d, selected) {
                selectedList = selected;
                return Wrap(
                  spacing: 8.0,
                  children: d
                      .map((e) => ChipWidget(
                            label: e.label,
                            isSelected: selected.contains(e),
                            onTap: () {
                              controller.toggleSelection(e);
                            },
                          ))
                      .toList(),
                );
              }, error: () {
                return const Center(
                  child: Text('An error occurred'),
                );
              }, networkError: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
              const SizedBox(height: 16.0),
              TypingAITextField(
                onSend: (key) async {
                  final services = await AppFunctions.instance
                      .genCategoriesByDescription(key);
                  controller.selectGeneratedServices(services);
                },
              ),
              const SizedBox(height: 16.0),
              AppFilledButton(
                label: 'Continue',
                asyncTap: () async {
                  if (selectedList.length > 2) {
                    await onCategorySelected(selectedList);
                    return;
                  }
                  showSnackBar(context, 'At least select 3 categories');
                },
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
