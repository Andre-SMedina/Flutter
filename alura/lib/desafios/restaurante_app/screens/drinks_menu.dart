import 'package:alura/cardapio.dart';
import 'package:alura/desafios/restaurante_app/components/drink_item.dart';
import 'package:flutter/material.dart';

class DrinksMenu extends StatelessWidget {
  const DrinksMenu({super.key});

  final List drinkList = drinks;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: CustomScrollView(
        slivers: <Widget>[
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Text(
                'Bebidas',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 32, fontFamily: 'Caveat'),
              ),
            ),
          ),
          SliverGrid(
            delegate: SliverChildBuilderDelegate((context, index) {
              return DrinkItem(
                  imageURI: drinkList[index]['image'],
                  itemTitle: drinkList[index]['name'],
                  itemPrice: drinkList[index]['price']);
            }, childCount: drinkList.length),
            //configura 2 colunas
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              //espaço entre os cards
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              //tamanho de cada cartão, onde o primeiro valor é a largura e o segundo a altura 158/194
              childAspectRatio: 158 / 194,
            ),
          ),
          const SliverToBoxAdapter(
              child: SizedBox(
            height: 80,
          ))
        ],
      ),
    );
  }
}

/*
Utilizando GridView
GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, index) {
        return DrinkItem(
            imageURI: drinkList[index]['image'],
            itemTitle: drinkList[index]['name'],
            itemPrice: drinkList[index]['price']);
      },
      itemCount: drinkList.length,
    );
*/