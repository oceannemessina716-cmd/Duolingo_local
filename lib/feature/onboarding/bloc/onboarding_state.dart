part of 'onboarding_bloc.dart';

enum Status { initial, loading, error, success }

final class OnboardingState extends Equatable {
  final String? nativeLanguage, targetLanguage, message;
  final Status status;
  final int currentPage;

  const OnboardingState({
    this.nativeLanguage = '',
    this.targetLanguage = "Bulu",
    this.message = '',
    this.status = Status.initial,
    this.currentPage = 0,
  });

  OnboardingState copyWith({
    String? nativeLanguage,
    String? targetLanguage,
    Status? status,
    String? message,
    int? currentPage,
  }) => OnboardingState(
    nativeLanguage: nativeLanguage ?? this.nativeLanguage,
    targetLanguage: targetLanguage ?? this.targetLanguage,
    status: status ?? this.status,
    message: message ?? this.message,
    currentPage: currentPage ?? this.currentPage,
  );

  @override
  List<Object?> get props => [nativeLanguage, targetLanguage, status, message, currentPage];
}
