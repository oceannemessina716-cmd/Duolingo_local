// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'language_word_model.dart';

class LanguageWordModelMapper extends ClassMapperBase<LanguageWordModel> {
  LanguageWordModelMapper._();

  static LanguageWordModelMapper? _instance;
  static LanguageWordModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = LanguageWordModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'LanguageWordModel';

  static String _$id(LanguageWordModel v) => v.id;
  static const Field<LanguageWordModel, String> _f$id = Field('id', _$id);
  static String _$subject(LanguageWordModel v) => v.subject;
  static const Field<LanguageWordModel, String> _f$subject = Field(
    'subject',
    _$subject,
  );
  static String _$fr(LanguageWordModel v) => v.fr;
  static const Field<LanguageWordModel, String> _f$fr = Field('fr', _$fr);
  static String _$en(LanguageWordModel v) => v.en;
  static const Field<LanguageWordModel, String> _f$en = Field('en', _$en);
  static String _$bu(LanguageWordModel v) => v.bu;
  static const Field<LanguageWordModel, String> _f$bu = Field('bu', _$bu);
  static String _$phonetic(LanguageWordModel v) => v.phonetic;
  static const Field<LanguageWordModel, String> _f$phonetic = Field(
    'phonetic',
    _$phonetic,
  );
  static String? _$partOfSpeech(LanguageWordModel v) => v.partOfSpeech;
  static const Field<LanguageWordModel, String> _f$partOfSpeech = Field(
    'partOfSpeech',
    _$partOfSpeech,
    opt: true,
  );

  @override
  final MappableFields<LanguageWordModel> fields = const {
    #id: _f$id,
    #subject: _f$subject,
    #fr: _f$fr,
    #en: _f$en,
    #bu: _f$bu,
    #phonetic: _f$phonetic,
    #partOfSpeech: _f$partOfSpeech,
  };

  static LanguageWordModel _instantiate(DecodingData data) {
    return LanguageWordModel(
      id: data.dec(_f$id),
      subject: data.dec(_f$subject),
      fr: data.dec(_f$fr),
      en: data.dec(_f$en),
      bu: data.dec(_f$bu),
      phonetic: data.dec(_f$phonetic),
      partOfSpeech: data.dec(_f$partOfSpeech),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static LanguageWordModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<LanguageWordModel>(map);
  }

  static LanguageWordModel fromJson(String json) {
    return ensureInitialized().decodeJson<LanguageWordModel>(json);
  }
}

mixin LanguageWordModelMappable {
  String toJson() {
    return LanguageWordModelMapper.ensureInitialized()
        .encodeJson<LanguageWordModel>(this as LanguageWordModel);
  }

  Map<String, dynamic> toMap() {
    return LanguageWordModelMapper.ensureInitialized()
        .encodeMap<LanguageWordModel>(this as LanguageWordModel);
  }

  LanguageWordModelCopyWith<
    LanguageWordModel,
    LanguageWordModel,
    LanguageWordModel
  >
  get copyWith =>
      _LanguageWordModelCopyWithImpl<LanguageWordModel, LanguageWordModel>(
        this as LanguageWordModel,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return LanguageWordModelMapper.ensureInitialized().stringifyValue(
      this as LanguageWordModel,
    );
  }

  @override
  bool operator ==(Object other) {
    return LanguageWordModelMapper.ensureInitialized().equalsValue(
      this as LanguageWordModel,
      other,
    );
  }

  @override
  int get hashCode {
    return LanguageWordModelMapper.ensureInitialized().hashValue(
      this as LanguageWordModel,
    );
  }
}

extension LanguageWordModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, LanguageWordModel, $Out> {
  LanguageWordModelCopyWith<$R, LanguageWordModel, $Out>
  get $asLanguageWordModel => $base.as(
    (v, t, t2) => _LanguageWordModelCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class LanguageWordModelCopyWith<
  $R,
  $In extends LanguageWordModel,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? subject,
    String? fr,
    String? en,
    String? bu,
    String? phonetic,
    String? partOfSpeech,
  });
  LanguageWordModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _LanguageWordModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, LanguageWordModel, $Out>
    implements LanguageWordModelCopyWith<$R, LanguageWordModel, $Out> {
  _LanguageWordModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<LanguageWordModel> $mapper =
      LanguageWordModelMapper.ensureInitialized();
  @override
  $R call({
    String? id,
    String? subject,
    String? fr,
    String? en,
    String? bu,
    String? phonetic,
    Object? partOfSpeech = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != null) #id: id,
      if (subject != null) #subject: subject,
      if (fr != null) #fr: fr,
      if (en != null) #en: en,
      if (bu != null) #bu: bu,
      if (phonetic != null) #phonetic: phonetic,
      if (partOfSpeech != $none) #partOfSpeech: partOfSpeech,
    }),
  );
  @override
  LanguageWordModel $make(CopyWithData data) => LanguageWordModel(
    id: data.get(#id, or: $value.id),
    subject: data.get(#subject, or: $value.subject),
    fr: data.get(#fr, or: $value.fr),
    en: data.get(#en, or: $value.en),
    bu: data.get(#bu, or: $value.bu),
    phonetic: data.get(#phonetic, or: $value.phonetic),
    partOfSpeech: data.get(#partOfSpeech, or: $value.partOfSpeech),
  );

  @override
  LanguageWordModelCopyWith<$R2, LanguageWordModel, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _LanguageWordModelCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

