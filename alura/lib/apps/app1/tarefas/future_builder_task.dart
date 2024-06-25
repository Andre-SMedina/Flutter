import 'package:alura/apps/app1/tarefas/data/task_dao.dart';
import 'package:alura/apps/app1/tarefas/task_cards.dart';
import 'package:flutter/material.dart';

class FutureBuilderTask extends StatelessWidget {
  const FutureBuilderTask({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
        future: TaskDao.findAll(),
        builder: (context, snapshot) {
          List<Task>? items = snapshot.data;

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Center(
                child: Column(
                  children: [CircularProgressIndicator(), Text('Carregando')],
                ),
              );
            case ConnectionState.waiting:
              return const Center(
                child: Column(
                  children: [CircularProgressIndicator(), Text('Carregando')],
                ),
              );
            case ConnectionState.active:
              return const Center(
                child: Column(
                  children: [CircularProgressIndicator(), Text('Carregando')],
                ),
              );
            case ConnectionState.done:
              if (snapshot.hasData && items != null) {
                if (items.isNotEmpty) {
                  // Text('ola');
                  return ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (BuildContext context, int index) {
                        final Task tarefa = items[index];

                        return tarefa;
                      });
                }
                return const Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 128,
                      ),
                      Text(
                        'Não há nenhuma tarefa!',
                        style: TextStyle(fontSize: 32),
                      )
                    ],
                  ),
                );
              }
              return Text('Erro ao carregar tarefas!');
          }
          // return const Text('Erro desconhecido!');
        });
  }
}
