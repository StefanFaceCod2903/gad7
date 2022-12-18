import 'package:firebase_auth/firebase_auth.dart';
import 'package:gad7/src/models/index.dart';

class AuthApi {
  const AuthApi({required this.auth});

  final FirebaseAuth auth;

  Future<AppUser> createUser({required String email, required String password}) async {
    final UserCredential credential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    final User user = credential.user!;
    await user.updateDisplayName(email.split('@').first);
    return AppUser(
      uid: user.uid,
      email: email,
      displayName: user.displayName!,
    );
  }

  Future<AppUser> login({required String email, required String password}) async {
    final UserCredential credential = await auth.signInWithEmailAndPassword(email: email, password: password);

    final User user = credential.user!;
    return AppUser(
      uid: user.uid,
      email: email,
      displayName: user.displayName!,
    );
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
