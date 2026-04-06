import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/primary_button.dart';
import '../../../core/widgets/secondary_button.dart';
import '../bloc/onboarding_bloc.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
      child: Column(
        spacing: 16,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Take a test to learn a new language!',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          BlocBuilder<OnboardingBloc, OnboardingState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return Center(child: CircularProgressIndicator());
              }
              return Column(
                spacing: 8,
                children: [
                  PrimaryButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(OnCompleteOnboarding());
                    },
                    content: 'Continue',
                  ),
                  SecondaryButton(
                    onPressed: () {
                      context.read<OnboardingBloc>().add(PreviousPage());
                    },
                    content: 'Cancel',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
