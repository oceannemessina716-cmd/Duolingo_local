part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
}

final class Initialisation extends AppEvent {
  @override
  List<Object> get props => [];
}


