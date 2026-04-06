import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/repositories/language_repo.dart';
import '../../../core/services/settings_service.dart';

part 'learning_game_event.dart';
part 'learning_game_state.dart';

class LearningGameBloc extends Bloc<LearningGameEvent, LearningGameState> {
  final LanguageRepo languageRepo;
  final SettingsService serviceSettings;

  LearningGameBloc({required this.languageRepo, required this.serviceSettings}) : super(LearningGameInitial()) {
    on<LoadLanguage>(_onLoadLanguage);
  }

  Future<void> _onLoadLanguage(LoadLanguage event, Emitter<LearningGameState> emit) async {
    emit(LearningGameLoading());
    final String? targetLanguage = serviceSettings.targetLanguage;

    if (targetLanguage == null) {
      emit(LearningGameError('No target language selected'));
      return;
    }

    await languageRepo.init(targetLanguage.toLowerCase());
    languageRepo.getAvailableSubjects();

    Map<String, String> games = {"flip-card": "Flip card", "speed-run": "Speed run"};
    emit(LearningGameSuccess(games));
  }
}
