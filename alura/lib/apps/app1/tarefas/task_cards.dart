import 'package:alura/apps/app1/tarefas/data/task_dao.dart';
import 'package:alura/apps/app1/tarefas/data/task_dao_lv.dart';
import 'package:alura/apps/app1/tarefas/stars.dart';
import 'package:flutter/material.dart';

class Task extends StatefulWidget {
  final String task;
  final int difficulty;
  final String urlImage;
  Task(
      {super.key,
      required this.task,
      required this.urlImage,
      required this.difficulty});
  double nivel = 0;
  double progressBar = 0;

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    widget.progressBar = (widget.nivel / widget.difficulty) / 10;
    // widget.nivel = TaskDaoLv.find(widget.task)[0]['lv'];
    double lv = 0;
    TaskDaoLv.find(widget.task).then((onValue) {
      if (onValue.isNotEmpty) {
        lv = onValue[1]['lv'];
      }
      print(lv);
    });
    // print(lv);
    return Container(
      margin: const EdgeInsets.all(10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(10)),
            height: 140,
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.only(right: 10),
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      height: 100,
                      width: 72,
                      //TODO:ClipRRect coloca bordas nos filhos do container
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: (widget.urlImage.contains('http'))
                              ? Image.network(
                                  widget.urlImage,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  widget.urlImage,
                                  fit: BoxFit.cover,
                                )),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Text(
                            widget.task,
                            style: const TextStyle(
                                fontSize: 22, overflow: TextOverflow.ellipsis),
                          ),
                        ),
                        Stars(difficulty: widget.difficulty)
                      ],
                    ),
                    SizedBox(
                      height: 52,
                      width: 52,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onLongPress: () {
                            _showMyDialog();
                            // TaskDao.delete(widget.task);
                          },
                          onPressed: () {
                            setState(() {
                              if (widget.progressBar != 1) {
                                widget.nivel++;
                              }
                            });
                            TaskDaoLv.save(widget.task, widget.nivel);
                          },
                          child: const Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Icon(Icons.arrow_drop_up),
                              Text(
                                'UP',
                                style: TextStyle(fontSize: 12),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: LinearProgressIndicator(
                        color: Colors.blue[900],
                        value: widget.progressBar,
                      ),
                    ),
                    Text(
                      'Nível ${widget.nivel}',
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Deseja apagar a tarefa?'),
          actions: <Widget>[
            Row(
              children: [
                TextButton(
                  child: const Text('Sim'),
                  onPressed: () {
                    TaskDao.delete(widget.task);
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('Não'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
