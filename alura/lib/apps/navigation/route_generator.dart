import 'package:alura/apps/navigation/favorites_navigation.dart';
import 'package:alura/apps/navigation/home_navigation.dart';
import 'package:alura/apps/navigation/login_navigation.dart';
import 'package:alura/apps/navigation/package_details_navigation.dart';
import 'package:alura/apps/navigation/payment_navigation.dart';
import 'package:alura/apps/navigation/producer_details_navigation.dart';
import 'package:alura/apps/navigation/profile_navigation.dart';
import 'package:alura/apps/navigation/singup_navigation.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomeNavigation());
      case 'login':
        return MaterialPageRoute(builder: (_) => const LoginNavigation());
      case 'singup':
        return MaterialPageRoute(builder: (_) => const SingupNavigation());
      case 'favorites':
        return MaterialPageRoute(builder: (_) => const FavoritesNavigation());
      case 'profile':
        return MaterialPageRoute(builder: (_) => const ProfileNavigation());
      case 'payment':
        return MaterialPageRoute(builder: (_) => const PaymentNavigation());
      case 'producer-details':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => ProducerDetailsNavigation(name: args));
        }
        return _erroRoute();
      case 'package-details':
        if (args is String) {
          return MaterialPageRoute(
              builder: (_) => PackageDetailsNavigation(name: args));
        }
        return _erroRoute();
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
