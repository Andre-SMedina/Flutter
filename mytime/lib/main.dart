import 'package:flutter/material.dart';
import 'package:mytime/services/day_register.dart';
import 'package:mytime/styles/my_text_styles.dart';

void main() {
  runApp(const MyTime());
}

class MyTime extends StatefulWidget {
  const MyTime({super.key});

  @override
  State<MyTime> createState() => _MyTimeState();
}

class _MyTimeState extends State<MyTime> {
  bool toggleBtn = true;
  DateTime timeTotalGeral = DateTime(
      DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0);
  DateTime oldTime = DateTime.now();
  DateTime oldDate = DateTime(0000, 0, 0, 0, 0);
  var timeTotal = '00:00';
  List<Widget> registers = [];

  //TODO: atualizar listas
  Future<List<Widget>> getData() {
    return Future.value(registers);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 190, 13, 0),
          title: const Text(
            'My Time',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.00),
          child: Center(
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      List<dynamic> result = dayRegisterList(
                          toggleBtn, registers,
                          oldTime: oldTime,
                          oldDate: oldDate,
                          timeTotalGeral: timeTotalGeral);

                      if (toggleBtn) {
                        oldTime = result[0];
                        registers.add(result[1]);
                      } else {
                        registers[registers.length - 1] = result[0];
                        timeTotal = result[1];
                        timeTotalGeral = result[2];
                      }
                      toggleBtn = !toggleBtn;
                    });
                  },
                  child: Text(
                    (toggleBtn) ? 'Iniciar' : 'Finalizar',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Registros de hoje $timeTotal',
                    style: MyTextStyles.title,
                  ),
                ),
                Container(
                  // alignment: Alignment.topCenter,
                  height: 300,
                  width: 340,
                  margin: const EdgeInsets.only(top: 5, bottom: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  //TODO: atualizar listas
                  child: FutureBuilder(
                      future: getData(),
                      builder: (_, data) {
                        return ListView.builder(
                            itemCount: registers.length,
                            itemBuilder: (_, int index) {
                              return registers[index];
                            });
                      }),
                ),
                Text(
                  'Histórico',
                  style: MyTextStyles.title,
                ),
                Container(
                  height: 200,
                  width: 340,
                  margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                  child: Column(
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  final String initHour;
  final String finalHour;
  const MyWidget({super.key, required this.initHour, required this.finalHour});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 3),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Início ${widget.initHour}',
            style: MyTextStyles.comum,
          ),
          Text('Término: ${widget.finalHour}', style: MyTextStyles.comum)
        ],
      ),
    );
  }
}
