import 'package:acesso_web/widgets/input_decorations.dart';
import 'package:flutter/material.dart';

class RegisterLayout extends StatelessWidget {
  RegisterLayout({super.key});

  final TextEditingController _nome = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _job = TextEditingController();
  final TextEditingController _rg = TextEditingController();
  final TextEditingController _reasonVisit = TextEditingController();

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
                      width: 350,
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
                        controller: _reasonVisit,
                        decoration: myInputDecoration('Motivo da visita'),
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
