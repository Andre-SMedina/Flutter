import 'package:alura/apps/navigation/favorites_navigation.dart';
import 'package:alura/apps/navigation/home_navigation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeNavigation());
      case 'favorites':
        return MaterialPageRoute(builder: (_) => const FavoritesNavigation());
      default:
        _erroRoute();
    }
  }

  static Route<dynamic> _erroRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Center(
        child: Text('ERRO, rota não encontrada'),
      );
    });
  }
}
