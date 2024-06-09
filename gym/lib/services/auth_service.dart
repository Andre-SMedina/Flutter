import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;
  cadUser(
      {required String nome, required String email, required String senha}) {
    _fireBaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: senha,
    );
  }
}
