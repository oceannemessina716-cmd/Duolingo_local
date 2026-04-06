// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:duolingo/core/data_source/language_data_source.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('LanguageLocalDataSource Tests', () {
    late LanguageDataSource dataSource;

    setUp(() {
      dataSource = LanguageDataSource();
    });

    test('should load and decode bulu_data.json correctly', () async {
      // 1. Act
      // Ensure the file is in assets/data/bulu_data.json
      final result = await dataSource.loadLanguageJson('bulu');

      // 2. Assert
      expect(result.isSuccess(), true);
      result.fold(
        (data) {
          expect(data, isA<List<dynamic>>());
          expect(data.first['id'], 'alp-01');
        },
        (error) => fail('Should not have failed: $error'),
      );
    });

    test('should throw an exception if file is missing', () async {
      // Act
      final result = await dataSource.loadLanguageJson('non_existent');

      // Assert
      expect(result.isError(), true);
    });
  });
}
