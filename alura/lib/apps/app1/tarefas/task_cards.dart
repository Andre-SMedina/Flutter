import 'package:alura/apps/app1/tarefas/stars.dart';
import 'package:flutter/material.dart';

class TaskCards extends StatefulWidget {
  final String task;
  final String urlImage;
  TaskCards({super.key, required this.task, required this.urlImage});
  int nivel = 0;
  Stars dificulty = const Stars();

  @override
  State<TaskCards> createState() => _TaskState();
}

class _TaskState extends State<TaskCards> {
  @override
  Widget build(BuildContext context) {
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
                      // color: Colors.black26,
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
                        widget.dificulty
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
                          onPressed: () {
                            setState(() {
                              if (widget.nivel < 10) {
                                widget.nivel++;
                              }
                            });
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
                        value: widget.nivel / 10,
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
}
