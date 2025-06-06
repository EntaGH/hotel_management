import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in anonymously
  Future<User?> signInAnon() async {
    try {
      final result = await _auth.signInAnonymously();
      return result.user;
    } catch (e) {
      _logError('Anonymous Sign In', e);
      return null;
    }
  }

  /// Sign in with email & password
  Future<User?> signInWithEmail(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      _logError('Email Sign In', e);
      return null;
    }
  }

  /// Register with email & password
  Future<User?> registerWithEmail(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      _logError('Email Registration', e);
      return null;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      _logError('Sign Out', e);
    }
  }

  /// Auth state stream
  Stream<User?> get user => _auth.authStateChanges();

  /// Private error logger
  void _logError(String context, Object e) {
    print('$context Error: ${e.toString()}');
  }
}
