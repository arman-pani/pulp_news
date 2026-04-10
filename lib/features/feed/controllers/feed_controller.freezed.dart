// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'feed_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FeedScreenState {
  List<NewsModel> get articles => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  bool get noMoreArticles => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $FeedScreenStateCopyWith<FeedScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeedScreenStateCopyWith<$Res> {
  factory $FeedScreenStateCopyWith(
          FeedScreenState value, $Res Function(FeedScreenState) then) =
      _$FeedScreenStateCopyWithImpl<$Res, FeedScreenState>;
  @useResult
  $Res call({List<NewsModel> articles, bool isLoading, bool noMoreArticles});
}

/// @nodoc
class _$FeedScreenStateCopyWithImpl<$Res, $Val extends FeedScreenState>
    implements $FeedScreenStateCopyWith<$Res> {
  _$FeedScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? isLoading = null,
    Object? noMoreArticles = null,
  }) {
    return _then(_value.copyWith(
      articles: null == articles
          ? _value.articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      noMoreArticles: null == noMoreArticles
          ? _value.noMoreArticles
          : noMoreArticles // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeedScreenStateImplCopyWith<$Res>
    implements $FeedScreenStateCopyWith<$Res> {
  factory _$$FeedScreenStateImplCopyWith(_$FeedScreenStateImpl value,
          $Res Function(_$FeedScreenStateImpl) then) =
      __$$FeedScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<NewsModel> articles, bool isLoading, bool noMoreArticles});
}

/// @nodoc
class __$$FeedScreenStateImplCopyWithImpl<$Res>
    extends _$FeedScreenStateCopyWithImpl<$Res, _$FeedScreenStateImpl>
    implements _$$FeedScreenStateImplCopyWith<$Res> {
  __$$FeedScreenStateImplCopyWithImpl(
      _$FeedScreenStateImpl _value, $Res Function(_$FeedScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? articles = null,
    Object? isLoading = null,
    Object? noMoreArticles = null,
  }) {
    return _then(_$FeedScreenStateImpl(
      articles: null == articles
          ? _value._articles
          : articles // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      noMoreArticles: null == noMoreArticles
          ? _value.noMoreArticles
          : noMoreArticles // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FeedScreenStateImpl implements _FeedScreenState {
  const _$FeedScreenStateImpl(
      {final List<NewsModel> articles = const <NewsModel>[],
      this.isLoading = false,
      this.noMoreArticles = false})
      : _articles = articles;

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
  final bool noMoreArticles;

  @override
  String toString() {
    return 'FeedScreenState(articles: $articles, isLoading: $isLoading, noMoreArticles: $noMoreArticles)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeedScreenStateImpl &&
            const DeepCollectionEquality().equals(other._articles, _articles) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.noMoreArticles, noMoreArticles) ||
                other.noMoreArticles == noMoreArticles));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_articles),
      isLoading,
      noMoreArticles);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeedScreenStateImplCopyWith<_$FeedScreenStateImpl> get copyWith =>
      __$$FeedScreenStateImplCopyWithImpl<_$FeedScreenStateImpl>(
          this, _$identity);
}

abstract class _FeedScreenState implements FeedScreenState {
  const factory _FeedScreenState(
      {final List<NewsModel> articles,
      final bool isLoading,
      final bool noMoreArticles}) = _$FeedScreenStateImpl;

  @override
  List<NewsModel> get articles;
  @override
  bool get isLoading;
  @override
  bool get noMoreArticles;
  @override
  @JsonKey(ignore: true)
  _$$FeedScreenStateImplCopyWith<_$FeedScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
