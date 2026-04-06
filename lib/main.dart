import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/bloc/app_bloc.dart';
import 'feature/learning_game/bloc/learning_game_bloc.dart';
import 'injection.dart' as di;
import 'injection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (_) => sl<AppBloc>()..add(Initialisation()),
        ),
        BlocProvider(
          create: (_) => sl<LearningGameBloc>()..add(LoadLanguage()),
        ),
      ],
      child: App(),
    );
  }
}
