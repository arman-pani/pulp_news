import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/onboarding/widgets/interactive_india_map.dart';
import 'country_controller.dart';
import 'widgets/language_selection_widget.dart';
import '../constants/app_colors.dart';

class IndiaMapPage extends StatelessWidget {
  const IndiaMapPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    Get.put(CountryController());

    return GetBuilder<CountryController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.backgroundLight,
          appBar: AppBar(
            backgroundColor: AppColors.surfaceContainerLow,
            elevation: 0,
            surfaceTintColor: AppColors.surfaceContainerLow,
            title: Row(
              spacing: 8,
              children: [
                Icon(Icons.location_on_rounded, color: AppColors.textPrimaryLight,),
                Obx(() => Text(
                  controller.selectedStateId?.value != null && controller.selectedStateId?.value != ""
                      ? controller.getSelectedStateName() ?? "Select your region"
                      : "Select your region",
                      style: Theme.of(context).textTheme.headlineMedium,
                )),
              ],
            ),
            centerTitle: false,
          ),
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryOrange),
                ),
              );
            }

            if (controller.statePaths.isEmpty) {
              return const Center(
                child: Text(
                  'No state data found',
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

             return SafeArea(
               child: Column(
                 children: [
                   Expanded(
                    child: Center(
                      child: InteractiveIndiaMap(
                       
                        controller: controller,
                        
                      ),
                    ),
                  ),
                    
                  const LanguageSelectionWidget(),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

