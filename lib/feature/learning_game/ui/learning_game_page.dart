import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../bloc/learning_game_bloc.dart';

class LearningGamePage extends StatelessWidget {
  LearningGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LearningGameBloc, LearningGameState>(
        builder: (context, state) {
          switch (state) {
            case LearningGameInitial():
              return Center(child: CircularProgressIndicator());
            case LearningGameSuccess():
              final games = state.games;
              return SafeArea(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    spacing: 40,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to Learning Game',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),

                          Text(
                            'Select a game to start',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),

                      Expanded(
                        child: GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          itemCount: games.values.length,
                          itemBuilder: (BuildContext context, int index) {
                            final game = games.values.elementAt(index);
                            return Card(
                              color: Colors.primaries[index % Colors.primaries.length].shade50,
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed(games.keys.elementAt(index));
                                },
                                child: Center(
                                  child: Text(game),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case LearningGameLoading():
              return Center(
                child: Column(
                  spacing: 16,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text('Setting up games...'),
                  ],
                ),
              );
            case LearningGameError():
              return Center(child: Text('Something went wrong'));
            case LearningGameEmpty():
              return Center();
          }
        },
      ),
    );
  }
}
