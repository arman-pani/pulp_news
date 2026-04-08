// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'web_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WebScreenState {
  String get currentUrl => throw _privateConstructorUsedError;
  String get pageTitle => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WebScreenStateCopyWith<WebScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebScreenStateCopyWith<$Res> {
  factory $WebScreenStateCopyWith(
          WebScreenState value, $Res Function(WebScreenState) then) =
      _$WebScreenStateCopyWithImpl<$Res, WebScreenState>;
  @useResult
  $Res call(
      {String currentUrl,
      String pageTitle,
      bool isLoading,
      String errorMessage});
}

/// @nodoc
class _$WebScreenStateCopyWithImpl<$Res, $Val extends WebScreenState>
    implements $WebScreenStateCopyWith<$Res> {
  _$WebScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUrl = null,
    Object? pageTitle = null,
    Object? isLoading = null,
    Object? errorMessage = null,
  }) {
    return _then(_value.copyWith(
      currentUrl: null == currentUrl
          ? _value.currentUrl
          : currentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      pageTitle: null == pageTitle
          ? _value.pageTitle
          : pageTitle // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WebScreenStateImplCopyWith<$Res>
    implements $WebScreenStateCopyWith<$Res> {
  factory _$$WebScreenStateImplCopyWith(_$WebScreenStateImpl value,
          $Res Function(_$WebScreenStateImpl) then) =
      __$$WebScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String currentUrl,
      String pageTitle,
      bool isLoading,
      String errorMessage});
}

/// @nodoc
class __$$WebScreenStateImplCopyWithImpl<$Res>
    extends _$WebScreenStateCopyWithImpl<$Res, _$WebScreenStateImpl>
    implements _$$WebScreenStateImplCopyWith<$Res> {
  __$$WebScreenStateImplCopyWithImpl(
      _$WebScreenStateImpl _value, $Res Function(_$WebScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentUrl = null,
    Object? pageTitle = null,
    Object? isLoading = null,
    Object? errorMessage = null,
  }) {
    return _then(_$WebScreenStateImpl(
      currentUrl: null == currentUrl
          ? _value.currentUrl
          : currentUrl // ignore: cast_nullable_to_non_nullable
              as String,
      pageTitle: null == pageTitle
          ? _value.pageTitle
          : pageTitle // ignore: cast_nullable_to_non_nullable
              as String,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: null == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WebScreenStateImpl implements _WebScreenState {
  const _$WebScreenStateImpl(
      {required this.currentUrl,
      required this.pageTitle,
      this.isLoading = true,
      this.errorMessage = ''});

  @override
  final String currentUrl;
  @override
  final String pageTitle;
  @override
  @JsonKey()
  final bool isLoading;
  @override
  @JsonKey()
  final String errorMessage;

  @override
  String toString() {
    return 'WebScreenState(currentUrl: $currentUrl, pageTitle: $pageTitle, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebScreenStateImpl &&
            (identical(other.currentUrl, currentUrl) ||
                other.currentUrl == currentUrl) &&
            (identical(other.pageTitle, pageTitle) ||
                other.pageTitle == pageTitle) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, currentUrl, pageTitle, isLoading, errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WebScreenStateImplCopyWith<_$WebScreenStateImpl> get copyWith =>
      __$$WebScreenStateImplCopyWithImpl<_$WebScreenStateImpl>(
          this, _$identity);
}

abstract class _WebScreenState implements WebScreenState {
  const factory _WebScreenState(
      {required final String currentUrl,
      required final String pageTitle,
      final bool isLoading,
      final String errorMessage}) = _$WebScreenStateImpl;

  @override
  String get currentUrl;
  @override
  String get pageTitle;
  @override
  bool get isLoading;
  @override
  String get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$WebScreenStateImplCopyWith<_$WebScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
