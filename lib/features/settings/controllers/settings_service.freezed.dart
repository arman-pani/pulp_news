// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SettingsState {
  ThemeMode get themeMode => throw _privateConstructorUsedError;
  Brightness get brightness => throw _privateConstructorUsedError;
  String get selectedLanguage => throw _privateConstructorUsedError;
  bool get notificationsEnabled => throw _privateConstructorUsedError;
  bool get isUpdatingNotifications => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SettingsStateCopyWith<SettingsState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SettingsStateCopyWith<$Res> {
  factory $SettingsStateCopyWith(
          SettingsState value, $Res Function(SettingsState) then) =
      _$SettingsStateCopyWithImpl<$Res, SettingsState>;
  @useResult
  $Res call(
      {ThemeMode themeMode,
      Brightness brightness,
      String selectedLanguage,
      bool notificationsEnabled,
      bool isUpdatingNotifications});
}

/// @nodoc
class _$SettingsStateCopyWithImpl<$Res, $Val extends SettingsState>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? brightness = null,
    Object? selectedLanguage = null,
    Object? notificationsEnabled = null,
    Object? isUpdatingNotifications = null,
  }) {
    return _then(_value.copyWith(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness,
      selectedLanguage: null == selectedLanguage
          ? _value.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpdatingNotifications: null == isUpdatingNotifications
          ? _value.isUpdatingNotifications
          : isUpdatingNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SettingsStateImplCopyWith<$Res>
    implements $SettingsStateCopyWith<$Res> {
  factory _$$SettingsStateImplCopyWith(
          _$SettingsStateImpl value, $Res Function(_$SettingsStateImpl) then) =
      __$$SettingsStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ThemeMode themeMode,
      Brightness brightness,
      String selectedLanguage,
      bool notificationsEnabled,
      bool isUpdatingNotifications});
}

/// @nodoc
class __$$SettingsStateImplCopyWithImpl<$Res>
    extends _$SettingsStateCopyWithImpl<$Res, _$SettingsStateImpl>
    implements _$$SettingsStateImplCopyWith<$Res> {
  __$$SettingsStateImplCopyWithImpl(
      _$SettingsStateImpl _value, $Res Function(_$SettingsStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? themeMode = null,
    Object? brightness = null,
    Object? selectedLanguage = null,
    Object? notificationsEnabled = null,
    Object? isUpdatingNotifications = null,
  }) {
    return _then(_$SettingsStateImpl(
      themeMode: null == themeMode
          ? _value.themeMode
          : themeMode // ignore: cast_nullable_to_non_nullable
              as ThemeMode,
      brightness: null == brightness
          ? _value.brightness
          : brightness // ignore: cast_nullable_to_non_nullable
              as Brightness,
      selectedLanguage: null == selectedLanguage
          ? _value.selectedLanguage
          : selectedLanguage // ignore: cast_nullable_to_non_nullable
              as String,
      notificationsEnabled: null == notificationsEnabled
          ? _value.notificationsEnabled
          : notificationsEnabled // ignore: cast_nullable_to_non_nullable
              as bool,
      isUpdatingNotifications: null == isUpdatingNotifications
          ? _value.isUpdatingNotifications
          : isUpdatingNotifications // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SettingsStateImpl implements _SettingsState {
  const _$SettingsStateImpl(
      {required this.themeMode,
      required this.brightness,
      required this.selectedLanguage,
      required this.notificationsEnabled,
      this.isUpdatingNotifications = false});

  @override
  final ThemeMode themeMode;
  @override
  final Brightness brightness;
  @override
  final String selectedLanguage;
  @override
  final bool notificationsEnabled;
  @override
  @JsonKey()
  final bool isUpdatingNotifications;

  @override
  String toString() {
    return 'SettingsState(themeMode: $themeMode, brightness: $brightness, selectedLanguage: $selectedLanguage, notificationsEnabled: $notificationsEnabled, isUpdatingNotifications: $isUpdatingNotifications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SettingsStateImpl &&
            (identical(other.themeMode, themeMode) ||
                other.themeMode == themeMode) &&
            (identical(other.brightness, brightness) ||
                other.brightness == brightness) &&
            (identical(other.selectedLanguage, selectedLanguage) ||
                other.selectedLanguage == selectedLanguage) &&
            (identical(other.notificationsEnabled, notificationsEnabled) ||
                other.notificationsEnabled == notificationsEnabled) &&
            (identical(
                    other.isUpdatingNotifications, isUpdatingNotifications) ||
                other.isUpdatingNotifications == isUpdatingNotifications));
  }

  @override
  int get hashCode => Object.hash(runtimeType, themeMode, brightness,
      selectedLanguage, notificationsEnabled, isUpdatingNotifications);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      __$$SettingsStateImplCopyWithImpl<_$SettingsStateImpl>(this, _$identity);
}

abstract class _SettingsState implements SettingsState {
  const factory _SettingsState(
      {required final ThemeMode themeMode,
      required final Brightness brightness,
      required final String selectedLanguage,
      required final bool notificationsEnabled,
      final bool isUpdatingNotifications}) = _$SettingsStateImpl;

  @override
  ThemeMode get themeMode;
  @override
  Brightness get brightness;
  @override
  String get selectedLanguage;
  @override
  bool get notificationsEnabled;
  @override
  bool get isUpdatingNotifications;
  @override
  @JsonKey(ignore: true)
  _$$SettingsStateImplCopyWith<_$SettingsStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
