import 'package:alura/cardapio.dart';
import 'package:alura/desafios/restaurante_app/components/food_item.dart';
import 'package:flutter/material.dart';

class FoodMenu extends StatelessWidget {
  const FoodMenu({super.key});
  final List foods = comidas;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: Text('Menu'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return FoodItem(
                    itemTitle: foods[index]['name'],
                    itemPrice: foods[index]['price'],
                    imageURI: foods[index]['image']);
              },
              childCount: foods.length,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 80,
            ),
          )
        ],
      ),
    );
  }
}
