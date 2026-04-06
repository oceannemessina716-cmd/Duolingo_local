import '../data_source/language_data_source.dart';
import '../models/language_word_model.dart';

class LanguageRepo {
  final LanguageDataSource localSource;

  LanguageRepo(this.localSource);

  List<LanguageWordModel> _words = [];
  List<String> _subjects = [];

  List<LanguageWordModel> get words => _words;
  List<String> get subjects => _subjects;

  Future<void> init(String languageCode) async {
    final result = await localSource.loadLanguageJson(languageCode);
    result.fold(
      (rawData) {
        _words = rawData.map((json) => LanguageWordModel.fromMap(json as Map<String, dynamic>)).toList();
      },
      (err) {
        print(err);
      },
    );
  }

  List<LanguageWordModel> getWordsBySubject(String subject) {
    return _words.where((word) => word.subject == subject).toList()..shuffle();
  }

  List<String> getAvailableSubjects() {
    _subjects = _words.map((word) => word.subject).toSet().toList();
    return _subjects;
  }
}
