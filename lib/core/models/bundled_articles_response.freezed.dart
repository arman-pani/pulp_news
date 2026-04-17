// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bundled_articles_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BundledCategorySection _$BundledCategorySectionFromJson(
    Map<String, dynamic> json) {
  return _BundledCategorySection.fromJson(json);
}

/// @nodoc
mixin _$BundledCategorySection {
  List<NewsModel> get articles => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;
  int get limit => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BundledCategorySectionCopyWith<BundledCategorySection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BundledCategorySectionCopyWith<$Res> {
  factory $BundledCategorySectionCopyWith(BundledCategorySection value,
          $Res Function(BundledCategorySection) then) =
      _$BundledCategorySectionCopyWithImpl<$Res, BundledCategorySection>;
  @useResult
  $Res call({List<NewsModel> articles, int total, int limit});
}

/// @nodoc
class _$BundledCategorySectionCopyWithImpl<$Res,
        $Val extends BundledCategorySection>
    implements $BundledCategorySectionCopyWith<$Res> {
  _$BundledCategorySectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? total = null,
    Object? limit = null,
  }) {
    return _then(_value.copyWith(
      articles: null == articles
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BundledCategorySectionImplCopyWith<$Res>
    implements $BundledCategorySectionCopyWith<$Res> {
  factory _$$BundledCategorySectionImplCopyWith(
          _$BundledCategorySectionImpl value,
          $Res Function(_$BundledCategorySectionImpl) then) =
      __$$BundledCategorySectionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<NewsModel> articles, int total, int limit});
}

/// @nodoc
class __$$BundledCategorySectionImplCopyWithImpl<$Res>
    extends _$BundledCategorySectionCopyWithImpl<$Res,
        _$BundledCategorySectionImpl>
    implements _$$BundledCategorySectionImplCopyWith<$Res> {
  __$$BundledCategorySectionImplCopyWithImpl(
      _$BundledCategorySectionImpl _value,
      $Res Function(_$BundledCategorySectionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? total = null,
    Object? limit = null,
  }) {
    return _then(_$BundledCategorySectionImpl(
      articles: null == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      total: null == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as int,
      limit: null == limit
          ? _value.limit
          : limit // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BundledCategorySectionImpl implements _BundledCategorySection {
  const _$BundledCategorySectionImpl(
      {final List<NewsModel> articles = const <NewsModel>[],
      this.total = 0,
      this.limit = 0})
      : _articles = articles;

  factory _$BundledCategorySectionImpl.fromJson(Map<String, dynamic> json) =>
      _$$BundledCategorySectionImplFromJson(json);

  final List<NewsModel> _articles;
  @override
  @JsonKey()
  List<NewsModel> get articles {
    if (_articles is EqualUnmodifiableListView) return _articles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_articles);
  }

  @override
  @JsonKey()
  final int total;
  @override
  @JsonKey()
  final int limit;

  @override
  String toString() {
    return 'BundledCategorySection(articles: $articles, total: $total, limit: $limit)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BundledCategorySectionImpl &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.limit, limit) || other.limit == limit));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_articles), total, limit);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BundledCategorySectionImplCopyWith<_$BundledCategorySectionImpl>
      get copyWith => __$$BundledCategorySectionImplCopyWithImpl<
          _$BundledCategorySectionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BundledCategorySectionImplToJson(
      this,
    );
  }
}

abstract class _BundledCategorySection implements BundledCategorySection {
  const factory _BundledCategorySection(
      {final List<NewsModel> articles,
      final int total,
      final int limit}) = _$BundledCategorySectionImpl;

  factory _BundledCategorySection.fromJson(Map<String, dynamic> json) =
      _$BundledCategorySectionImpl.fromJson;

  @override
  List<NewsModel> get articles;
  @override
  int get total;
  @override
  int get limit;
  @override
  @JsonKey(ignore: true)
  _$$BundledCategorySectionImplCopyWith<_$BundledCategorySectionImpl>
      get copyWith => throw _privateConstructorUsedError;
}

BundledArticlesResponse _$BundledArticlesResponseFromJson(
    Map<String, dynamic> json) {
  return _BundledArticlesResponse.fromJson(json);
}

/// @nodoc
mixin _$BundledArticlesResponse {
  Map<String, BundledCategorySection> get categories =>
      throw _privateConstructorUsedError;
  List<NewsModel> get trending => throw _privateConstructorUsedError;
  @JsonKey(name: 'total_categories')
  int get totalCategories => throw _privateConstructorUsedError;
  @JsonKey(name: 'limit_per_category')
  int get limitPerCategory => throw _privateConstructorUsedError;
  bool get success => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BundledArticlesResponseCopyWith<BundledArticlesResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BundledArticlesResponseCopyWith<$Res> {
  factory $BundledArticlesResponseCopyWith(BundledArticlesResponse value,
          $Res Function(BundledArticlesResponse) then) =
      _$BundledArticlesResponseCopyWithImpl<$Res, BundledArticlesResponse>;
  @useResult
  $Res call(
      {Map<String, BundledCategorySection> categories,
      List<NewsModel> trending,
      @JsonKey(name: 'total_categories') int totalCategories,
      @JsonKey(name: 'limit_per_category') int limitPerCategory,
      bool success});
}

/// @nodoc
class _$BundledArticlesResponseCopyWithImpl<$Res,
        $Val extends BundledArticlesResponse>
    implements $BundledArticlesResponseCopyWith<$Res> {
  _$BundledArticlesResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? trending = null,
    Object? totalCategories = null,
    Object? limitPerCategory = null,
    Object? success = null,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Map<String, BundledCategorySection>,
      trending: null == trending
          ? _value.trending
          : trending // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      totalCategories: null == totalCategories
          ? _value.totalCategories
          : totalCategories // ignore: cast_nullable_to_non_nullable
              as int,
      limitPerCategory: null == limitPerCategory
          ? _value.limitPerCategory
          : limitPerCategory // ignore: cast_nullable_to_non_nullable
              as int,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BundledArticlesResponseImplCopyWith<$Res>
    implements $BundledArticlesResponseCopyWith<$Res> {
  factory _$$BundledArticlesResponseImplCopyWith(
          _$BundledArticlesResponseImpl value,
          $Res Function(_$BundledArticlesResponseImpl) then) =
      __$$BundledArticlesResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, BundledCategorySection> categories,
      List<NewsModel> trending,
      @JsonKey(name: 'total_categories') int totalCategories,
      @JsonKey(name: 'limit_per_category') int limitPerCategory,
      bool success});
}

/// @nodoc
class __$$BundledArticlesResponseImplCopyWithImpl<$Res>
    extends _$BundledArticlesResponseCopyWithImpl<$Res,
        _$BundledArticlesResponseImpl>
    implements _$$BundledArticlesResponseImplCopyWith<$Res> {
  __$$BundledArticlesResponseImplCopyWithImpl(
      _$BundledArticlesResponseImpl _value,
      $Res Function(_$BundledArticlesResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? trending = null,
    Object? totalCategories = null,
    Object? limitPerCategory = null,
    Object? success = null,
  }) {
    return _then(_$BundledArticlesResponseImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Map<String, BundledCategorySection>,
      trending: null == trending
          ? _value._trending
          : trending // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      totalCategories: null == totalCategories
          ? _value.totalCategories
          : totalCategories // ignore: cast_nullable_to_non_nullable
              as int,
      limitPerCategory: null == limitPerCategory
          ? _value.limitPerCategory
          : limitPerCategory // ignore: cast_nullable_to_non_nullable
              as int,
      success: null == success
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BundledArticlesResponseImpl implements _BundledArticlesResponse {
  const _$BundledArticlesResponseImpl(
      {final Map<String, BundledCategorySection> categories =
          const <String, BundledCategorySection>{},
      final List<NewsModel> trending = const <NewsModel>[],
      @JsonKey(name: 'total_categories') this.totalCategories = 0,
      @JsonKey(name: 'limit_per_category') this.limitPerCategory = 0,
      this.success = false})
      : _categories = categories,
        _trending = trending;

  factory _$BundledArticlesResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$BundledArticlesResponseImplFromJson(json);

  final Map<String, BundledCategorySection> _categories;
  @override
  @JsonKey()
  Map<String, BundledCategorySection> get categories {
    if (_categories is EqualUnmodifiableMapView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categories);
  }

  final List<NewsModel> _trending;
  @override
  @JsonKey()
  List<NewsModel> get trending {
    if (_trending is EqualUnmodifiableListView) return _trending;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trending);
  }

  @override
  @JsonKey(name: 'total_categories')
  final int totalCategories;
  @override
  @JsonKey(name: 'limit_per_category')
  final int limitPerCategory;
  @override
  @JsonKey()
  final bool success;

  @override
  String toString() {
    return 'BundledArticlesResponse(categories: $categories, trending: $trending, totalCategories: $totalCategories, limitPerCategory: $limitPerCategory, success: $success)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BundledArticlesResponseImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality().equals(other._trending, _trending) &&
            (identical(other.totalCategories, totalCategories) ||
                other.totalCategories == totalCategories) &&
            (identical(other.limitPerCategory, limitPerCategory) ||
                other.limitPerCategory == limitPerCategory) &&
            (identical(other.success, success) || other.success == success));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_trending),
      totalCategories,
      limitPerCategory,
      success);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BundledArticlesResponseImplCopyWith<_$BundledArticlesResponseImpl>
      get copyWith => __$$BundledArticlesResponseImplCopyWithImpl<
          _$BundledArticlesResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BundledArticlesResponseImplToJson(
      this,
    );
  }
}

abstract class _BundledArticlesResponse implements BundledArticlesResponse {
  const factory _BundledArticlesResponse(
      {final Map<String, BundledCategorySection> categories,
      final List<NewsModel> trending,
      @JsonKey(name: 'total_categories') final int totalCategories,
      @JsonKey(name: 'limit_per_category') final int limitPerCategory,
      final bool success}) = _$BundledArticlesResponseImpl;

  factory _BundledArticlesResponse.fromJson(Map<String, dynamic> json) =
      _$BundledArticlesResponseImpl.fromJson;

  @override
  Map<String, BundledCategorySection> get categories;
  @override
  List<NewsModel> get trending;
  @override
  @JsonKey(name: 'total_categories')
  int get totalCategories;
  @override
  @JsonKey(name: 'limit_per_category')
  int get limitPerCategory;
  @override
  bool get success;
  @override
  @JsonKey(ignore: true)
  _$$BundledArticlesResponseImplCopyWith<_$BundledArticlesResponseImpl>
      get copyWith => throw _privateConstructorUsedError;
}
