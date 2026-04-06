import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/models/language_word_model.dart';
import '../../../core/repositories/language_repo.dart';

part 'flip_card_event.dart';
part 'flip_card_state.dart';

class FlipCardBloc extends Bloc<FlipCardEvent, FlipCardState> {
  final LanguageRepo languageRepo;

  FlipCardBloc(this.languageRepo) : super(FlipCardInitial()) {
    on<LoadSubjects>(_onLoadSubjects);
  }

  Future<void> _onLoadSubjects(LoadSubjects event, Emitter<FlipCardState> emit) async {
    emit(FlipCardLoading());
    final List<String> subjects = languageRepo.subjects;
    emit(FlipCardSuccess(subjects: subjects));
  }
}
