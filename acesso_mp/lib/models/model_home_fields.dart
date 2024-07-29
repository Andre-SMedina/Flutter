import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validatorless/validatorless.dart';

class ModelHomeFields extends StatelessWidget {
  final String text;
  final String validadtor;
  ModelHomeFields({super.key, required this.text, required this.validadtor});

  final TextEditingController fieldController = TextEditingController();
  List<FormFieldValidator<String>> listValidator = [];

  @override
  Widget build(BuildContext context) {
    List<TextInputFormatter>? onlyNumbers = [];
    if (validadtor != '') {
      listValidator.add(Validatorless.required('Campo obrigatório!'));

      switch (validadtor) {
        case 'name':
          listValidator.add(Validatorless.min(
              10, 'O nome deve possuir no mínimo 10 letras!'));
          break;
        case 'cpf':
          listValidator.add(Validatorless.cpf('CPF inválido!'));
          onlyNumbers.add(FilteringTextInputFormatter.digitsOnly);
          break;
        case 'rg' || 'phone':
          onlyNumbers.add(FilteringTextInputFormatter.digitsOnly);
          break;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        validator: Validatorless.multiple(listValidator),
        controller: fieldController,
        inputFormatters: onlyNumbers,
        decoration: InputDecoration(
          labelText: text,
        ),
      ),
    );
  }

  void loadData(String text) {
    fieldController.text = text;
  }

  void clearData() {
    fieldController.clear();
  }
}
