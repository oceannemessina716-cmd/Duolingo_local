import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/widgets/primary_button.dart';
import '../bloc/onboarding_bloc.dart';

class TargetLanguagePage extends StatefulWidget {
  const TargetLanguagePage({super.key});

  @override
  State<TargetLanguagePage> createState() => _TargetLanguagePageState();
}

class _TargetLanguagePageState extends State<TargetLanguagePage> {
  List<String> nativeLanguages = ["Bulu"];


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  spacing: 40,
                  children: [
                    Text(
                      'What would you want to learn?',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Column(
                      spacing: 8,
                      children: [
                        ...nativeLanguages.map(
                          (language) => Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            color: state.targetLanguage == language ? Theme.of(context).colorScheme.primaryContainer : null,
                            child: ListTile(
                              selected: state.targetLanguage == language,
                              onTap: () {
                                context.read<OnboardingBloc>().add(OnTargetLanguageSelected(language));
                              },
                              title: Text(
                                language,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              PrimaryButton(
                onPressed: () {
                  context.read<OnboardingBloc>().add(NextPage());
                },
                content: 'Continue',
              ),
            ],
          ),
        );
      },
    );
  }
}
