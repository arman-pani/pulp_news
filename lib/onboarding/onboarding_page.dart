import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:odiya_news_app/constants/app_strings.dart';
import 'package:odiya_news_app/onboarding/widgets/feature_column.dart';
import 'package:odiya_news_app/onboarding/widgets/page_indicator.dart';
import 'package:odiya_news_app/services/fcm_service.dart';
import 'package:odiya_news_app/utils/app_handler.dart';
import 'package:odiya_news_app/utils/app_router.dart';
import 'package:odiya_news_app/utils/auth_handler.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isLoading = false;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      icon: Icons.newspaper,
      title: AppStrings.latestNews,
      subtitle: AppStrings.latestNewsDescription,
    ),
    OnboardingData(
      icon: Icons.bookmark,
      title: AppStrings.saveArticles,
      subtitle: AppStrings.saveArticlesDescription,
    ),
    OnboardingData(
      icon: Icons.tune,
      title: AppStrings.personalized,
      subtitle: AppStrings.personalizedDescription,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
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
    _completeOnboarding();
  }

  Future<void> _completeOnboarding() async {
    if (_isLoading) return;
    
    setState(() => _isLoading = true);

    try {
      await completeOnboarding();
      await AuthHandler.signInAnonymously();
      await FCMService.to.requestPermission();
      
      if (mounted) {
        context.pushReplacementNamed(AppRoutes.explore);
      }
    } catch (e) {
      debugPrint('Error completing onboarding: $e');
      if (mounted) {
        setState(() => _isLoading = false);
        _showErrorSnackBar();
      }
    }
  }

  void _showErrorSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Failed to complete setup. Please try again.'),
        backgroundColor: Theme.of(context).colorScheme.error,
        action: SnackBarAction(
          label: 'Retry',
          onPressed: _completeOnboarding,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : _buildOnboardingView(),
    );
  }

  

  Widget _buildOnboardingView() {
    return SafeArea(
      child: Column(
        children: [
          _buildSkipButton(),
          _buildPageView(),
          PageIndicator(length: _onboardingData.length, currentPage: _currentPage),
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
            onPressed: _skipOnboarding,
            child: Text(
              AppStrings.skip,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
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
        itemCount: _onboardingData.length,
        itemBuilder: (context, index) => FeatureColumn(data: _onboardingData[index]),
      ),
    );
  }


  Widget _buildNavigationButtons() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildBackButton(),
          _buildNextButton(),
        ],
      ),
    );
  }

  Widget _buildBackButton() {
    if (_currentPage == 0) return const SizedBox(width: 80);
    
    return TextButton.icon(
      onPressed: _previousPage,
      icon: const Icon(Icons.arrow_back_ios, size: 16),
      label: const Text(AppStrings.back),
    );
  }

  Widget _buildNextButton() {
    final isLastPage = _currentPage == _onboardingData.length - 1;
    
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

class OnboardingData {
  final IconData icon;
  final String title;
  final String subtitle;

  OnboardingData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}