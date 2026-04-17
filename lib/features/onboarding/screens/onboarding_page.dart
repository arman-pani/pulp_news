import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';
import 'package:odiya_news_app/core/routing/app_routes.dart';
import 'package:odiya_news_app/features/onboarding/models/feature_data.dart';
import 'package:odiya_news_app/features/onboarding/widgets/feature_column.dart';
import 'package:odiya_news_app/features/onboarding/widgets/page_indicator.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isNavigating = false;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < FeatureData.featureList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _openLanguageSelection();
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipOnboarding() {
    _openLanguageSelection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildOnboardingView(),
          if (_isNavigating)
            Container(
              color: Colors.black.withValues(alpha: 0.5),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _openLanguageSelection() async {
    if (_isNavigating) return;

    setState(() => _isNavigating = true);

    try {
      final authService = ref.read(authServiceProvider);
      // Create guest session if not already existing
      if (!authService.hasSession) {
        await authService.init();
      }

      if (mounted) {
        context.go(AppRoutes.language);
      }
    } catch (e) {
      if (mounted) {
        ref.read(appSnackbarServiceProvider).showError(
              'Could not connect. Please try again.',
            );
      }
    } finally {
      if (mounted) {
        setState(() => _isNavigating = false);
      }
    }
  }

  Widget _buildOnboardingView() {
    return SafeArea(
      child: Column(
        children: [
          _buildSkipButton(),
          _buildPageView(),
          PageIndicator(
            length: FeatureData.featureList.length,
            currentPage: _currentPage,
          ),
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  Widget _buildSkipButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: _isNavigating ? null : _skipOnboarding,
            child: Text(
              AppStrings.skip,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: _isNavigating
                        ? Theme.of(context).disabledColor
                        : Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) => setState(() => _currentPage = index),
        itemCount: FeatureData.featureList.length,
        itemBuilder: (context, index) =>
            FeatureColumn(data: FeatureData.featureList[index]),
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildBackButton(), _buildNextButton()],
      ),
    );
  }

  Widget _buildBackButton() {
    if (_currentPage == 0) return const SizedBox(width: 80);

    return TextButton.icon(
      onPressed: _isNavigating ? null : _previousPage,
      icon: const Icon(Icons.arrow_back_ios, size: 16),
      label: const Text(AppStrings.back),
    );
  }

  Widget _buildNextButton() {
    final isLastPage = _currentPage == FeatureData.featureList.length - 1;

    return ElevatedButton.icon(
      onPressed: _nextPage,
      icon: Icon(isLastPage ? Icons.check : Icons.arrow_forward_ios, size: 16),
      label: Text(isLastPage ? AppStrings.getStarted : AppStrings.next),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
    );
  }
}

