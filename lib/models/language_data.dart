enum Language { bulu, bassaa, bamileke }

enum Subject {
  alphabet,
  expression,
  number,
  famille,
  conjugation,
  pronoun,
  article,
  phrase,
  animaux,
}

class LanguageItem {
  final String id;
  final String subject;
  final String fr;
  final String en;
  final String bu;
  final String phonetic;
  final String partOfSpeech;

  LanguageItem({
    required this.id,
    required this.subject,
    required this.fr,
    required this.en,
    required this.bu,
    required this.phonetic,
    required this.partOfSpeech,
  });

  factory LanguageItem.fromJson(Map<String, dynamic> json) {
    return LanguageItem(
      id: json['id'] ?? '',
      subject: json['subject'] ?? '',
      fr: json['fr'] ?? '',
      en: json['en'] ?? '',
      bu: json['bu'] ?? '',
      phonetic: json['phonetic'] ?? '',
      partOfSpeech: json['part_of_speech'] ?? '',
    );
  }
}

class Question {
  final String id;
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  final String? phoneticHint;

  Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.phoneticHint,
  });
}

class UserProgress {
  String userId;
  Language sourceLanguage;
  Language targetLanguage;
  Map<Subject, int> completedLevels;
  int totalXP;
  int hearts;
  DateTime lastLessonDate;
  int streak;

  UserProgress({
    required this.userId,
    required this.sourceLanguage,
    required this.targetLanguage,
    required this.completedLevels,
    required this.totalXP,
    required this.hearts,
    required this.lastLessonDate,
    required this.streak,
  });

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'sourceLanguage': sourceLanguage.name,
        'targetLanguage': targetLanguage.name,
        'completedLevels': completedLevels.map((k, v) => MapEntry(k.name, v)),
        'totalXP': totalXP,
        'hearts': hearts,
        'lastLessonDate': lastLessonDate.toIso8601String(),
        'streak': streak,
      };

  factory UserProgress.fromJson(Map<String, dynamic> json) {
    final rawLevels = json['completedLevels'];
    final completedLevels = <Subject, int>{};
    if (rawLevels is Map) {
      for (final s in Subject.values) {
        final v = rawLevels[s.name];
        completedLevels[s] = v is num ? v.toInt() : int.tryParse('$v') ?? 0;
      }
    } else {
      for (final s in Subject.values) {
        completedLevels[s] = 0;
      }
    }

    return UserProgress(
      userId: json['userId'] as String? ?? '',
      sourceLanguage: _parseLanguage(json['sourceLanguage']),
      targetLanguage: _parseLanguage(json['targetLanguage']),
      completedLevels: completedLevels,
      totalXP: (json['totalXP'] as num?)?.toInt() ?? 0,
      hearts: (json['hearts'] as num?)?.toInt() ?? 5,
      lastLessonDate: DateTime.tryParse(
            json['lastLessonDate'] as String? ?? '',
          ) ??
          DateTime.now(),
      streak: (json['streak'] as num?)?.toInt() ?? 0,
    );
  }

  static Language _parseLanguage(dynamic value) {
    if (value is String) {
      try {
        return Language.values.byName(value);
      } catch (_) {
        return Language.bulu;
      }
    }
    return Language.bulu;
  }
}
