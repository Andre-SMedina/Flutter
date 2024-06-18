import 'package:flutter/material.dart';

class Desafio1 extends StatefulWidget {
  const Desafio1({super.key});

  @override
  State<Desafio1> createState() => _Desafio1State();
}

class _Desafio1State extends State<Desafio1> {
  // This widget is the root of your application.
  double show = 1.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          leading: const Icon(
            Icons.task,
            color: Colors.yellow,
          ),
          backgroundColor: Colors.blue,
          title: const Text(
            'Tarefas',
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: AnimatedOpacity(
          opacity: show,
          duration: const Duration(milliseconds: 600),
          child: ListView(
            children: const [
              Task(
                  urlImage: 'assets/images/flutter.png',
                  task: 'Aprender Flutter ajsd lkj akj dhlaksj '),
              Task(urlImage: 'assets/images/dart.png', task: 'Aprender Dart'),
              Task(urlImage: 'assets/images/java.png', task: 'Aprender java'),
              Task(
                  urlImage: 'assets/images/flutter.png',
                  task: 'Aprender Flutter'),
              Task(urlImage: 'assets/images/dart.png', task: 'Aprender Dart'),
              Task(urlImage: 'assets/images/java.png', task: 'Aprender java'),
              Task(
                  urlImage: 'assets/images/flutter.png',
                  task: 'Aprender Flutter'),
              Task(urlImage: 'assets/images/dart.png', task: 'Aprender Dart'),
              Task(urlImage: 'assets/images/java.png', task: 'Aprender java'),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                show = (show == 1) ? 0 : 1;
              });
            },
            child: const Icon(Icons.remove_red_eye_outlined)),
      ),
    );
  }
}

class Task extends StatefulWidget {
  final String task;
  final String urlImage;
  const Task({super.key, required this.task, required this.urlImage});

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  int nivel = 0;
  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;
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
                        child: Image.asset(
                          widget.urlImage,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                        stars()
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
                              if (nivel < 10) {
                                nivel++;
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
                        value: nivel / 10,
                      ),
                    ),
                    Text(
                      'Nível $nivel',
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

  stars() {
    return Row(
      children: [
        IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 15,
            onPressed: () {
              setState(() {
                if (star1) {
                  star1 = !star1;
                  star2 = true;
                  star3 = true;
                } else {
                  star2 = true;
                  star3 = true;
                }
              });
            },
            icon: (star1)
                ? const Icon(
                    Icons.star_border,
                  )
                : const Icon(
                    Icons.star,
                  )),
        IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 15,
            onPressed: () {
              setState(() {
                if (star2) {
                  star1 = false;
                  star2 = !star2;
                  star3 = true;
                } else {
                  star1 = false;
                  star3 = true;
                }
              });
            },
            icon: (star2)
                ? const Icon(
                    Icons.star_border,
                  )
                : const Icon(
                    Icons.star,
                  )),
        IconButton(
            visualDensity: VisualDensity.compact,
            iconSize: 15,
            onPressed: () {
              setState(() {
                if (star3) {
                  star1 = false;
                  star2 = false;
                  star3 = !star3;
                } else {
                  star1 = false;
                  star2 = false;
                }
              });
            },
            icon: (star3)
                ? const Icon(
                    Icons.star_border,
                  )
                : const Icon(
                    Icons.star,
                  )),
      ],
    );
  }
}
