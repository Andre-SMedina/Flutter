import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Nova Tarefa',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 3)),
            height: 650,
            width: 375,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    textFields('Nome', nameController),
                    textFields('Idade', ageController,
                        type: true, valid: 'idade'),
                    textFields('Imagem', imageController, valid: 'image'),
                    Container(
                      height: 100,
                      width: 72,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          border: Border.all(width: 2)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageController.text,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Image.asset('assets/images/noImage.png');
                          },
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              print('Sucesso!');
                            }
                          });
                        },
                        child: Text('Adicionar')),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textFields(
      String textField, TextEditingController inputController,
      {bool type = false, String valid = 'text'}) {
    return TextFormField(
      validator: (value) {
        if (valid == 'text') {
          if (value != null && value.isEmpty) {
            return 'Insira o nome da tarefa';
          }
        }
        if (valid == 'idade') {
          if (value!.isEmpty ||
              int.parse(value) > 100 ||
              int.parse(value) < 5) {
            return 'Idade deve ser entre 5 e 100';
          }
        }
        if (valid == 'image') {
          if (value!.isEmpty) {
            return 'Insira uma URL de imagem';
          }
        }
        return null;
      },
      //TODO: Definir a entrada somente de números
      inputFormatters: [
        (valid == 'idade')
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter,
      ],
      keyboardType: (type) ? TextInputType.number : TextInputType.text,
      controller: inputController,
      onChanged: (v) {
        setState(() {});
      },
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: textField,
          filled: true,
          fillColor: Colors.white70),
    );
  }
}
