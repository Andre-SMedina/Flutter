import 'package:alura/apps/navigation/home_navigation.dart';
import 'package:alura/apps/navigation/page2.dart';
import 'package:alura/apps/navigation/page3.dart';
import 'package:flutter/material.dart';

class MyRoutes extends StatelessWidget {
  const MyRoutes({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rotas',
      //initialRoute dá o nome da rota que está sendo carregada no parâmetro home. Nesse caso, HomeNavigation será a rota '/'
      initialRoute: '/',
      home: const HomeNavigation(),
      routes: {
        //Page2.routeName é apenas um parâmetro static do tipo String da Page2 que possui o nome da rota e evita ficar trocando em todos os lugares que chamam a rota2 caso o nome da rota2 precise ser alterado.
        Page2.routeName: (context) => Page2(),
        Page3.routeName: (context) => Page3()
      },
    );
  }
}
