import 'package:flutter/material.dart';
import 'package:panucci_delivery/components/order_item.dart';
import 'package:panucci_delivery/store/carrinho_store.dart';
import 'package:provider/provider.dart';
import '../components/payment_method.dart';
import '../components/payment_total.dart';

class Checkout extends StatelessWidget {
  const Checkout({Key? key}) : super(key: key);
  // final BuildContext homeContext;

  @override
  Widget build(BuildContext context) {
    final carrinhoStore = Provider.of<CarrinhoStore>(context, listen: false);

    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomScrollView(
            slivers: <Widget>[
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Pedido",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                return OrderItem(item: carrinhoStore.listaItem[index]);
              }, childCount: carrinhoStore.listaItem.length)),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Pagamento",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: PaymentMethod(),
              ),
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Confirmar",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: PaymentTotal(total: 00.00),
              ),
              SliverFillRemaining(
                hasScrollBody: false,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          foregroundColor: Colors.white,
                          backgroundColor:
                              Theme.of(context).colorScheme.surfaceTint),
                      child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.account_balance_wallet),
                            ),
                            Text(
                              "Pedir",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            )
                          ]),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
