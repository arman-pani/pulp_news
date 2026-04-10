// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:odiya_news_app/core/models/news_model.dart';

part 'bundled_articles_response.freezed.dart';
part 'bundled_articles_response.g.dart';

@freezed
class BundledCategorySection with _$BundledCategorySection {
  @JsonSerializable(explicitToJson: true)
  const factory BundledCategorySection({
    @Default(<NewsModel>[]) List<NewsModel> articles,
    @Default(0) int total,
    @Default(0) int limit,
  }) = _BundledCategorySection;

  factory BundledCategorySection.fromJson(Map<String, dynamic> json) =>
      _$BundledCategorySectionFromJson(json);
}

@freezed
class BundledArticlesResponse with _$BundledArticlesResponse {
  @JsonSerializable(explicitToJson: true)
  const factory BundledArticlesResponse({
    @Default(<String, BundledCategorySection>{})
    Map<String, BundledCategorySection> categories,
    @JsonKey(name: 'total_categories') @Default(0) int totalCategories,
    @JsonKey(name: 'limit_per_category') @Default(0) int limitPerCategory,
    @Default(false) bool success,
  }) = _BundledArticlesResponse;

  factory BundledArticlesResponse.fromJson(Map<String, dynamic> json) =>
      _$BundledArticlesResponseFromJson(json);
}
