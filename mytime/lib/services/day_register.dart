import 'package:flutter/material.dart';
import 'package:mytime/styles/my_text_styles.dart';

List<dynamic> dayRegisterList(bool toggle, List lista,
    {
    //hora inicial anterior txt
    var oldTimeTxt,
    var oldTimeDt,
    //a soma de todos os períodos Date
    DateTime? timeTotalGeralDt,
    var historic}) {
  DateTime dateNow = DateTime.now();
  DateTime? hourTotal;
  String hourNow = dateNow.hour.toString().padLeft(2, '0');
  String minNow = dateNow.minute.toString().padLeft(2, '0');
  String secNow = dateNow.second.toString().padLeft(2, '0');
  //texto no formato hora mostrado no início
  String hourFullNow = '$hourNow:$minNow:$secNow';

  if (toggle) {
    return [
      dateNow,
      MyWidget(initHour: hourFullNow, finalHour: 'xx:xx'),
      hourFullNow
    ];
  } else {
    var seconds = dateNow.difference(oldTimeDt).inSeconds;
    hourTotal = timeTotalGeralDt!.add(Duration(seconds: seconds));
    String buildHourTotalTxt =
        '${hourTotal.hour.toString().padLeft(2, '0')}:${hourTotal.minute.toString().padLeft(2, '0')}:${hourTotal.second.toString().padLeft(2, '0')}';

    lista[lista.length - 1] =
        MyWidget(initHour: oldTimeTxt, finalHour: hourFullNow);
    return [lista[lista.length - 1], buildHourTotalTxt, hourTotal];
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
