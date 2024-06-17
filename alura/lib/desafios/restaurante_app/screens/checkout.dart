import 'package:alura/cardapio.dart';
import 'package:alura/desafios/restaurante_app/components/main_drawer.dart';
import 'package:alura/desafios/restaurante_app/components/order_item.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  const Checkout({super.key});

  @override
  Widget build(BuildContext context) {
    const List pedidos = pedido;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Ristorante Panucci"),
          backgroundColor:
              Theme.of(context).colorScheme.surfaceContainerHighest,
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

        drawer: const MainDrawer(),
        //barra que fica na parte inferior da tela

        body: Padding(
          padding: const EdgeInsets.all(16),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Pedido',
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return OrderItem(
                    imageURI: pedidos[index]['image'],
                    itemTitle: pedidos[index]['name'],
                    itemPrice: pedidos[index]['price']);
              }, childCount: pedidos.length))
            ],
          ),
        ),
      ),
    );
  }
}
