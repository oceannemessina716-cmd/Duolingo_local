import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../feature/flip_card_game/bloc/flip_card_bloc.dart';
import '../../feature/flip_card_game/ui/flip_card_page.dart';
import '../../feature/learning_game/ui/learning_game_page.dart';
import '../../feature/onboarding/bloc/onboarding_bloc.dart';
import '../../feature/onboarding/ui/onboarding_page.dart';
import '../../injection.dart';
import '../../tab_navigation.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/onboarding',
  routes: [
    // GoRoute(
    //   path: '/sign-up',
    //   builder: (context, state) => BlocProvider(
    //     create: (_) => sl<SignUpBloc>(),
    //     child: SignUp(),
    //   ),
    // ),
    // GoRoute(
    //   path: '/login',
    //   builder: (context, state) => BlocProvider(
    //     create: (_) => sl<LoginBloc>(),
    //     child: Login(),
    //   ),
    // ),
    GoRoute(
      name: 'onboarding',
      path: '/onboarding',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<OnboardingBloc>(),
        child: const OnboardingPage(),
      ),
    ),
    GoRoute(
      name: 'not-found',
      path: '/unknown',
      builder: (context, state) => Scaffold(body: Center(child: CircularProgressIndicator())),
    ),

    GoRoute(
      name: 'flip-card',
      path: '/flip-card',
      builder: (context, state) => BlocProvider(
        create: (_) => sl<FlipCardBloc>()..add(LoadSubjects()),
        child: const FlipCardPage(),
      ),
    ),

    // Bottom Navigation Shell
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return TabNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: 'games',
              path: '/games',
              builder: (context, state) => LearningGamePage(),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const Placeholder(),
            ),
          ],
        ),
      ],
    ),
  ],
);
