import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/language_data.dart';

Map<Subject, int> _initialCompletedLevels() => {
      for (final s in Subject.values) s: 0,
    };

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static User? get currentUser => _auth.currentUser;

  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  static Future<UserCredential> signInWithEmail(
    String email,
    String password,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<UserCredential> signUpWithEmail(
    String email,
    String password,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static Future<void> resetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  static Future<void> saveUserProgress(UserProgress progress) async {
    try {
      await _firestore
          .collection('user_progress')
          .doc(progress.userId)
          .set(progress.toJson());
    } catch (e) {
      debugPrint('Error saving user progress: $e');
      rethrow;
    }
  }

  static Future<UserProgress?> getUserProgress(String userId) async {
    try {
      final doc = await _firestore
          .collection('user_progress')
          .doc(userId)
          .get();

      if (doc.exists) {
        final data = Map<String, dynamic>.from(doc.data()!);
        final raw = data['lastLessonDate'];
        if (raw is Timestamp) {
          data['lastLessonDate'] = raw.toDate().toIso8601String();
        }
        if (data['userId'] == null || (data['userId'] as String).isEmpty) {
          data['userId'] = userId;
        }
        return UserProgress.fromJson(data);
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user progress: $e');
      return null;
    }
  }

  static Future<UserProgress> createInitialUserProgress(String userId) async {
    return UserProgress(
      userId: userId,
      sourceLanguage: Language.bulu,
      targetLanguage: Language.bulu,
      completedLevels: _initialCompletedLevels(),
      totalXP: 0,
      hearts: 5,
      lastLessonDate: DateTime.now(),
      streak: 0,
    );
  }

  /// Met l’XP totale à une valeur absolue (synchronisée avec le provider local).
  static Future<void> updateXP(String userId, int totalXP) async {
    try {
      await _firestore.collection('user_progress').doc(userId).update({
        'totalXP': totalXP,
      });
    } catch (e) {
      debugPrint('Error updating user XP: $e');
      rethrow;
    }
  }

  static Future<void> updateUserXP(String userId, int xpToAdd) async {
    try {
      await _firestore.collection('user_progress').doc(userId).update({
        'totalXP': FieldValue.increment(xpToAdd),
      });
    } catch (e) {
      debugPrint('Error updating user XP: $e');
      rethrow;
    }
  }

  static Future<void> updateUserHearts(String userId, int hearts) async {
    try {
      await _firestore.collection('user_progress').doc(userId).update({
        'hearts': hearts,
      });
    } catch (e) {
      debugPrint('Error updating user hearts: $e');
      rethrow;
    }
  }

  static Future<void> updateSubjectLevel(
    String userId,
    Subject subject,
    int level,
  ) async {
    try {
      await _firestore.collection('user_progress').doc(userId).update({
        'completedLevels.${subject.name}': level,
      });
    } catch (e) {
      debugPrint('Error updating subject level: $e');
      rethrow;
    }
  }

  static Future<void> updateStreak(String userId, int streak) async {
    try {
      await _firestore.collection('user_progress').doc(userId).update({
        'streak': streak,
        'lastLessonDate': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      debugPrint('Error updating streak: $e');
      rethrow;
    }
  }

  static Future<List<Map<String, dynamic>>> getLeaderboard() async {
    try {
      final snapshot = await _firestore
          .collection('user_progress')
          .orderBy('totalXP', descending: true)
          .limit(10)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return {
          'userId': doc.id,
          'totalXP': data['totalXP'] ?? 0,
          'streak': data['streak'] ?? 0,
          'targetLanguage': data['targetLanguage'] ?? 'bulu',
        };
      }).toList();
    } catch (e) {
      debugPrint('Error getting leaderboard: $e');
      return [];
    }
  }

  static Future<void> saveUserProfile({
    required String userId,
    required String displayName,
    required Language sourceLanguage,
    required Language targetLanguage,
  }) async {
    try {
      await _firestore.collection('users').doc(userId).set({
        'displayName': displayName,
        'sourceLanguage': sourceLanguage.name,
        'targetLanguage': targetLanguage.name,
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('Error saving user profile: $e');
      rethrow;
    }
  }

  static Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();

      return doc.exists ? doc.data() : null;
    } catch (e) {
      debugPrint('Error getting user profile: $e');
      return null;
    }
  }
}
