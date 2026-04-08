// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'explore_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ExploreScreenState {
  List<String> get categories => throw _privateConstructorUsedError;
  List<NewsModel> get trendingNews => throw _privateConstructorUsedError;
  Map<String, List<NewsModel>> get categoryArticles =>
      throw _privateConstructorUsedError;
  Map<String, dynamic> get bundledArticles =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ExploreScreenStateCopyWith<ExploreScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExploreScreenStateCopyWith<$Res> {
  factory $ExploreScreenStateCopyWith(
          ExploreScreenState value, $Res Function(ExploreScreenState) then) =
      _$ExploreScreenStateCopyWithImpl<$Res, ExploreScreenState>;
  @useResult
  $Res call(
      {List<String> categories,
      List<NewsModel> trendingNews,
      Map<String, List<NewsModel>> categoryArticles,
      Map<String, dynamic> bundledArticles});
}

/// @nodoc
class _$ExploreScreenStateCopyWithImpl<$Res, $Val extends ExploreScreenState>
    implements $ExploreScreenStateCopyWith<$Res> {
  _$ExploreScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? trendingNews = null,
    Object? categoryArticles = null,
    Object? bundledArticles = null,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trendingNews: null == trendingNews
          ? _value.trendingNews
          : trendingNews // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      categoryArticles: null == categoryArticles
          ? _value.categoryArticles
          : categoryArticles // ignore: cast_nullable_to_non_nullable
              as Map<String, List<NewsModel>>,
      bundledArticles: null == bundledArticles
          ? _value.bundledArticles
          : bundledArticles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExploreScreenStateImplCopyWith<$Res>
    implements $ExploreScreenStateCopyWith<$Res> {
  factory _$$ExploreScreenStateImplCopyWith(_$ExploreScreenStateImpl value,
          $Res Function(_$ExploreScreenStateImpl) then) =
      __$$ExploreScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> categories,
      List<NewsModel> trendingNews,
      Map<String, List<NewsModel>> categoryArticles,
      Map<String, dynamic> bundledArticles});
}

/// @nodoc
class __$$ExploreScreenStateImplCopyWithImpl<$Res>
    extends _$ExploreScreenStateCopyWithImpl<$Res, _$ExploreScreenStateImpl>
    implements _$$ExploreScreenStateImplCopyWith<$Res> {
  __$$ExploreScreenStateImplCopyWithImpl(_$ExploreScreenStateImpl _value,
      $Res Function(_$ExploreScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? trendingNews = null,
    Object? categoryArticles = null,
    Object? bundledArticles = null,
  }) {
    return _then(_$ExploreScreenStateImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      trendingNews: null == trendingNews
          ? _value._trendingNews
          : trendingNews // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      categoryArticles: null == categoryArticles
          ? _value._categoryArticles
          : categoryArticles // ignore: cast_nullable_to_non_nullable
              as Map<String, List<NewsModel>>,
      bundledArticles: null == bundledArticles
          ? _value._bundledArticles
          : bundledArticles // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc

class _$ExploreScreenStateImpl implements _ExploreScreenState {
  const _$ExploreScreenStateImpl(
      {final List<String> categories = const <String>[],
      final List<NewsModel> trendingNews = const <NewsModel>[],
      final Map<String, List<NewsModel>> categoryArticles =
          const <String, List<NewsModel>>{},
      final Map<String, dynamic> bundledArticles = const <String, dynamic>{}})
      : _categories = categories,
        _trendingNews = trendingNews,
        _categoryArticles = categoryArticles,
        _bundledArticles = bundledArticles;

  final List<String> _categories;
  @override
  @JsonKey()
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<NewsModel> _trendingNews;
  @override
  @JsonKey()
  List<NewsModel> get trendingNews {
    if (_trendingNews is EqualUnmodifiableListView) return _trendingNews;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_trendingNews);
  }

  final Map<String, List<NewsModel>> _categoryArticles;
  @override
  @JsonKey()
  Map<String, List<NewsModel>> get categoryArticles {
    if (_categoryArticles is EqualUnmodifiableMapView) return _categoryArticles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_categoryArticles);
  }

  final Map<String, dynamic> _bundledArticles;
  @override
  @JsonKey()
  Map<String, dynamic> get bundledArticles {
    if (_bundledArticles is EqualUnmodifiableMapView) return _bundledArticles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_bundledArticles);
  }

  @override
  String toString() {
    return 'ExploreScreenState(categories: $categories, trendingNews: $trendingNews, categoryArticles: $categoryArticles, bundledArticles: $bundledArticles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExploreScreenStateImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._trendingNews, _trendingNews) &&
            const DeepCollectionEquality()
                .equals(other._categoryArticles, _categoryArticles) &&
            const DeepCollectionEquality()
                .equals(other._bundledArticles, _bundledArticles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_trendingNews),
      const DeepCollectionEquality().hash(_categoryArticles),
      const DeepCollectionEquality().hash(_bundledArticles));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExploreScreenStateImplCopyWith<_$ExploreScreenStateImpl> get copyWith =>
      __$$ExploreScreenStateImplCopyWithImpl<_$ExploreScreenStateImpl>(
          this, _$identity);
}

abstract class _ExploreScreenState implements ExploreScreenState {
  const factory _ExploreScreenState(
      {final List<String> categories,
      final List<NewsModel> trendingNews,
      final Map<String, List<NewsModel>> categoryArticles,
      final Map<String, dynamic> bundledArticles}) = _$ExploreScreenStateImpl;

  @override
  List<String> get categories;
  @override
  List<NewsModel> get trendingNews;
  @override
  Map<String, List<NewsModel>> get categoryArticles;
  @override
  Map<String, dynamic> get bundledArticles;
  @override
  @JsonKey(ignore: true)
  _$$ExploreScreenStateImplCopyWith<_$ExploreScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
