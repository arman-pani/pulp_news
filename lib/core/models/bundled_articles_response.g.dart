// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bundled_articles_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BundledCategorySectionImpl _$$BundledCategorySectionImplFromJson(
        Map<String, dynamic> json) =>
    _$BundledCategorySectionImpl(
      articles: (json['articles'] as List<dynamic>?)
              ?.map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NewsModel>[],
      total: (json['total'] as num?)?.toInt() ?? 0,
      limit: (json['limit'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$BundledCategorySectionImplToJson(
        _$BundledCategorySectionImpl instance) =>
    <String, dynamic>{
      'articles': instance.articles.map((e) => e.toJson()).toList(),
      'total': instance.total,
      'limit': instance.limit,
    };

_$BundledArticlesResponseImpl _$$BundledArticlesResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$BundledArticlesResponseImpl(
      categories: (json['categories'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(
                k, BundledCategorySection.fromJson(e as Map<String, dynamic>)),
          ) ??
          const <String, BundledCategorySection>{},
      trending: (json['trending'] as List<dynamic>?)
              ?.map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <NewsModel>[],
      totalCategories: (json['total_categories'] as num?)?.toInt() ?? 0,
      limitPerCategory: (json['limit_per_category'] as num?)?.toInt() ?? 0,
      success: json['success'] as bool? ?? false,
    );

Map<String, dynamic> _$$BundledArticlesResponseImplToJson(
        _$BundledArticlesResponseImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories.map((k, e) => MapEntry(k, e.toJson())),
      'trending': instance.trending.map((e) => e.toJson()).toList(),
      'total_categories': instance.totalCategories,
      'limit_per_category': instance.limitPerCategory,
      'success': instance.success,
    };
