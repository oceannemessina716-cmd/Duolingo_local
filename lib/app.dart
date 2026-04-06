import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/bloc/app_bloc.dart';
import 'core/config/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Klearn',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
      ),
      routerConfig: router,
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            switch (state) {
              case AppInitial():
                router.goNamed('not-found');
                break;
              case OnboardingUncompleted():
                router.goNamed('onboarding');
                break;
              case OnboardingCompleted():
                router.goNamed('games');
                break;
            }
          },
          child: child,
        );
      },
    );
  }
}
