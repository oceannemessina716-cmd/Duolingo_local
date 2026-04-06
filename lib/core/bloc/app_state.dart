part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();
}

final class AppInitial extends AppState {
  @override
  List<Object> get props => [];
}

final class OnboardingUncompleted extends AppState {
  @override
  List<Object> get props => [];
}

final class OnboardingCompleted extends AppState {
  @override
  List<Object> get props => [];
}

