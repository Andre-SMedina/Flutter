import 'package:alura/apps/bank/themes/my_theme_colors.dart';
import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: MyThemeColors.headerGradient),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 80, 16, 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //TODO: Text.rich permite colocar estilos diferentes na mesma linha de texto
                Text.rich(
                  TextSpan(
                    text: '\$',
                    style: const TextStyle(fontSize: 20),
                    children: <TextSpan>[
                      TextSpan(
                          text: '1000,00',
                          style: Theme.of(context).textTheme.bodyLarge)
                    ],
                  ),
                ),
                const Text(
                  'Balanço disponível',
                ),
              ],
            ),
            const Icon(
              Icons.account_circle,
              size: 42,
            )
          ],
        ),
      ),
    );
  }
}
