
import 'package:dart_mappable/dart_mappable.dart';

part 'language_word_model.mapper.dart';

@MappableClass()
class LanguageWordModel with LanguageWordModelMappable{
  final String id;
  final String subject;
  final String fr;
  final String en;
  final String bu;
  final String phonetic;
  final String? partOfSpeech;

  LanguageWordModel({
    required this.id,
    required this.subject,
    required this.fr,
    required this.en,
    required this.bu,
    required this.phonetic,
    this.partOfSpeech,
  });

  static final fromMap = LanguageWordModelMapper.fromMap;
  static final fromJson = LanguageWordModelMapper.fromJson;

}