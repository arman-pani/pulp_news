import 'package:odiya_news_app/features/language/models/language_option.dart';

abstract class LanguagesDataSource {
  Future<List<LanguageOption>> fetchAvailableLanguages();
}

class SeededLanguagesDataSource implements LanguagesDataSource {
  const SeededLanguagesDataSource();

  @override
  Future<List<LanguageOption>> fetchAvailableLanguages() async {
    final languages = <LanguageOption>[
      const LanguageOption(
        code: 'english',
        displayName: 'English',
        nativeName: 'English',
        sortOrder: 1,
      ),
      const LanguageOption(
        code: 'odia',
        displayName: 'Odia',
        nativeName: 'ଓଡ଼ିଆ',
        sortOrder: 2,
      ),
      const LanguageOption(
        code: 'bengali',
        displayName: 'Bengali',
        nativeName: 'বাংলা',
        sortOrder: 3,
      ),
    ];

    languages.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return languages;
  }
}

class LanguagesRepository {
  LanguagesRepository({LanguagesDataSource? dataSource})
    : _dataSource = dataSource ?? const SeededLanguagesDataSource();

  final LanguagesDataSource _dataSource;

  Future<List<LanguageOption>> fetchAvailableLanguages() {
    return _dataSource.fetchAvailableLanguages();
  }
}
