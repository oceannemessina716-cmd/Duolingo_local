part of 'flip_card_bloc.dart';

sealed class FlipCardState extends Equatable {
  const FlipCardState();
}

final class FlipCardInitial extends FlipCardState {
  @override
  List<Object> get props => [];
}

final class FlipCardSuccess extends FlipCardState {
  final List<String> subjects;
  final List<LanguageWordModel> words;

  const FlipCardSuccess({required this.subjects, this.words = const []});

  @override
  List<Object> get props => [subjects, words];
}

final class FlipCardLoading extends FlipCardState {
  @override
  List<Object> get props => [];
}

final class FlipCardError extends FlipCardState {
  final String message;

  const FlipCardError(this.message);

  @override
  List<Object> get props => [message];
}
