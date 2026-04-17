// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'language_controller.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LanguageScreenState {
  List<LanguageOption> get languages => throw _privateConstructorUsedError;
  String? get currentLanguageCode => throw _privateConstructorUsedError;
  String? get selectedLanguageCode => throw _privateConstructorUsedError;
  bool get isSubmitting => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LanguageScreenStateCopyWith<LanguageScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LanguageScreenStateCopyWith<$Res> {
  factory $LanguageScreenStateCopyWith(
          LanguageScreenState value, $Res Function(LanguageScreenState) then) =
      _$LanguageScreenStateCopyWithImpl<$Res, LanguageScreenState>;
  @useResult
  $Res call(
      {List<LanguageOption> languages,
      String? currentLanguageCode,
      String? selectedLanguageCode,
      bool isSubmitting});
}

/// @nodoc
class _$LanguageScreenStateCopyWithImpl<$Res, $Val extends LanguageScreenState>
    implements $LanguageScreenStateCopyWith<$Res> {
  _$LanguageScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languages = null,
    Object? currentLanguageCode = freezed,
    Object? selectedLanguageCode = freezed,
    Object? isSubmitting = null,
  }) {
    return _then(_value.copyWith(
      languages: null == languages
          ? _value.languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<LanguageOption>,
      currentLanguageCode: freezed == currentLanguageCode
          ? _value.currentLanguageCode
          : currentLanguageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedLanguageCode: freezed == selectedLanguageCode
          ? _value.selectedLanguageCode
          : selectedLanguageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LanguageScreenStateImplCopyWith<$Res>
    implements $LanguageScreenStateCopyWith<$Res> {
  factory _$$LanguageScreenStateImplCopyWith(_$LanguageScreenStateImpl value,
          $Res Function(_$LanguageScreenStateImpl) then) =
      __$$LanguageScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<LanguageOption> languages,
      String? currentLanguageCode,
      String? selectedLanguageCode,
      bool isSubmitting});
}

/// @nodoc
class __$$LanguageScreenStateImplCopyWithImpl<$Res>
    extends _$LanguageScreenStateCopyWithImpl<$Res, _$LanguageScreenStateImpl>
    implements _$$LanguageScreenStateImplCopyWith<$Res> {
  __$$LanguageScreenStateImplCopyWithImpl(_$LanguageScreenStateImpl _value,
      $Res Function(_$LanguageScreenStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? languages = null,
    Object? currentLanguageCode = freezed,
    Object? selectedLanguageCode = freezed,
    Object? isSubmitting = null,
  }) {
    return _then(_$LanguageScreenStateImpl(
      languages: null == languages
          ? _value._languages
          : languages // ignore: cast_nullable_to_non_nullable
              as List<LanguageOption>,
      currentLanguageCode: freezed == currentLanguageCode
          ? _value.currentLanguageCode
          : currentLanguageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      selectedLanguageCode: freezed == selectedLanguageCode
          ? _value.selectedLanguageCode
          : selectedLanguageCode // ignore: cast_nullable_to_non_nullable
              as String?,
      isSubmitting: null == isSubmitting
          ? _value.isSubmitting
          : isSubmitting // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$LanguageScreenStateImpl implements _LanguageScreenState {
  const _$LanguageScreenStateImpl(
      {final List<LanguageOption> languages = const <LanguageOption>[],
      this.currentLanguageCode,
      this.selectedLanguageCode,
      this.isSubmitting = false})
      : _languages = languages;

  final List<LanguageOption> _languages;
  @override
  @JsonKey()
  List<LanguageOption> get languages {
    if (_languages is EqualUnmodifiableListView) return _languages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_languages);
  }

  @override
  final String? currentLanguageCode;
  @override
  final String? selectedLanguageCode;
  @override
  @JsonKey()
  final bool isSubmitting;

  @override
  String toString() {
    return 'LanguageScreenState(languages: $languages, currentLanguageCode: $currentLanguageCode, selectedLanguageCode: $selectedLanguageCode, isSubmitting: $isSubmitting)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LanguageScreenStateImpl &&
            const DeepCollectionEquality()
                .equals(other._languages, _languages) &&
            (identical(other.currentLanguageCode, currentLanguageCode) ||
                other.currentLanguageCode == currentLanguageCode) &&
            (identical(other.selectedLanguageCode, selectedLanguageCode) ||
                other.selectedLanguageCode == selectedLanguageCode) &&
            (identical(other.isSubmitting, isSubmitting) ||
                other.isSubmitting == isSubmitting));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_languages),
      currentLanguageCode,
      selectedLanguageCode,
      isSubmitting);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LanguageScreenStateImplCopyWith<_$LanguageScreenStateImpl> get copyWith =>
      __$$LanguageScreenStateImplCopyWithImpl<_$LanguageScreenStateImpl>(
          this, _$identity);
}

abstract class _LanguageScreenState implements LanguageScreenState {
  const factory _LanguageScreenState(
      {final List<LanguageOption> languages,
      final String? currentLanguageCode,
      final String? selectedLanguageCode,
      final bool isSubmitting}) = _$LanguageScreenStateImpl;

  @override
  List<LanguageOption> get languages;
  @override
  String? get currentLanguageCode;
  @override
  String? get selectedLanguageCode;
  @override
  bool get isSubmitting;
  @override
  @JsonKey(ignore: true)
  _$$LanguageScreenStateImplCopyWith<_$LanguageScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
