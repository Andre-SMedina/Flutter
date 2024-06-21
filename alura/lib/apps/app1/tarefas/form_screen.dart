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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textFields('Nome', nameController),
                  textFields('Idade', ageController, type: true),
                  textFields('Imagem', imageController),
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
                        setState(() {});
                      },
                      child: Text('Adicionar')),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField textFields(
      String textField, TextEditingController inputController,
      {bool type = false}) {
    return TextFormField(
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
