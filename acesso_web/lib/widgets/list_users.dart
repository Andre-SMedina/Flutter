import 'package:flutter/material.dart';

class ListUsers extends StatefulWidget {
  final List<Map<String, dynamic>> listUsers;

  const ListUsers({super.key, required this.listUsers});

  @override
  State<ListUsers> createState() => _ListUsersState();
}

class _ListUsersState extends State<ListUsers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          border: Border.all(color: Colors.black)),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
      alignment: Alignment.centerLeft,
      width: 600,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(widget.listUsers.length, (index) {
          Map<String, dynamic> visitante = widget.listUsers[index];

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      child: Text(visitante['nome']),
                      onPressed: () {},
                    ),
                    Text(visitante['profissao']),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
              )
            ],
          );
        }),
      ),
    );
  }
}
