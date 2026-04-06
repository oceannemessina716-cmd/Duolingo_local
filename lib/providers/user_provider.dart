import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/language_data.dart';
import '../services/firebase_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  UserProgress? _userProgress;
  Map<String, dynamic>? _userProfile;
  bool _isLoading = false;

  // Getters pour accéder aux données depuis les écrans
  User? get user => _user;
  UserProgress? get userProgress => _userProgress;
  Map<String, dynamic>? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;

  UserProvider() {
    // Écoute les changements d'état de connexion (Login/Logout)
    _authStateListener();
  }

  void _authStateListener() {
    FirebaseService.authStateChanges.listen((User? user) {
      _user = user;
      if (user != null) {
        _loadUserData();
      } else {
        _userProgress = null;
        _userProfile = null;
        notifyListeners();
      }
    });
  }

  // --- CHARGEMENT DES DONNÉES ---

  Future<void> _loadUserData() async {
    if (_user == null) return;
    _setLoading(true);
    try {
      // On charge le profil et la progression en parallèle pour aller plus vite
      await Future.wait([_loadUserProgress(), _loadUserProfile()]);
    } catch (e) {
      debugPrint('Erreur lors du chargement des données utilisateur: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadUserProgress() async {
    _userProgress = await FirebaseService.getUserProgress(_user!.uid);
    // Si l'utilisateur est nouveau, on lui crée un profil de progression par défaut
    if (_userProgress == null) {
      _userProgress = UserProgress(
        userId: _user!.uid,
        sourceLanguage: Language.bulu, // Par défaut
        targetLanguage: Language.bulu,
        completedLevels: {
          for (final s in Subject.values) s: 0,
        },
        totalXP: 0,
        hearts: 5,
        lastLessonDate: DateTime.now(),
        streak: 0,
      );
      await FirebaseService.saveUserProgress(_userProgress!);
    }
    notifyListeners();
  }

  Future<void> _loadUserProfile() async {
    _userProfile = await FirebaseService.getUserProfile(_user!.uid);
    notifyListeners();
  }

  // --- AUTHENTIFICATION ---

  Future<void> signIn(String email, String password) async {
    _setLoading(true);
    try {
      await FirebaseService.signInWithEmail(email, password);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signUp(String email, String password, String displayName) async {
    _setLoading(true);
    try {
      UserCredential credential = await FirebaseService.signUpWithEmail(email, password);
      if (credential.user != null) {
        // Sauvegarde le nom dans Firestore
        await FirebaseService.saveUserProfile(
          userId: credential.user!.uid,
          displayName: displayName,
          sourceLanguage: Language.bulu, // Par défaut
          targetLanguage: Language.bulu,
        );
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() async {
    await FirebaseService.signOut();
  }

  Future<void> resetPassword(String email) async {
    await FirebaseService.resetPassword(email);
  }

  // --- LOGIQUE DE JEU (XP, Cœurs, Streak) ---

  /// Ajoute de l'XP après une leçon réussie
  Future<void> addXP(int amount) async {
    if (_userProgress == null) return;

    final newXP = _userProgress!.totalXP + amount;
    _userProgress!.totalXP = newXP;
    
    notifyListeners();
    
    try {
      await FirebaseService.updateXP(_user!.uid, newXP);
      await _updateStreak(); // On vérifie aussi la série de jours
    } catch (e) {
      debugPrint('Erreur lors de la mise à jour de l\'XP: $e');
    }
  }

  /// Gère la série de jours consécutifs (Streak)
  Future<void> _updateStreak() async {
    if (_userProgress == null) return;

    final now = DateTime.now();
    final lastLesson = _userProgress!.lastLessonDate;
    final difference = now.difference(lastLesson).inDays;

    int newStreak = _userProgress!.streak;

    if (difference == 1) {
      // Jour consécutif : +1 à la flamme
      newStreak++;
    } else if (difference > 1) {
      // Plus d'un jour d'absence : on repart à zéro
      newStreak = 1; 
    }

    _userProgress!.streak = newStreak;
    _userProgress!.lastLessonDate = now;
    
    await FirebaseService.saveUserProgress(_userProgress!);
    notifyListeners();
  }

  /// Met à jour les préférences de langue (ex: passage du Bulu au Bassaa)
  Future<void> updateLanguagePreferences({
    required Language sourceLanguage,
    required Language targetLanguage,
  }) async {
    if (_user == null) return;

    try {
      await FirebaseService.saveUserProfile(
        userId: _user!.uid,
        displayName: _userProfile?['displayName'] ?? 'Utilisateur',
        sourceLanguage: sourceLanguage,
        targetLanguage: targetLanguage,
      );

      if (_userProgress != null) {
        _userProgress!.sourceLanguage = sourceLanguage;
        _userProgress!.targetLanguage = targetLanguage;
        await FirebaseService.saveUserProgress(_userProgress!);
      }

      notifyListeners();
    } catch (e) {
      debugPrint('Erreur lors du changement de langue: $e');
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
}