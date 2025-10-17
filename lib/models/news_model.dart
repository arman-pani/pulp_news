import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:odiya_news_app/utils/time_formatter.dart';

part 'news_model.g.dart';

@HiveType(typeId: 0)
class NewsModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String sourceName;
  @HiveField(2)
  final String sourceUrl;
  @HiveField(3)
  final String title;
  @HiveField(4)
  final String author;
  @HiveField(5)
  final DateTime publishedAt;
  @HiveField(6)
  final String imageUrl;
  @HiveField(7)
  final String content;
  @HiveField(8)
  final String category;
  @HiveField(9)
  final String createdAt;
  @HiveField(10)
  final bool isSeen; // New field for tracking seen status

  NewsModel({
    required this.id,
    required this.sourceName,
    required this.sourceUrl,
    required this.title,
    required this.author,
    required this.publishedAt,
    required this.imageUrl,
    required this.content,
    required this.category,
    required this.createdAt,
    this.isSeen = false, // Default value is false
  });

  NewsModel copyWith({
    String? id,
    String? title,
    String? author,
    DateTime? publishedAt,
    String? imageUrl,
    String? sourceName,
    String? sourceUrl,
    String? content,
    String? source,
    String? category,
    String? createdAt,
    bool? isSeen, // Add isSeen to copyWith
  }) {
    return NewsModel(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      publishedAt: publishedAt ?? this.publishedAt,
      imageUrl: imageUrl ?? this.imageUrl,
      content: content ?? this.content,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      isSeen: isSeen ?? this.isSeen, // Include isSeen in copyWith
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
      'imageUrl': imageUrl,
      'content': content,
      'sourceName': sourceName,
      'sourceUrl': sourceUrl,
      'createdAt': createdAt,
      'category': category,
      'isSeen': isSeen, // Include isSeen in toMap
    };
  }

  factory NewsModel.fromMap(map) {
    return NewsModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      publishedAt: DateTime.tryParse(map['published_at'].toString()) ?? DateTime.now(),
      imageUrl: map['image_url'] ?? '',
      content: map['content'] ?? '',
      sourceName: map['source_name'] ?? '',
      sourceUrl: map['source_url'] ?? '',
      createdAt: map['created_at'] ?? '',
      category: map['category'] ?? '',
      isSeen: map['isSeen'] ?? false, // Default to false when creating from map
    );
  }

  String toJson() => json.encode(toMap());

  factory NewsModel.fromJson(String source) => NewsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NewsModel(id: $id, title: $title, author: $author, publishedAt: $publishedAt, imageUrl: $imageUrl, content: $content, sourceName: $sourceName, sourceUrl: $sourceUrl, createdAt: $createdAt, category: $category, isSeen: $isSeen)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is NewsModel &&
      other.id == id &&
      other.title == title &&
      other.author == author &&
      other.publishedAt == publishedAt &&
      other.imageUrl == imageUrl &&
      other.content == content &&
      other.sourceName == sourceName &&
      other.sourceUrl == sourceUrl &&
      other.createdAt == createdAt &&
      other.category == category &&
      other.isSeen == isSeen; // Include isSeen in equality check
  }

  @override
  int get hashCode {
    return id.hashCode ^
      title.hashCode ^
      author.hashCode ^
      publishedAt.hashCode ^
      imageUrl.hashCode ^
      content.hashCode ^
      sourceName.hashCode ^
      sourceUrl.hashCode ^
      createdAt.hashCode ^
      category.hashCode ^
      isSeen.hashCode; // Include isSeen in hashCode
  }

  /// Get relative time string (e.g., "2 hours ago", "3 days ago")
  String get relativeTime => TimeFormatter.getRelativeTime(publishedAt);

  /// Get short relative time string (e.g., "2h", "3d", "1w")
  String get shortRelativeTime => TimeFormatter.getShortRelativeTime(publishedAt);

  /// Get smart relative time (shows "Today", "Yesterday", or relative time)
  String get smartRelativeTime => TimeFormatter.getSmartRelativeTime(publishedAt);

  /// Get formatted date string (e.g., "Jan 15, 2024")
  String get formattedDate => TimeFormatter.getFormattedDate(publishedAt);

  /// Get formatted date and time string (e.g., "Jan 15, 2024 at 2:30 PM")
  String get formattedDateTime => TimeFormatter.getFormattedDateTime(publishedAt);

  /// Get formatted time string (e.g., "2:30 PM")
  String get formattedTime => TimeFormatter.getFormattedTime(publishedAt);

  /// Check if the article was published today
  bool get isPublishedToday => TimeFormatter.isToday(publishedAt);

  /// Check if the article was published yesterday
  bool get isPublishedYesterday => TimeFormatter.isYesterday(publishedAt);
}
