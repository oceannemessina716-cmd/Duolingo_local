import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/language_data.dart';

class LanguageService {
  static String _assetFileName(Language targetLang) {
    switch (targetLang) {
      case Language.bulu:
        return 'bulu_data.json';
      case Language.bassaa:
        return 'bassaa_data.json';
      case Language.bamileke:
        return 'bamileke_data.json';
    }
  }

  /// Charge le JSON selon la langue cible (même schéma que [bulu_data.json]).
  static Future<List<LanguageItem>> loadData(Language targetLang) async {
    final fileName = _assetFileName(targetLang);
    final String response = await rootBundle.loadString('assets/data/$fileName');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => LanguageItem.fromJson(json)).toList();
  }

  /// Génère jusqu’à 10 questions pour une leçon (moins si la catégorie est courte).
  static List<Question> generateQuiz(List<LanguageItem> allItems, String subject) {
    final categoryItems = allItems.where((i) => i.subject == subject).toList()..shuffle();
    if (categoryItems.isEmpty) return [];

    return categoryItems.take(10).map((item) {
      final pool = allItems
          .where((i) => i.bu != item.bu)
          .map((i) => i.bu)
          .toList()
        ..shuffle();

      final wrong = <String>[];
      final seen = <String>{item.bu};
      for (final p in pool) {
        if (wrong.length >= 3) break;
        if (seen.add(p)) wrong.add(p);
      }
      var k = 0;
      while (wrong.length < 3 && pool.isNotEmpty) {
        wrong.add(pool[k % pool.length]);
        k++;
      }

      final options = [item.bu, ...wrong.take(3)]..shuffle();

      return Question(
        id: item.id,
        questionText: "Comment dit-on '${item.fr}' ?",
        correctAnswer: item.bu,
        options: options,
        phoneticHint: item.phonetic,
      );
    }).toList();
  }
}