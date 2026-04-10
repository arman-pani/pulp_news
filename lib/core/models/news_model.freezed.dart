// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

NewsModel _$NewsModelFromJson(Map<String, dynamic> json) {
  return _NewsModel.fromJson(json);
}

/// @nodoc
mixin _$NewsModel {
  @HiveField(0)
  String get id => throw _privateConstructorUsedError;
  @HiveField(1)
  @JsonKey(name: 'source_name')
  String get sourceName => throw _privateConstructorUsedError;
  @HiveField(2)
  @JsonKey(name: 'source_url')
  String get sourceUrl => throw _privateConstructorUsedError;
  @HiveField(3)
  String get title => throw _privateConstructorUsedError;
  @HiveField(4)
  String get author => throw _privateConstructorUsedError;
  @HiveField(5)
  @JsonKey(name: 'published_at')
  @PublishedAtConverter()
  DateTime get publishedAt => throw _privateConstructorUsedError;
  @HiveField(6)
  @JsonKey(name: 'image_url')
  String get imageUrl => throw _privateConstructorUsedError;
  @HiveField(7)
  String get content => throw _privateConstructorUsedError;
  @HiveField(8)
  String get category => throw _privateConstructorUsedError;
  @HiveField(9)
  @JsonKey(name: 'created_at')
  String get createdAt => throw _privateConstructorUsedError;
  @HiveField(10)
  bool get isSeen => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewsModelCopyWith<NewsModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewsModelCopyWith<$Res> {
  factory $NewsModelCopyWith(NewsModel value, $Res Function(NewsModel) then) =
      _$NewsModelCopyWithImpl<$Res, NewsModel>;
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) @JsonKey(name: 'source_name') String sourceName,
      @HiveField(2) @JsonKey(name: 'source_url') String sourceUrl,
      @HiveField(3) String title,
      @HiveField(4) String author,
      @HiveField(5)
      @JsonKey(name: 'published_at')
      @PublishedAtConverter()
      DateTime publishedAt,
      @HiveField(6) @JsonKey(name: 'image_url') String imageUrl,
      @HiveField(7) String content,
      @HiveField(8) String category,
      @HiveField(9) @JsonKey(name: 'created_at') String createdAt,
      @HiveField(10) bool isSeen});
}

/// @nodoc
class _$NewsModelCopyWithImpl<$Res, $Val extends NewsModel>
    implements $NewsModelCopyWith<$Res> {
  _$NewsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceName = null,
    Object? sourceUrl = null,
    Object? title = null,
    Object? author = null,
    Object? publishedAt = null,
    Object? imageUrl = null,
    Object? content = null,
    Object? category = null,
    Object? createdAt = null,
    Object? isSeen = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceName: null == sourceName
          ? _value.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isSeen: null == isSeen
          ? _value.isSeen
          : isSeen // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewsModelImplCopyWith<$Res>
    implements $NewsModelCopyWith<$Res> {
  factory _$$NewsModelImplCopyWith(
          _$NewsModelImpl value, $Res Function(_$NewsModelImpl) then) =
      __$$NewsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@HiveField(0) String id,
      @HiveField(1) @JsonKey(name: 'source_name') String sourceName,
      @HiveField(2) @JsonKey(name: 'source_url') String sourceUrl,
      @HiveField(3) String title,
      @HiveField(4) String author,
      @HiveField(5)
      @JsonKey(name: 'published_at')
      @PublishedAtConverter()
      DateTime publishedAt,
      @HiveField(6) @JsonKey(name: 'image_url') String imageUrl,
      @HiveField(7) String content,
      @HiveField(8) String category,
      @HiveField(9) @JsonKey(name: 'created_at') String createdAt,
      @HiveField(10) bool isSeen});
}

