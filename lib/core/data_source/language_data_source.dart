import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:result_dart/result_dart.dart';

class LanguageDataSource {
  Future<Result<List<dynamic>>> loadLanguageJson(String languageCode) async {
    try {
      final String response = await rootBundle.loadString('assets/data/${languageCode}_data.json');
      return Success(json.decode(response));
    } catch (err, stk) {
      print(stk);
      return Failure(Exception("Could not load language file: $err"));
    }
  }
}
