import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _fireBaseAuth = FirebaseAuth.instance;

  Future<String?> cadUser({
    required String nome,
    required String email,
    required String senha,
  }) async {
    try {
      UserCredential userCredecial =
          await _fireBaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );
      await userCredecial.user!.updateDisplayName(nome);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "Usuário já cadastrado.";
      }
    }

    return 'Erro desconhecido!';
  }

  Future<String?> loginUser(
      {required String email, required String password}) async {
    try {
      await _fireBaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return 'Credenciais inválidas';
      }
      if (e.code == 'invalid-email') {
        return 'E-mail inválido';
      }
      return e.code;
    }
  }

  Future<void> logout() async {
    return await _fireBaseAuth.signOut();
  }
}
