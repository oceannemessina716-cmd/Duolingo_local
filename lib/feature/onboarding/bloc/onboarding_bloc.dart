import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/services/settings_service.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SettingsService settingsService;

  OnboardingBloc(this.settingsService) : super(OnboardingState()) {
    on<NextPage>(_onNextPage);
    on<PreviousPage>(_onPreviousPage);
    on<OnNativeLanguageSelected>(_onNativeLanguageSelected);
    on<OnTargetLanguageSelected>(_onTargetLanguageSelected);
    on<OnCompleteOnboarding>(_onCompleteOnboarding);
  }

  void _onNextPage(NextPage event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentPage: state.currentPage + 1));
  }

  void _onPreviousPage(PreviousPage event, Emitter<OnboardingState> emit) {
    if (state.currentPage > 0) {
      emit(state.copyWith(currentPage: state.currentPage - 1));
    }
  }

  void _onNativeLanguageSelected(OnNativeLanguageSelected event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(nativeLanguage: event.nativeLanguage));
  }

  void _onTargetLanguageSelected(OnTargetLanguageSelected event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(targetLanguage: event.targetLanguage));
  }

  Future<void> _onCompleteOnboarding(OnCompleteOnboarding event, Emitter<OnboardingState> emit) async {
    emit(state.copyWith(status: Status.loading));

    await settingsService.completeOnboarding();
    await settingsService.setTargetLanguage(state.targetLanguage!);

    emit(state.copyWith(status: Status.success, message: "Successfully completed onboarding"));
  }
}