/// @nodoc
class __$$NewsModelImplCopyWithImpl<$Res>
    extends _$NewsModelCopyWithImpl<$Res, _$NewsModelImpl>
    implements _$$NewsModelImplCopyWith<$Res> {
  __$$NewsModelImplCopyWithImpl(
      _$NewsModelImpl _value, $Res Function(_$NewsModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sourceName = null,
    Object? sourceUrl = null,
    Object? title = null,
    Object? author = null,
    Object? publishedAt = null,
    Object? imageUrl = null,
    Object? content = null,
    Object? category = null,
    Object? createdAt = null,
    Object? isSeen = null,
  }) {
    return _then(_$NewsModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      sourceName: null == sourceName
          ? _value.sourceName
          : sourceName // ignore: cast_nullable_to_non_nullable
              as String,
      sourceUrl: null == sourceUrl
          ? _value.sourceUrl
          : sourceUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      author: null == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      imageUrl: null == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      isSeen: null == isSeen
          ? _value.isSeen
          : isSeen // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$NewsModelImpl extends _NewsModel {
  const _$NewsModelImpl(
      {@HiveField(0) this.id = '',
      @HiveField(1) @JsonKey(name: 'source_name') this.sourceName = '',
      @HiveField(2) @JsonKey(name: 'source_url') this.sourceUrl = '',
      @HiveField(3) this.title = '',
      @HiveField(4) this.author = '',
      @HiveField(5)
      @JsonKey(name: 'published_at')
      @PublishedAtConverter()
      required this.publishedAt,
      @HiveField(6) @JsonKey(name: 'image_url') this.imageUrl = '',
      @HiveField(7) this.content = '',
      @HiveField(8) this.category = '',
      @HiveField(9) @JsonKey(name: 'created_at') this.createdAt = '',
      @HiveField(10) this.isSeen = false})
      : super._();

  factory _$NewsModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewsModelImplFromJson(json);

  @override
  @JsonKey()
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  @JsonKey(name: 'source_name')
  final String sourceName;
  @override
  @HiveField(2)
  @JsonKey(name: 'source_url')
  final String sourceUrl;
  @override
  @JsonKey()
  @HiveField(3)
  final String title;
  @override
  @JsonKey()
  @HiveField(4)
  final String author;
  @override
  @HiveField(5)
  @JsonKey(name: 'published_at')
  @PublishedAtConverter()
  final DateTime publishedAt;
  @override
  @HiveField(6)
  @JsonKey(name: 'image_url')
  final String imageUrl;
  @override
  @JsonKey()
  @HiveField(7)
  final String content;
  @override
  @JsonKey()
  @HiveField(8)
  final String category;
  @override
  @HiveField(9)
  @JsonKey(name: 'created_at')
  final String createdAt;
  @override
  @JsonKey()
  @HiveField(10)
  final bool isSeen;

  @override
  String toString() {
    return 'NewsModel(id: $id, sourceName: $sourceName, sourceUrl: $sourceUrl, title: $title, author: $author, publishedAt: $publishedAt, imageUrl: $imageUrl, content: $content, category: $category, createdAt: $createdAt, isSeen: $isSeen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewsModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sourceName, sourceName) ||
                other.sourceName == sourceName) &&
            (identical(other.sourceUrl, sourceUrl) ||
                other.sourceUrl == sourceUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isSeen, isSeen) || other.isSeen == isSeen));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, sourceName, sourceUrl, title,
      author, publishedAt, imageUrl, content, category, createdAt, isSeen);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewsModelImplCopyWith<_$NewsModelImpl> get copyWith =>
      __$$NewsModelImplCopyWithImpl<_$NewsModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewsModelImplToJson(
      this,
    );
  }
}

abstract class _NewsModel extends NewsModel {
  const factory _NewsModel(
      {@HiveField(0) final String id,
      @HiveField(1) @JsonKey(name: 'source_name') final String sourceName,
      @HiveField(2) @JsonKey(name: 'source_url') final String sourceUrl,
      @HiveField(3) final String title,
      @HiveField(4) final String author,
      @HiveField(5)
      @JsonKey(name: 'published_at')
      @PublishedAtConverter()
      required final DateTime publishedAt,
      @HiveField(6) @JsonKey(name: 'image_url') final String imageUrl,
      @HiveField(7) final String content,
      @HiveField(8) final String category,
      @HiveField(9) @JsonKey(name: 'created_at') final String createdAt,
      @HiveField(10) final bool isSeen}) = _$NewsModelImpl;
  const _NewsModel._() : super._();

  factory _NewsModel.fromJson(Map<String, dynamic> json) =
      _$NewsModelImpl.fromJson;

  @override
  @HiveField(0)
  String get id;
  @override
  @HiveField(1)
  @JsonKey(name: 'source_name')
  String get sourceName;
  @override
  @HiveField(2)
  @JsonKey(name: 'source_url')
  String get sourceUrl;
  @override
  @HiveField(3)
  String get title;
  @override
  @HiveField(4)
  String get author;
  @override
  @HiveField(5)
  @JsonKey(name: 'published_at')
  @PublishedAtConverter()
  DateTime get publishedAt;
  @override
  @HiveField(6)
  @JsonKey(name: 'image_url')
  String get imageUrl;
  @override
  @HiveField(7)
  String get content;
  @override
  @HiveField(8)
  String get category;
  @override
  @HiveField(9)
  @JsonKey(name: 'created_at')
  String get createdAt;
  @override
  @HiveField(10)
  bool get isSeen;
  @override
  @JsonKey(ignore: true)
  _$$NewsModelImplCopyWith<_$NewsModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
