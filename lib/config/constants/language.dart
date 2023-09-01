class Language {
  final String name;
  final String languageCode;

  Language({
    required this.name,
    required this.languageCode,
  });
}

final List<Language> languages = [
  Language(
    name: 'spanish',
    languageCode: 'es',
  ),
  Language(
    name: 'english',
    languageCode: 'en',
  ),
];
