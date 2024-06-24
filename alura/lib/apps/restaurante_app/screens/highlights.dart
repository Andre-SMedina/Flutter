import 'package:alura/cardapio.dart';
import 'package:alura/apps/restaurante_app/components/highlight_item.dart';
import 'package:flutter/material.dart';

class Highlights extends StatelessWidget {
  const Highlights({super.key});

  final List items = destaques;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: CustomScrollView(
          slivers: <Widget>[
            const SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text('Destaques do Dia',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontFamily: 'Caveat', fontSize: 32)),
            )),
            SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return HighlightItem(
                    imageURI: items[index]['image'],
                    itemTitle: items[index]['name'],
                    itemPrice: items[index]['price'],
                    itemDescription: items[index]['description']);
              }, childCount: items.length),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).orientation ==
                          Orientation.landscape
                      ? 2
                      : 1,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.1),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 80,
              ),
            )
          ],
        ));
  }
}
