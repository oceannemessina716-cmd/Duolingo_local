import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/language_data.dart';
import '../services/language_service.dart';
import '../providers/user_provider.dart';

class LessonScreen extends StatefulWidget {
  final String subject;
  final Language targetLang;

  const LessonScreen({super.key, required this.subject, required this.targetLang});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  List<Question> _questions = [];
  int _currentIndex = 0;
  int _hearts = 5;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initLesson();
  }

  void _initLesson() async {
    final allItems = await LanguageService.loadData(widget.targetLang);
    setState(() {
      _questions = LanguageService.generateQuiz(allItems, widget.subject);
      _isLoading = false;
    });
  }

  void _checkAnswer(String selected) {
    bool isCorrect = selected == _questions[_currentIndex].correctAnswer;

    if (isCorrect) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Bien joué ! 🎉"), backgroundColor: Colors.green, duration: Duration(seconds: 1)));
    } else {
      setState(() => _hearts--);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Oups ! C'était ${_questions[_currentIndex].correctAnswer}"), backgroundColor: Colors.red, duration: Duration(seconds: 1)));
    }

    if (_hearts <= 0) {
      _showGameOver();
    } else if (_currentIndex < _questions.length - 1) {
      setState(() => _currentIndex++);
    } else {
      _finishLesson();
    }
  }

  void _finishLesson() {
    // On donne 15 XP via le Provider
    Provider.of<UserProvider>(context, listen: false).addXP(15);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Leçon terminée !"),
        content: const Text("Félicitations, vous gagnez 15 XP."),
        actions: [TextButton(onPressed: () => Navigator.popUntil(context, (r) => r.isFirst), child: const Text("Super !"))],
      ),
    );
  }

  void _showGameOver() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Plus de vies !"),
        content: const Text("Réessayez plus tard ou révisez les bases."),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return const Scaffold(body: Center(child: CircularProgressIndicator()));

    final q = _questions[_currentIndex];
    return Scaffold(
      appBar: AppBar(title: Text("Leçon : ${widget.subject}"), actions: [Center(child: Text("❤️ $_hearts  "))]),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(value: (_currentIndex + 1) / _questions.length),
            const SizedBox(height: 40),
            Text(q.questionText, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text("Phonétique : ${q.phoneticHint}", style: const TextStyle(fontStyle: FontStyle.italic, color: Colors.grey)),
            const SizedBox(height: 30),
            ...q.options.map((opt) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
                onPressed: () => _checkAnswer(opt),
                child: Text(opt, style: const TextStyle(fontSize: 18)),
              ),
            )),
          ],
        ),
      ),
    );
  }
}