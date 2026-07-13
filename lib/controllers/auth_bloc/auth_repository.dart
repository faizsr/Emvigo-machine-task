import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/user_model.dart';

class AuthRepository {
  AuthRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> registerWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> saveProfile(UserModel userModel) async {
    final user = _firebaseAuth.currentUser;

    if (user == null) {
      throw Exception('No authenticated user found');
    }

    final profileData = userModel.toJson();
    profileData.remove('password');
    profileData['uid'] = user.uid;
    profileData['email'] = user.email ?? '';
    profileData['createdAt'] = FieldValue.serverTimestamp();

    await _firestore.collection('users').doc(user.uid).set(profileData);
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
