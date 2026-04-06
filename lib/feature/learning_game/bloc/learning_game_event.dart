part of 'learning_game_bloc.dart';

sealed class LearningGameEvent extends Equatable {
  const LearningGameEvent();
}

final class LoadLanguage extends LearningGameEvent {
  @override
  List<Object> get props => [];
}