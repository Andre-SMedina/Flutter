import 'package:alura/apps/bank/components/box_card.dart';
import 'package:alura/apps/bank/components/content_division.dart';
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
                children: [],
              )
            ],
          )),
        ],
      ),
    );
  }
}
