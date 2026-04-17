// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'home_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HomeScreenState {
  List<String> get categories => throw _privateConstructorUsedError;
  List<NewsModel> get trendingNews => throw _privateConstructorUsedError;
  Map<String, List<NewsModel>> get categoryArticles =>
      throw _privateConstructorUsedError;
  BundledArticlesResponse? get bundledArticles =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomeScreenStateCopyWith<HomeScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomeScreenStateCopyWith<$Res> {
  factory $HomeScreenStateCopyWith(
          HomeScreenState value, $Res Function(HomeScreenState) then) =
      _$HomeScreenStateCopyWithImpl<$Res, HomeScreenState>;
  @useResult
  $Res call(
      {List<String> categories,
      List<NewsModel> trendingNews,
      Map<String, List<NewsModel>> categoryArticles,
      BundledArticlesResponse? bundledArticles});

  $BundledArticlesResponseCopyWith<$Res>? get bundledArticles;
}

/// @nodoc
class _$HomeScreenStateCopyWithImpl<$Res, $Val extends HomeScreenState>
    implements $HomeScreenStateCopyWith<$Res> {
  _$HomeScreenStateCopyWithImpl(this._value, this._then);

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
    Object? bundledArticles = freezed,
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
      bundledArticles: freezed == bundledArticles
          ? _value.bundledArticles
          : bundledArticles // ignore: cast_nullable_to_non_nullable
              as BundledArticlesResponse?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BundledArticlesResponseCopyWith<$Res>? get bundledArticles {
    if (_value.bundledArticles == null) {
      return null;
    }

    return $BundledArticlesResponseCopyWith<$Res>(_value.bundledArticles!,
        (value) {
      return _then(_value.copyWith(bundledArticles: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HomeScreenStateImplCopyWith<$Res>
    implements $HomeScreenStateCopyWith<$Res> {
  factory _$$HomeScreenStateImplCopyWith(_$HomeScreenStateImpl value,
          $Res Function(_$HomeScreenStateImpl) then) =
      __$$HomeScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> categories,
      List<NewsModel> trendingNews,
      Map<String, List<NewsModel>> categoryArticles,
      BundledArticlesResponse? bundledArticles});

  @override
  $BundledArticlesResponseCopyWith<$Res>? get bundledArticles;
}

/// @nodoc
class __$$HomeScreenStateImplCopyWithImpl<$Res>
    extends _$HomeScreenStateCopyWithImpl<$Res, _$HomeScreenStateImpl>
    implements _$$HomeScreenStateImplCopyWith<$Res> {
  __$$HomeScreenStateImplCopyWithImpl(
      _$HomeScreenStateImpl _value, $Res Function(_$HomeScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? trendingNews = null,
    Object? categoryArticles = null,
    Object? bundledArticles = freezed,
  }) {
    return _then(_$HomeScreenStateImpl(
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
      bundledArticles: freezed == bundledArticles
          ? _value.bundledArticles
          : bundledArticles // ignore: cast_nullable_to_non_nullable
              as BundledArticlesResponse?,
    ));
  }
}

/// @nodoc

class _$HomeScreenStateImpl implements _HomeScreenState {
  const _$HomeScreenStateImpl(
      {final List<String> categories = const <String>[],
      final List<NewsModel> trendingNews = const <NewsModel>[],
      final Map<String, List<NewsModel>> categoryArticles =
          const <String, List<NewsModel>>{},
      this.bundledArticles})
      : _categories = categories,
        _trendingNews = trendingNews,
        _categoryArticles = categoryArticles;

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

  @override
  final BundledArticlesResponse? bundledArticles;

  @override
  String toString() {
    return 'HomeScreenState(categories: $categories, trendingNews: $trendingNews, categoryArticles: $categoryArticles, bundledArticles: $bundledArticles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HomeScreenStateImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._trendingNews, _trendingNews) &&
            const DeepCollectionEquality()
                .equals(other._categoryArticles, _categoryArticles) &&
            (identical(other.bundledArticles, bundledArticles) ||
                other.bundledArticles == bundledArticles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_trendingNews),
      const DeepCollectionEquality().hash(_categoryArticles),
      bundledArticles);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$HomeScreenStateImplCopyWith<_$HomeScreenStateImpl> get copyWith =>
      __$$HomeScreenStateImplCopyWithImpl<_$HomeScreenStateImpl>(
          this, _$identity);
}

abstract class _HomeScreenState implements HomeScreenState {
  const factory _HomeScreenState(
      {final List<String> categories,
      final List<NewsModel> trendingNews,
      final Map<String, List<NewsModel>> categoryArticles,
      final BundledArticlesResponse? bundledArticles}) = _$HomeScreenStateImpl;

  @override
  List<String> get categories;
  @override
  List<NewsModel> get trendingNews;
  @override
  Map<String, List<NewsModel>> get categoryArticles;
  @override
  BundledArticlesResponse? get bundledArticles;
  @override
  @JsonKey(ignore: true)
  _$$HomeScreenStateImplCopyWith<_$HomeScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
