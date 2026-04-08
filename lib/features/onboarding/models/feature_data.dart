import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';

class FeatureData {
  final IconData icon;
  final String title;
  final String subtitle;

  FeatureData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  static final List<FeatureData> featureList = [
    FeatureData(
      icon: Icons.newspaper,
      title: AppStrings.latestNews,
      subtitle: AppStrings.latestNewsDescription,
    ),
    FeatureData(
      icon: Icons.bookmark,
      title: AppStrings.saveArticles,
      subtitle: AppStrings.saveArticlesDescription,
    ),
    FeatureData(
      icon: Icons.tune,
      title: AppStrings.personalized,
      subtitle: AppStrings.personalizedDescription,
    ),
  ];
}
