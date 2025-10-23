import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../country_controller.dart';
import '../../constants/app_colors.dart';

class LanguageSelectionWidget extends StatelessWidget {
  const LanguageSelectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CountryController>();

    return Obx(() {
      final selectedStateId = controller.selectedStateId?.value;

      // Only show language selection for supported states
      if (selectedStateId == null ||
          !controller.isStateSupported(selectedStateId)) {
        return const SizedBox.shrink();
      }

      final availableLanguages = controller.getAvailableLanguages();
      final selectedLanguage = controller.selectedLanguage?.value;

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Language',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimaryLight,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: availableLanguages.map((language) {
                final isSelected = selectedLanguage == language.code;
                final isComingSoon = language.code == 'coming_soon';

                return GestureDetector(
                  onTap: isComingSoon
                      ? null
                      : () => controller.selectLanguage(language.code),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primaryOrange
                          : (isComingSoon
                                ? AppColors.grey300
                                : AppColors.white),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primaryOrange
                            : AppColors.borderLight,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.primaryOrange.withOpacity(0.3),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: Text(
                      language.nativeName,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? AppColors.white
                            : (isComingSoon
                                  ? AppColors.grey600
                                  : AppColors.textPrimaryLight),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: Obx(
                () => ElevatedButton(
                  onPressed: controller.canProceed
                      ? controller.proceedToNext
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    foregroundColor: AppColors.white,
                    disabledBackgroundColor: AppColors.grey300,
                    disabledForegroundColor: AppColors.grey600,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: controller.canProceed ? 2 : 0,
                  ),
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
