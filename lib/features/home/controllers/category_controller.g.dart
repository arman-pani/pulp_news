// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$categoryControllerHash() =>
    r'38a3aee79a0b4cc0bf6c450a0cd914fabada9a82';

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

abstract class _$CategoryController
    extends BuildlessAutoDisposeAsyncNotifier<CategoryScreenState> {
  late final String categoryName;

  FutureOr<CategoryScreenState> build(
    String categoryName,
  );
}

/// See also [CategoryController].
@ProviderFor(CategoryController)
const categoryControllerProvider = CategoryControllerFamily();

/// See also [CategoryController].
class CategoryControllerFamily extends Family<AsyncValue<CategoryScreenState>> {
  /// See also [CategoryController].
  const CategoryControllerFamily();

  /// See also [CategoryController].
  CategoryControllerProvider call(
    String categoryName,
  ) {
    return CategoryControllerProvider(
      categoryName,
    );
  }

  @override
  CategoryControllerProvider getProviderOverride(
    covariant CategoryControllerProvider provider,
  ) {
    return call(
      provider.categoryName,
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
  String? get name => r'categoryControllerProvider';
}

/// See also [CategoryController].
class CategoryControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    CategoryController, CategoryScreenState> {
  /// See also [CategoryController].
  CategoryControllerProvider(
    String categoryName,
  ) : this._internal(
          () => CategoryController()..categoryName = categoryName,
          from: categoryControllerProvider,
          name: r'categoryControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$categoryControllerHash,
          dependencies: CategoryControllerFamily._dependencies,
          allTransitiveDependencies:
              CategoryControllerFamily._allTransitiveDependencies,
          categoryName: categoryName,
        );

  CategoryControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.categoryName,
  }) : super.internal();

  final String categoryName;

  @override
  FutureOr<CategoryScreenState> runNotifierBuild(
    covariant CategoryController notifier,
  ) {
    return notifier.build(
      categoryName,
    );
  }

  @override
  Override overrideWith(CategoryController Function() create) {
    return ProviderOverride(
      origin: this,
      override: CategoryControllerProvider._internal(
        () => create()..categoryName = categoryName,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        categoryName: categoryName,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<CategoryController,
      CategoryScreenState> createElement() {
    return _CategoryControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CategoryControllerProvider &&
        other.categoryName == categoryName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, categoryName.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin CategoryControllerRef
    on AutoDisposeAsyncNotifierProviderRef<CategoryScreenState> {
  /// The parameter `categoryName` of this provider.
  String get categoryName;
}

class _CategoryControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<CategoryController,
        CategoryScreenState> with CategoryControllerRef {
  _CategoryControllerProviderElement(super.provider);

  @override
  String get categoryName =>
      (origin as CategoryControllerProvider).categoryName;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
