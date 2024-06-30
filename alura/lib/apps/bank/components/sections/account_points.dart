import 'package:alura/apps/bank/components/box_card.dart';
import 'package:alura/apps/bank/components/color_dot.dart';
import 'package:alura/apps/bank/components/content_division.dart';
import 'package:alura/apps/bank/themes/my_theme_colors.dart';
import 'package:flutter/material.dart';

class AccountPoints extends StatelessWidget {
  const AccountPoints({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pontos da conta',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          BoxCard(
              boxContent: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Pontos totais:'),
              Text(
                '3000',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const ContentDivision(),
              Text(
                'Objetivos:',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Row(
                children: [
                  ColorDot(
                      color: MyThemeColors.recentActivity(EnumColors.delivery)),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text('Entrega grátis: 1500pts'),
                  )
                ],
              ),
              Row(
                children: [
                  ColorDot(
                      color: MyThemeColors.recentActivity(EnumColors.stream)),
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 4.0),
                    child: Text('1 mês de streaming: 3000pts'),
                  )
                ],
              )
            ],
          )),
        ],
      ),
    );
  }
}
