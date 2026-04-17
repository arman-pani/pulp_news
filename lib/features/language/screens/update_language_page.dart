import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/widgets/common_appbar.dart';
import 'package:odiya_news_app/core/widgets/custom_button.dart';
import 'package:odiya_news_app/core/widgets/try_again_placeholder.dart';
import 'package:odiya_news_app/features/language/controllers/language_controller.dart';
import 'package:odiya_news_app/features/language/widgets/language_selection_view.dart';

class UpdateLanguagePage extends ConsumerStatefulWidget {
  const UpdateLanguagePage({super.key});

  @override
  ConsumerState<UpdateLanguagePage> createState() => _UpdateLanguagePageState();
}

class _UpdateLanguagePageState extends ConsumerState<UpdateLanguagePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      ref
          .read(languageControllerProvider.notifier)
          .syncSelectionWithPersistedLanguage();
    });
  }

  @override
  Widget build(BuildContext context) {
    final languageState = ref.watch(languageControllerProvider);

    return Scaffold(
      appBar: CommonAppbar(title: AppStrings.updateLanguage),
      body: languageState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => TryAgainPlaceholder(
          onRetry: () => ref.invalidate(languageControllerProvider),
        ),
        data: (state) {
          final hasPendingChange =
              state.selectedLanguageCode != null &&
              state.selectedLanguageCode != state.currentLanguageCode;

          void handleConfirmChanges() {
            if (state.isSubmitting) return;
            ref
                .read(languageControllerProvider.notifier)
                .confirmLanguageChange();
          }

          return SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 16.0,
                    children: [
                      LanguageSelectionView(
                        state: state,
                        onSelect: ref
                            .read(languageControllerProvider.notifier)
                            .selectLanguage,
                      ),
                      if (hasPendingChange)
                        CustomButton(
                          onPressed: handleConfirmChanges,
                          label: AppStrings.confirmChanges,
                        ),
                    ],
                  ),
                ),
                if (state.isSubmitting) ...[
                  const Positioned.fill(
                    child: AbsorbPointer(
                      child: ColoredBox(color: Color(0x66000000)),
                    ),
                  ),
                  const Center(child: CircularProgressIndicator()),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
