import 'package:alura/apps/restaurante_app/components/main_drawer.dart';
import 'package:alura/apps/restaurante_app/screens/checkout.dart';
import 'package:alura/apps/restaurante_app/screens/drinks_menu.dart';
import 'package:alura/apps/restaurante_app/screens/food_menu.dart';
import 'package:alura/apps/restaurante_app/screens/highlights.dart';
import 'package:alura/apps/restaurante_app/themes/app_colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> pages = const [Highlights(), FoodMenu(), DrinksMenu()];
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ristorante Panucci"),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        actions: const <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(
              Icons.account_circle,
              size: 32,
            ),
          )
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: ((context) {
            return const Checkout();
          })));
        },
        child: const Icon(Icons.point_of_sale),
      ),
      drawer: const MainDrawer(),
      //barra que fica na parte inferior da tela
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rounded),
            label: 'Destaques',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_bar),
            label: 'Bebidas',
          ),
        ],
        selectedItemColor: AppColors.bottomNavigationBarIconColor,
        currentIndex: _currentPage,
        onTap: (index) {
          setState(() {
            _currentPage = index;
          });
        },
      ),
      body: pages.elementAt(_currentPage),
    );
  }
}
