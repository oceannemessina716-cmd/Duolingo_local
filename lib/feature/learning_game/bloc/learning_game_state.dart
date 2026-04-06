part of 'learning_game_bloc.dart';

sealed class LearningGameState extends Equatable {
  const LearningGameState();
}

final class LearningGameInitial extends LearningGameState {
  @override
  List<Object> get props => [];
}

final class LearningGameSuccess extends LearningGameState {
  final Map<String, String> games;
  const LearningGameSuccess(this.games);

  @override
  List<Object> get props => [games];
}

final class LearningGameLoading extends LearningGameState {
  @override
  List<Object> get props => [];
}

final class LearningGameError extends LearningGameState {
  final String message;
  const LearningGameError(this.message);

  @override
  List<Object> get props => [message];
}

final class LearningGameEmpty extends LearningGameState {
  @override
  List<Object> get props => [];
}
