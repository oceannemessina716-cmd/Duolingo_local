import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

import 'core/bloc/app_bloc.dart';
import 'core/data_source/language_data_source.dart';
import 'core/repositories/language_repo.dart';
import 'core/services/settings_service.dart';
import 'core/services/simple_bloc_observer.dart';
import 'feature/flip_card_game/bloc/flip_card_bloc.dart';
import 'feature/learning_game/bloc/learning_game_bloc.dart';
import 'feature/onboarding/bloc/onboarding_bloc.dart';

// Create a global instance (or use GetIt.instance)
final sl = GetIt.instance;

// Register them at app startup
Future<void> setupLocator() async {
  await _configExternalDependencies();
  _configServices();
  _configLanguage();
  _configApp();
  _configOnboarding();
  _configLearningGame();
  _configFlipCardGame();
  _configSignUp();
  _configLogin();
  _configUser();
}

Future<void> _configExternalDependencies() async {
  Bloc.observer = SimpleBlocObserver();
  sl.registerLazySingleton<Uuid>(() => const Uuid());
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);
}

void _configServices() {
  sl.registerLazySingleton<SettingsService>(() => SettingsService(sl<SharedPreferences>()));
}

void _configLanguage() {
  sl.registerLazySingleton<LanguageDataSource>(() => LanguageDataSource());
  sl.registerLazySingleton<LanguageRepo>(() => LanguageRepo(sl<LanguageDataSource>()));
}

void _configOnboarding(){
  sl.registerFactory<OnboardingBloc>(() => OnboardingBloc(sl<SettingsService>()));
}

void _configApp() {
  sl.registerFactory<AppBloc>(() => AppBloc(settingsService: sl<SettingsService>()));
}

void _configLearningGame() {
  sl.registerFactory<LearningGameBloc>(() => LearningGameBloc(serviceSettings: sl<SettingsService>(), languageRepo: sl<LanguageRepo>()));
}

void _configFlipCardGame() {
  sl.registerFactory<FlipCardBloc>(() => FlipCardBloc(sl<LanguageRepo>()));
}

void _configSignUp() {
  // sl.registerFactory<SignUpBloc>(() => SignUpBloc(sl<AuthRepoImpl>()));
}

void _configLogin() {
  // sl.registerFactory<LoginBloc>(() => LoginBloc(sl<AuthRepoImpl>()));
}

void _configUser() {
  // sl.registerLazySingleton<UserRemoteSource>(() => UserRemoteSource(sl<FirebaseFirestore>()));
  // sl.registerLazySingleton<UserRepoImpl>(() => UserRepoImpl(sl<UserRemoteSource>()));
  // sl.registerFactory<UsersBloc>(() => UsersBloc(sl<UserRepoImpl>(), sl<AuthRepoImpl>()));
}
