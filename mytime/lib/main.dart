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
  Map<String, dynamic> mapTime = {
    'toggleBtn': true,
    'oldTimeTxt': '',
    //texto no formato hora mostrado no início
    'oldTimeDt': DateTime.now(),
    //tempo total mostrado na tela
    'timeTotalTxt': '00:00:00',
    'timeTotalGeral': DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0),
    'register': '',
    'historic': '',
  };
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton:
            ElevatedButton(onPressed: () {}, child: const Text('add')),
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
                      if (mapTime['timeTotalGeral'].day != DateTime.now().day) {
                        historicCard();
                        registers = [];
                        mapTime['timeTotalTxt'] = '00:00:00';
                        mapTime['oldTimeTxt'] = '';
                        mapTime['timeTotalGeral'] = DateTime(
                            DateTime.now().year,
                            DateTime.now().month,
                            DateTime.now().day,
                            0,
                            0);
                      }

                      List<dynamic> result = dayRegisterList(
                        mapTime['toggleBtn'],
                        registers,
                        oldTimeTxt: mapTime['oldTimeTxt'],
                        oldTimeDt: mapTime['oldTimeDt'],
                        timeTotalGeralDt: mapTime['timeTotalGeral'],
                        // oldDate: oldDateGeralDt,
                      );

                      if (mapTime['toggleBtn']) {
                        //oldTimeDt é a hora inicial para calcular a hora na linha
                        mapTime['oldTimeDt'] = result[0];
                        registers.add(result[1]);
                        mapTime['oldTimeTxt'] = result[2];
                      } else {
                        registers[registers.length - 1] = result[0];
                        mapTime['timeTotalTxt'] = result[1];
                        mapTime['timeTotalGeral'] = result[2];
                      }

                      mapTime['toggleBtn'] = !mapTime['toggleBtn'];
                    });
                  },
                  child: Text(
                    (mapTime['toggleBtn']) ? 'Iniciar' : 'Finalizar',
                    style: const TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    'Registros de hoje ${mapTime['timeTotalTxt']}',
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 7.0),
                  child: Text(
                    'Histórico',
                    style: MyTextStyles.title,
                  ),
                ),
                Ink(
                  height: 200,
                  width: 340,
                  // margin: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverGrid(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return historic[index];
                        }, childCount: historic.length),
                        //configura para 2 colunas
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          //espaço entre os cards
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          //tamanho de cada cartão, onde o primeiro valor é a largura e o segundo a altura 158/194
                          childAspectRatio: 3.5,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  historicCard() {
    String day = formatTime(mapTime['timeTotalGeral'].day.toString());
    String month = formatTime(mapTime['timeTotalGeral'].month.toString());
    String year = formatTime(mapTime['timeTotalGeral'].year.toString());
    String hour = formatTime(mapTime['timeTotalGeral'].hour.toString());
    String minute = formatTime(mapTime['timeTotalGeral'].minute.toString());
    String second = formatTime(mapTime['timeTotalGeral'].second.toString());
    historic.add(Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Text(
            '$day/$month/$year',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            '$hour:$minute:$second',
          ),
        ],
      ),
    ));
  }

  formatTime(String time) {
    return (time.length == 1) ? '0$time' : time;
  }
}
