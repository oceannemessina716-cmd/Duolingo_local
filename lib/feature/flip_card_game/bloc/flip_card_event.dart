part of 'flip_card_bloc.dart';

sealed class FlipCardEvent extends Equatable {
  const FlipCardEvent();
  @override
  List<Object> get props => [];
}


class LoadSubjects extends FlipCardEvent {}

class NextCard extends FlipCardEvent {}
class FlipCurrentCard extends FlipCardEvent {}