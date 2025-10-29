// lib/services/auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------- Sign Up ----------
  Future<String?> register(String email, String password, {String? nationalId}) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get user ID
      final uid = userCredential.user?.uid;

      // Store user data in Firestore
      await _firestore.collection('users').doc(uid).set({
        'email': email,
        'nationalId': nationalId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // ---------- Sign In ----------
  Future<String?> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return 'success';
    } on FirebaseAuthException catch (e) {
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  // ---------- Sign Out ----------
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // ---------- Get Current User ----------
  User? get currentUser => _auth.currentUser;
}
