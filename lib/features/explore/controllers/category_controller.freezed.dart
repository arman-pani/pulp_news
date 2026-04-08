// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'category_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CategoryScreenState {
  String get categoryName => throw _privateConstructorUsedError;
  List<NewsModel> get articles => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get isLoadingMore => throw _privateConstructorUsedError;
  bool get hasMoreArticles => throw _privateConstructorUsedError;
  int get currentOffset => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CategoryScreenStateCopyWith<CategoryScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryScreenStateCopyWith<$Res> {
  factory $CategoryScreenStateCopyWith(
          CategoryScreenState value, $Res Function(CategoryScreenState) then) =
      _$CategoryScreenStateCopyWithImpl<$Res, CategoryScreenState>;
  @useResult
  $Res call(
      {String categoryName,
      List<NewsModel> articles,
      bool isLoading,
      bool isLoadingMore,
      bool hasMoreArticles,
      int currentOffset});
}

/// @nodoc
class _$CategoryScreenStateCopyWithImpl<$Res, $Val extends CategoryScreenState>
    implements $CategoryScreenStateCopyWith<$Res> {
  _$CategoryScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryName = null,
    Object? articles = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMoreArticles = null,
    Object? currentOffset = null,
  }) {
    return _then(_value.copyWith(
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      articles: null == articles
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreArticles: null == hasMoreArticles
          ? _value.hasMoreArticles
          : hasMoreArticles // ignore: cast_nullable_to_non_nullable
              as bool,
      currentOffset: null == currentOffset
          ? _value.currentOffset
          : currentOffset // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryScreenStateImplCopyWith<$Res>
    implements $CategoryScreenStateCopyWith<$Res> {
  factory _$$CategoryScreenStateImplCopyWith(_$CategoryScreenStateImpl value,
          $Res Function(_$CategoryScreenStateImpl) then) =
      __$$CategoryScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String categoryName,
      List<NewsModel> articles,
      bool isLoading,
      bool isLoadingMore,
      bool hasMoreArticles,
      int currentOffset});
}

/// @nodoc
class __$$CategoryScreenStateImplCopyWithImpl<$Res>
    extends _$CategoryScreenStateCopyWithImpl<$Res, _$CategoryScreenStateImpl>
    implements _$$CategoryScreenStateImplCopyWith<$Res> {
  __$$CategoryScreenStateImplCopyWithImpl(_$CategoryScreenStateImpl _value,
      $Res Function(_$CategoryScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categoryName = null,
    Object? articles = null,
    Object? isLoading = null,
    Object? isLoadingMore = null,
    Object? hasMoreArticles = null,
    Object? currentOffset = null,
  }) {
    return _then(_$CategoryScreenStateImpl(
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      articles: null == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isLoadingMore: null == isLoadingMore
          ? _value.isLoadingMore
          : isLoadingMore // ignore: cast_nullable_to_non_nullable
              as bool,
      hasMoreArticles: null == hasMoreArticles
          ? _value.hasMoreArticles
          : hasMoreArticles // ignore: cast_nullable_to_non_nullable
              as bool,
      currentOffset: null == currentOffset
          ? _value.currentOffset
          : currentOffset // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$CategoryScreenStateImpl implements _CategoryScreenState {
  const _$CategoryScreenStateImpl(
      {required this.categoryName,
      final List<NewsModel> articles = const <NewsModel>[],
      this.isLoading = false,
      this.isLoadingMore = false,
      this.hasMoreArticles = true,
      this.currentOffset = 0})
      : _articles = articles;

  @override
  final String categoryName;
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
  final bool isLoading;
  @override
  @JsonKey()
  final bool isLoadingMore;
  @override
  @JsonKey()
  final bool hasMoreArticles;
  @override
  @JsonKey()
  final int currentOffset;

  @override
  String toString() {
    return 'CategoryScreenState(categoryName: $categoryName, articles: $articles, isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMoreArticles: $hasMoreArticles, currentOffset: $currentOffset)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryScreenStateImpl &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.isLoadingMore, isLoadingMore) ||
                other.isLoadingMore == isLoadingMore) &&
            (identical(other.hasMoreArticles, hasMoreArticles) ||
                other.hasMoreArticles == hasMoreArticles) &&
            (identical(other.currentOffset, currentOffset) ||
                other.currentOffset == currentOffset));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      categoryName,
      const DeepCollectionEquality().hash(_articles),
      isLoading,
      isLoadingMore,
      hasMoreArticles,
      currentOffset);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryScreenStateImplCopyWith<_$CategoryScreenStateImpl> get copyWith =>
      __$$CategoryScreenStateImplCopyWithImpl<_$CategoryScreenStateImpl>(
          this, _$identity);
}

abstract class _CategoryScreenState implements CategoryScreenState {
  const factory _CategoryScreenState(
      {required final String categoryName,
      final List<NewsModel> articles,
      final bool isLoading,
      final bool isLoadingMore,
      final bool hasMoreArticles,
      final int currentOffset}) = _$CategoryScreenStateImpl;

  @override
  String get categoryName;
  @override
  List<NewsModel> get articles;
  @override
  bool get isLoading;
  @override
  bool get isLoadingMore;
  @override
  bool get hasMoreArticles;
  @override
  int get currentOffset;
  @override
  @JsonKey(ignore: true)
  _$$CategoryScreenStateImplCopyWith<_$CategoryScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
