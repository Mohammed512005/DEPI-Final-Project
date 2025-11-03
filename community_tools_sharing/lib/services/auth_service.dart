// lib/services/auth_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ---------- Register (Basic) ----------
  Future<(String? uid, String? error)> register({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = userCredential.user?.uid;

      if (uid != null) {
        await _firestore.collection('users').doc(uid).set({
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return (uid, null);
    } on FirebaseAuthException catch (e) {
      return (null, e.message);
    } catch (e) {
      return (null, e.toString());
    }
  }

  Future<void> saveUserProfileData(String uid, Map<String, dynamic> data) async {
  await _firestore.collection('users').doc(uid).update(data);
}

  // ---------- Add/Update Full Profile ----------
  Future<String?> updateUserProfile({
    required String uid,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore.collection('users').doc(uid).set(data, SetOptions(merge: true));
      return 'success';
    } catch (e) {
      return e.toString();
    }
  }

  // ---------- Login ----------
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
  Future<void> signOut() async => await _auth.signOut();

  // ---------- Current User ----------
  User? get currentUser => _auth.currentUser;
}
