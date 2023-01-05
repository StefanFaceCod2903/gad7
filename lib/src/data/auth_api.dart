import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gad7/src/models/index.dart';

class AuthApi {
  AuthApi(this.auth, this.firestore);

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  Future<AppUser?> getUser() async {
    final User? user = auth.currentUser;
    if (user == null) {
      return null;
    }
    await _makeSureUserExists(user);
    return convertUser(user);
  }

  Future<AppUser> createUser({required String email, required String password}) async {
    final UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = credential.user!;
    await user.updateDisplayName(email.split('@').first);
    await _makeSureUserExists(user);
    return convertUser(user);
  }

  Future<AppUser> login({required String email, required String password}) async {
    final UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);

    final User user = credential.user!;
    return convertUser(user);
  }

  Stream<List<AppUser>> getUsers() {
    return firestore.collection('users').snapshots().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => AppUser.fromJson(doc.data()))
          .toList();
    });
  }

  AppUser convertUser(User user) {
    return AppUser(
      uid: user.uid,
      email: user.email!,
      displayName: user.displayName!,
    );
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<void> _makeSureUserExists(User user) async {
    final DocumentSnapshot<Map<String, dynamic>> doc = await firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      return;
    }

    final AppUser appUser = convertUser(user);
    await firestore.collection('users').doc(user.uid).set(appUser.toJson());
  }
}
