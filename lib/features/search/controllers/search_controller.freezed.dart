// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchScreenState {
  List<NewsModel> get searchResults => throw _privateConstructorUsedError;
  List<String> get recentSearches => throw _privateConstructorUsedError;
  bool get isSearching => throw _privateConstructorUsedError;
  String get currentQuery => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchScreenStateCopyWith<SearchScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchScreenStateCopyWith<$Res> {
  factory $SearchScreenStateCopyWith(
          SearchScreenState value, $Res Function(SearchScreenState) then) =
      _$SearchScreenStateCopyWithImpl<$Res, SearchScreenState>;
  @useResult
  $Res call(
      {List<NewsModel> searchResults,
      List<String> recentSearches,
      bool isSearching,
      String currentQuery});
}

/// @nodoc
class _$SearchScreenStateCopyWithImpl<$Res, $Val extends SearchScreenState>
    implements $SearchScreenStateCopyWith<$Res> {
  _$SearchScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchResults = null,
    Object? recentSearches = null,
    Object? isSearching = null,
    Object? currentQuery = null,
  }) {
    return _then(_value.copyWith(
      searchResults: null == searchResults
          ? _value.searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      recentSearches: null == recentSearches
          ? _value.recentSearches
          : recentSearches // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isSearching: null == isSearching
          ? _value.isSearching
          : isSearching // ignore: cast_nullable_to_non_nullable
              as bool,
      currentQuery: null == currentQuery
          ? _value.currentQuery
          : currentQuery // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchScreenStateImplCopyWith<$Res>
    implements $SearchScreenStateCopyWith<$Res> {
  factory _$$SearchScreenStateImplCopyWith(_$SearchScreenStateImpl value,
          $Res Function(_$SearchScreenStateImpl) then) =
      __$$SearchScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<NewsModel> searchResults,
      List<String> recentSearches,
      bool isSearching,
      String currentQuery});
}

/// @nodoc
class __$$SearchScreenStateImplCopyWithImpl<$Res>
    extends _$SearchScreenStateCopyWithImpl<$Res, _$SearchScreenStateImpl>
    implements _$$SearchScreenStateImplCopyWith<$Res> {
  __$$SearchScreenStateImplCopyWithImpl(_$SearchScreenStateImpl _value,
      $Res Function(_$SearchScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchResults = null,
    Object? recentSearches = null,
    Object? isSearching = null,
    Object? currentQuery = null,
  }) {
    return _then(_$SearchScreenStateImpl(
      searchResults: null == searchResults
          ? _value._searchResults
          : searchResults // ignore: cast_nullable_to_non_nullable
              as List<NewsModel>,
      recentSearches: null == recentSearches
          ? _value._recentSearches
          : recentSearches // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isSearching: null == isSearching
          ? _value.isSearching
          : isSearching // ignore: cast_nullable_to_non_nullable
              as bool,
      currentQuery: null == currentQuery
          ? _value.currentQuery
          : currentQuery // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$SearchScreenStateImpl implements _SearchScreenState {
  const _$SearchScreenStateImpl(
      {final List<NewsModel> searchResults = const <NewsModel>[],
      final List<String> recentSearches = const <String>[],
      this.isSearching = false,
      this.currentQuery = ''})
      : _searchResults = searchResults,
        _recentSearches = recentSearches;

  final List<NewsModel> _searchResults;
  @override
  @JsonKey()
  List<NewsModel> get searchResults {
    if (_searchResults is EqualUnmodifiableListView) return _searchResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_searchResults);
  }

  final List<String> _recentSearches;
  @override
  @JsonKey()
  List<String> get recentSearches {
    if (_recentSearches is EqualUnmodifiableListView) return _recentSearches;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recentSearches);
  }

  @override
  @JsonKey()
  final bool isSearching;
  @override
  @JsonKey()
  final String currentQuery;

  @override
  String toString() {
    return 'SearchScreenState(searchResults: $searchResults, recentSearches: $recentSearches, isSearching: $isSearching, currentQuery: $currentQuery)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchScreenStateImpl &&
            const DeepCollectionEquality()
                .equals(other._searchResults, _searchResults) &&
            const DeepCollectionEquality()
                .equals(other._recentSearches, _recentSearches) &&
            (identical(other.isSearching, isSearching) ||
                other.isSearching == isSearching) &&
            (identical(other.currentQuery, currentQuery) ||
                other.currentQuery == currentQuery));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_searchResults),
      const DeepCollectionEquality().hash(_recentSearches),
      isSearching,
      currentQuery);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchScreenStateImplCopyWith<_$SearchScreenStateImpl> get copyWith =>
      __$$SearchScreenStateImplCopyWithImpl<_$SearchScreenStateImpl>(
          this, _$identity);
}

abstract class _SearchScreenState implements SearchScreenState {
  const factory _SearchScreenState(
      {final List<NewsModel> searchResults,
      final List<String> recentSearches,
      final bool isSearching,
      final String currentQuery}) = _$SearchScreenStateImpl;

  @override
  List<NewsModel> get searchResults;
  @override
  List<String> get recentSearches;
  @override
  bool get isSearching;
  @override
  String get currentQuery;
  @override
  @JsonKey(ignore: true)
  _$$SearchScreenStateImplCopyWith<_$SearchScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
