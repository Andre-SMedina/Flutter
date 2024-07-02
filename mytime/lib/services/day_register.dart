import 'package:flutter/material.dart';
import 'package:mytime/styles/my_text_styles.dart';

List<dynamic> dayRegisterList(bool toggle, List lista,
    {var oldTime, var oldDate, var timeTotalGeral}) {
  DateTime dateNow = DateTime.now();
  DateTime? hourTotal;
  String hourNow = dateNow.hour.toString();
  String minNow = dateNow.minute.toString();
  String hourFullNow =
      '${(hourNow.length == 2) ? hourNow : '0$hourNow'}:${(minNow.length == 2) ? minNow : '0$minNow'}';

  if (toggle) {
    return [
      dateNow,
      MyWidget(initHour: hourFullNow, finalHour: 'xx:xx'),
    ];
  } else {
    var seconds = dateNow.difference(oldDate).inSeconds;
    hourTotal = timeTotalGeral.add(Duration(seconds: seconds));
    String buildHourTotal =
        '${hourTotal!.hour}:${hourTotal.minute}:${hourTotal.second}';
    // var hourTotal = dateNow.difference(oldDate).toString().split('.')[0];

    lista[lista.length - 1] =
        MyWidget(initHour: oldTime, finalHour: hourFullNow);
    return [lista[lista.length - 1], buildHourTotal, hourTotal];
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
