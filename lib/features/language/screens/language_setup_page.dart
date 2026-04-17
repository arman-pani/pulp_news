import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/widgets/custom_button.dart';
import 'package:odiya_news_app/core/widgets/try_again_placeholder.dart';
import 'package:odiya_news_app/features/language/controllers/language_controller.dart';
import 'package:odiya_news_app/features/language/widgets/language_selection_view.dart';

class LanguageSetupPage extends ConsumerWidget {
  const LanguageSetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageState = ref.watch(languageControllerProvider);
    final theme = Theme.of(context);

    return Scaffold(
      body: languageState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => TryAgainPlaceholder(
          onRetry: () => ref.invalidate(languageControllerProvider),
        ),
        data: (state) {
          void handleContinue() {
            if (state.selectedLanguageCode == null || state.isSubmitting) {
              return;
            }
            ref.read(languageControllerProvider.notifier).completeSetup();
          }

          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.chooseLanguage,
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    AppStrings.chooseLanguageDescription,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 24),
                  LanguageSelectionView(
                    state: state,
                    onSelect: ref
                        .read(languageControllerProvider.notifier)
                        .selectLanguage,
                  ),
                  const SizedBox(height: 16),

                  CustomButton(
                    onPressed: handleContinue,
                    label: AppStrings.continueLabel,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
