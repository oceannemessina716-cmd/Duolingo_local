import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/language_data.dart';

class LanguageService {
  // Charge le JSON selon la langue choisie
  static Future<List<LanguageItem>> loadData(Language targetLang) async {
    String fileName = targetLang == Language.bulu ? 'bulu_data.json' : 'bassaa_data.json';
    final String response = await rootBundle.loadString('assets/data/$fileName');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => LanguageItem.fromJson(json)).toList();
  }

  // Génère 10 questions pour une leçon
  static List<Question> generateQuiz(List<LanguageItem> allItems, String subject) {
    List<LanguageItem> categoryItems = allItems.where((i) => i.subject == subject).toList();
    categoryItems.shuffle();
    
    return categoryItems.take(10).map((item) {
      // On crée les mauvaises réponses (leurres)
      List<String> distractors = allItems
          .where((i) => i.bu != item.bu)
          .map((i) => i.bu)
          .toList();
      distractors.shuffle();

      List<String> options = [item.bu, distractors[0], distractors[1], distractors[2]];
      options.shuffle();

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