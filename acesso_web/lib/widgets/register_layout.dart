import 'package:acesso_web/widgets/input_decorations.dart';
import 'package:flutter/material.dart';

class RegisterLayout extends StatefulWidget {
  const RegisterLayout({super.key});

  @override
  State<RegisterLayout> createState() => _RegisterLayoutState();
}

class _RegisterLayoutState extends State<RegisterLayout> {
  final TextEditingController _nome = TextEditingController();

  final TextEditingController _cpf = TextEditingController();

  final TextEditingController _job = TextEditingController();

  final TextEditingController _rg = TextEditingController();

  final TextEditingController _whoVisit = TextEditingController();

  List<Book> books = allBooks;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SizedBox(
            width: 650,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 420,
                      child: TextFormField(
                        controller: _nome,
                        decoration: myInputDecoration('Nome'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _cpf,
                        decoration: myInputDecoration('CPF'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 420,
                      child: TextFormField(
                        controller: _whoVisit,
                        decoration: myInputDecoration('Quem visitar'),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: TextFormField(
                        controller: _rg,
                        decoration: myInputDecoration('Registro Geral'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 420,
                      child: TextFormField(
                        controller: _job,
                        decoration: myInputDecoration('Profissão'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Book {
  final String title;

  Book({required this.title});
}

var allBooks = [Book(title: 'Xuxa'), Book(title: 'Joao'), Book(title: 'Pedro')];
