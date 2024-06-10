import 'package:firebase_auth/firebase_auth.dart';
import 'package:gym/pages/auth_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:gym/pages/home_page.dart';
import 'firebase_options.dart';

void main() async {
  //linha para poder funcionar o firebase no android
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Gym App',
      home: RouterPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    //Stream fica verificando se houve aluma alteração no usuário
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage(
            user: snapshot.data!,
          );
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
