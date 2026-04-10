import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/features/onboarding/controllers/language_controller.dart';
import 'package:odiya_news_app/features/onboarding/models/language_option.dart';

class LanguagePage extends ConsumerWidget {
  const LanguagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final languageState = ref.watch(languageControllerProvider);

    return Scaffold(
      body: languageState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => _LanguageErrorView(
          onRetry: () => ref.invalidate(languageControllerProvider),
        ),
        data: (state) {
          if (state.languages.isEmpty) {
            return _LanguageEmptyView(
              onRetry: () => ref.invalidate(languageControllerProvider),
            );
          }

          return _LanguageSelectionView(
            state: state,
            onSelect: ref
                .read(languageControllerProvider.notifier)
                .selectLanguage,
            onContinue: () =>
                ref.read(languageControllerProvider.notifier).completeSetup(),
          );
        },
      ),
    );
  }
}

class _LanguageSelectionView extends StatelessWidget {
  const _LanguageSelectionView({
    required this.state,
    required this.onSelect,
    required this.onContinue,
  });

  final LanguageScreenState state;
  final ValueChanged<String> onSelect;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
            Expanded(
              child: ListView.separated(
                itemCount: state.languages.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final language = state.languages[index];
                  final isSelected =
                      language.code == state.selectedLanguageCode;

                  return _LanguageTile(
                    language: language,
                    isSelected: isSelected,
                    onTap: () => onSelect(language.code),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed:
                    state.selectedLanguageCode == null || state.isSubmitting
                    ? null
                    : onContinue,
                child: state.isSubmitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(AppStrings.completeSetup),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final LanguageOption language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outlineVariant,
              width: isSelected ? 2 : 1,
            ),
            color: isSelected
                ? colorScheme.primaryContainer.withValues(alpha: 0.45)
                : colorScheme.surface,
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        language.displayName,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        language.nativeName,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  isSelected
                      ? Icons.radio_button_checked
                      : Icons.radio_button_off,
                  color: isSelected ? colorScheme.primary : colorScheme.outline,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LanguageEmptyView extends StatelessWidget {
  const _LanguageEmptyView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _StateMessageView(
      title: AppStrings.noLanguagesAvailable,
      onRetry: onRetry,
    );
  }
}

class _LanguageErrorView extends StatelessWidget {
  const _LanguageErrorView({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return _StateMessageView(
      title: AppStrings.languageLoadError,
      onRetry: onRetry,
    );
  }
}

class _StateMessageView extends StatelessWidget {
  const _StateMessageView({required this.title, required this.onRetry});

  final String title;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            OutlinedButton(
              onPressed: onRetry,
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
    );
  }
}
