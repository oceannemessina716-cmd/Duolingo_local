part of 'onboarding_bloc.dart';

sealed class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object?> get props => [];
}

final class NextPage extends OnboardingEvent {}

final class PreviousPage extends OnboardingEvent {}

final class OnNativeLanguageSelected extends OnboardingEvent {
  final String nativeLanguage;

  const OnNativeLanguageSelected(this.nativeLanguage);

  @override
  List<Object?> get props => [nativeLanguage];
}

final class OnTargetLanguageSelected extends OnboardingEvent {
  final String targetLanguage;

  const OnTargetLanguageSelected(this.targetLanguage);

  @override
  List<Object?> get props => [targetLanguage];
}

final class OnCompleteOnboarding extends OnboardingEvent {}
