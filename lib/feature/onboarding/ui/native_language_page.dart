import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/onboarding_bloc.dart';

class NativeLanguagePage extends StatefulWidget {
  NativeLanguagePage({super.key});

  @override
  State<NativeLanguagePage> createState() => _NativeLanguagePageState();
}

class _NativeLanguagePageState extends State<NativeLanguagePage> {
  List<String> nativeLanguages = ['English', 'French'];

  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...nativeLanguages.map(
          (language) => RadioGroup(
            groupValue: selectedLanguage,
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                selectedLanguage = value;
              });
            },
            child: RadioListTile.adaptive(
              value: language,
              title: Text(language),
            ),
          ),
        ),

        FilledButton(
          onPressed: () {
            context.read<OnboardingBloc>().add(NextPage());
          },
          child: Text('Continue'),
        ),
      ],
    );
  }
}
