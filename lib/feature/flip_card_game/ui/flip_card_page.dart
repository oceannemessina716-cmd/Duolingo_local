import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/flip_card_bloc.dart';

class FlipCardPage extends StatelessWidget {
  const FlipCardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: BlocConsumer<FlipCardBloc, FlipCardState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              switch (state) {
                case FlipCardInitial():
                  return Center(child: CircularProgressIndicator());
                case FlipCardSuccess():
                  final subjects = state.subjects;
                  return Column(
                    spacing: 40,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flip card game',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),

                          Text(
                            'On which subject do you want to expand your knowledge?',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),

                      Expanded(
                        child: ListView.builder(
                          itemCount: subjects.length,
                          itemBuilder: (BuildContext context, int index) {
                            final subject = subjects[index];
                            return Card(
                              color: Colors.primaries[index % Colors.primaries.length].shade200,
                              child: InkWell(
                                onTap: () {
                                },
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(subject.toUpperCase()),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                case FlipCardLoading():
                  return Column(
                    spacing: 16,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text('Setting up subjects...'),
                    ],
                  );

                case FlipCardError():
                  return Center(child: Text('Something went wrong'));
              }
            },
          ),
        ),
      ),
    );
  }
}
