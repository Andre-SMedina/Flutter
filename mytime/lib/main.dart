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
  //texto no formato hora mostrado no início
  DateTime oldTimeDt = DateTime.now();
  String oldTimeTxt = '';
  //tempo total mostrado na tela
  String timeTotalTxt = '00:00:00';
  List<Widget> registers = [];
  List<Widget> historic = [];

  //TODO: atualizar listas
  Future<List<Widget>> getRegisters() {
    return Future.value(registers);
  }

  Future<List<Widget>> getHistoric() {
    return Future.value(historic);
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
                      // if (timeTotalGeral.day != DateTime.now().day) {
                      if (true) {
                        historic.add(historicCard());
                        // registers = [];
                        // timeTotalTxt = '00:00:00';
                        // oldTimeTxt = '';
                        // timeTotalGeral = DateTime(DateTime.now().year,
                        //     DateTime.now().month, DateTime.now().day, 0, 0);
                      }

                      List<dynamic> result = dayRegisterList(
                        toggleBtn,
                        registers,
                        oldTimeTxt: oldTimeTxt,
                        oldTimeDt: oldTimeDt,
                        timeTotalGeralDt: timeTotalGeral,
                        // oldDate: oldDateGeralDt,
                      );

                      if (toggleBtn) {
                        //oldTimeDt é a hora inicial para calcular a hora na linha
                        oldTimeDt = result[0];
                        registers.add(result[1]);
                        oldTimeTxt = result[2];
                      } else {
                        registers[registers.length - 1] = result[0];
                        timeTotalTxt = result[1];
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
                    'Registros de hoje $timeTotalTxt',
                    style: MyTextStyles.title,
                  ),
                ),
                Container(
                  // alignment: Alignment.topCenter,
                  height: 300,
                  width: 400,
                  margin: const EdgeInsets.only(top: 5, bottom: 15),
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  //TODO: atualizar listas
                  child: FutureBuilder(
                      future: getRegisters(),
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
                  child: FutureBuilder(
                      future: getHistoric(),
                      builder: (_, data) {
                        return ListView.builder(
                            itemCount: historic.length,
                            itemBuilder: (_, int index) {
                              return historic[index];
                            });
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget historicCard() {
  return Text('Blz');
}
