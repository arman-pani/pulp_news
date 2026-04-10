// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:odiya_news_app/core/utils/time_formatter.dart';

part 'news_model.freezed.dart';
part 'news_model.g.dart';

class PublishedAtConverter implements JsonConverter<DateTime, Object?> {
  const PublishedAtConverter();

  @override
  DateTime fromJson(Object? json) {
    if (json is int) {
      return DateTime.fromMillisecondsSinceEpoch(json);
    }

    if (json is String) {
      final asInt = int.tryParse(json);
      if (asInt != null) {
        return DateTime.fromMillisecondsSinceEpoch(asInt);
      }

      final parsed = DateTime.tryParse(json);
      if (parsed != null) {
        return parsed;
      }
    }

    return DateTime.now();
  }

  @override
  Object toJson(DateTime object) => object.toIso8601String();
}

@freezed
@HiveType(typeId: 0, adapterName: 'NewsModelAdapter')
class NewsModel with _$NewsModel {
  const factory NewsModel({
    @HiveField(0) @Default('') String id,

    @HiveField(1) @JsonKey(name: 'source_name') @Default('') String sourceName,

    @HiveField(2) @JsonKey(name: 'source_url') @Default('') String sourceUrl,

    @HiveField(3) @Default('') String title,

    @HiveField(4) @Default('') String author,

    @HiveField(5)
    @JsonKey(name: 'published_at')
    @PublishedAtConverter()
    required DateTime publishedAt,

    @HiveField(6) @JsonKey(name: 'image_url') @Default('') String imageUrl,

    @HiveField(7) @Default('') String content,

    @HiveField(8) @Default('') String category,

    @HiveField(9) @JsonKey(name: 'created_at') @Default('') String createdAt,

    @HiveField(10) @Default(false) bool isSeen,
  }) = _NewsModel;

  factory NewsModel.fromJson(Map<String, dynamic> json) =>
      _$NewsModelFromJson(json);

  const NewsModel._();

  String get relativeTime => TimeFormatter.getRelativeTime(publishedAt);
  String get shortRelativeTime =>
      TimeFormatter.getShortRelativeTime(publishedAt);
  String get smartRelativeTime =>
      TimeFormatter.getSmartRelativeTime(publishedAt);
  String get formattedDate => TimeFormatter.getFormattedDate(publishedAt);
  String get formattedDateTime =>
      TimeFormatter.getFormattedDateTime(publishedAt);
  String get formattedTime => TimeFormatter.getFormattedTime(publishedAt);
  bool get isPublishedToday => TimeFormatter.isToday(publishedAt);
  bool get isPublishedYesterday => TimeFormatter.isYesterday(publishedAt);
}
