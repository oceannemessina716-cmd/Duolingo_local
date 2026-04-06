import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../services/settings_service.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final SettingsService settingsService;
  AppBloc({required this.settingsService}) : super(AppInitial()) {
    on<Initialisation>(_onInitialisation);
  }

  Future<void> _onInitialisation(Initialisation event, Emitter<AppState> emit) async {
    if(settingsService.isOnboardingComplete){
      return emit(OnboardingCompleted());
    }
    return emit(OnboardingUncompleted());
  }
}
