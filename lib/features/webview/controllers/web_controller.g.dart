// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'web_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$webControllerHash() => r'408fc5975e93203ad160a67758e497b836f82a5b';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$WebController
    extends BuildlessAutoDisposeNotifier<WebScreenState> {
  late final String initialUrl;
  late final String initialTitle;

  WebScreenState build(
    String initialUrl,
    String initialTitle,
  );
}

/// See also [WebController].
@ProviderFor(WebController)
const webControllerProvider = WebControllerFamily();

/// See also [WebController].
class WebControllerFamily extends Family<WebScreenState> {
  /// See also [WebController].
  const WebControllerFamily();

  /// See also [WebController].
  WebControllerProvider call(
    String initialUrl,
    String initialTitle,
  ) {
    return WebControllerProvider(
      initialUrl,
      initialTitle,
    );
  }

  @override
  WebControllerProvider getProviderOverride(
    covariant WebControllerProvider provider,
  ) {
    return call(
      provider.initialUrl,
      provider.initialTitle,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'webControllerProvider';
}

/// See also [WebController].
class WebControllerProvider
    extends AutoDisposeNotifierProviderImpl<WebController, WebScreenState> {
  /// See also [WebController].
  WebControllerProvider(
    String initialUrl,
    String initialTitle,
  ) : this._internal(
          () => WebController()
            ..initialUrl = initialUrl
            ..initialTitle = initialTitle,
          from: webControllerProvider,
          name: r'webControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$webControllerHash,
          dependencies: WebControllerFamily._dependencies,
          allTransitiveDependencies:
              WebControllerFamily._allTransitiveDependencies,
          initialUrl: initialUrl,
          initialTitle: initialTitle,
        );

  WebControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.initialUrl,
    required this.initialTitle,
  }) : super.internal();

  final String initialUrl;
  final String initialTitle;

  @override
  WebScreenState runNotifierBuild(
    covariant WebController notifier,
  ) {
    return notifier.build(
      initialUrl,
      initialTitle,
    );
  }

  @override
  Override overrideWith(WebController Function() create) {
    return ProviderOverride(
      origin: this,
      override: WebControllerProvider._internal(
        () => create()
          ..initialUrl = initialUrl
          ..initialTitle = initialTitle,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        initialUrl: initialUrl,
        initialTitle: initialTitle,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<WebController, WebScreenState>
      createElement() {
    return _WebControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WebControllerProvider &&
        other.initialUrl == initialUrl &&
        other.initialTitle == initialTitle;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, initialUrl.hashCode);
    hash = _SystemHash.combine(hash, initialTitle.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin WebControllerRef on AutoDisposeNotifierProviderRef<WebScreenState> {
  /// The parameter `initialUrl` of this provider.
  String get initialUrl;

  /// The parameter `initialTitle` of this provider.
  String get initialTitle;
}

class _WebControllerProviderElement
    extends AutoDisposeNotifierProviderElement<WebController, WebScreenState>
    with WebControllerRef {
  _WebControllerProviderElement(super.provider);

  @override
  String get initialUrl => (origin as WebControllerProvider).initialUrl;
  @override
  String get initialTitle => (origin as WebControllerProvider).initialTitle;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
