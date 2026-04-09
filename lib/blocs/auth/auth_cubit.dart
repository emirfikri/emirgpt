import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../models/export_models.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthCubit(this._firebaseAuth) : super(const AuthInitial());

  Future<void> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      emit(const AuthRegistering());

      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await userCredential.user?.updateDisplayName(displayName);
      await userCredential.user?.reload();

      final user = User(
        uid: userCredential.user!.uid,
        userId: userCredential.user!.uid,
        email: userCredential.user!.email!,
        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
        createdAt: userCredential.user!.metadata.creationTime ?? DateTime.now(),
        emailVerified: userCredential.user!.emailVerified,
      );

      emit(AuthRegistered(user));
    } on firebase_auth.FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Registration failed', code: e.code));
    } catch (e) {
      emit(AuthError('Registration failed: ${e.toString()}'));
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      emit(const AuthLoggingIn());

      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = User(
        uid: userCredential.user!.uid,
        userId: userCredential.user!.uid,
        email: userCredential.user!.email!,
        displayName: userCredential.user!.displayName,
        photoUrl: userCredential.user!.photoURL,
        createdAt: userCredential.user!.metadata.creationTime ?? DateTime.now(),
        lastLoginAt: DateTime.now(),
        emailVerified: userCredential.user!.emailVerified,
      );

      emit(AuthLoggedIn(user));
    } on firebase_auth.FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Login failed', code: e.code));
    } catch (e) {
      emit(AuthError('Login failed: ${e.toString()}'));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      emit(const AuthForgotPasswordSending());

      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());

      emit(AuthForgotPasswordSent(email));
    } on firebase_auth.FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Failed to send reset email', code: e.code));
    } catch (e) {
      emit(AuthError('Failed to send reset email: ${e.toString()}'));
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      emit(const AuthLoggedOut());
    } on firebase_auth.FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Logout failed', code: e.code));
    } catch (e) {
      emit(AuthError('Logout failed: ${e.toString()}'));
    }
  }

  Future<void> checkAuthStatus() async {
    final currentUser = _firebaseAuth.currentUser;
    if (currentUser != null) {
      final user = User(
        uid: currentUser.uid,
        userId: currentUser.uid,
        email: currentUser.email!,
        displayName: currentUser.displayName,
        photoUrl: currentUser.photoURL,
        createdAt: currentUser.metadata.creationTime ?? DateTime.now(),
        emailVerified: currentUser.emailVerified,
      );
      emit(AuthLoggedIn(user));
    } else {
      emit(const AuthLoggedOut());
    }
  }
}
