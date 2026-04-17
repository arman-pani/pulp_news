class LanguageOption {
  const LanguageOption({
    required this.code,
    required this.displayName,
    required this.nativeName,
    this.sortOrder = 0,
  });

  final String code;
  final String displayName;
  final String nativeName;
  final int sortOrder;
}
