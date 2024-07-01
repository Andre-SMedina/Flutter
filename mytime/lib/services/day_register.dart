import 'package:flutter/material.dart';
import 'package:mytime/styles/my_text_styles.dart';

dayRegisterList(bool toggle, List lista) {
  // List<Widget> listRegisters = [];
  // var dateNow = DateTime.now().add(const Duration(hours: -3));
  var hourNow = DateTime.now().add(const Duration(hours: -3)).hour.toString();
  var minNow = DateTime.now().add(const Duration(hours: -3)).minute.toString();
  var hourFullNow = '$hourNow:$minNow';

  if (toggle) {
    return MyWidget(initHour: hourFullNow, finalHour: '...');
  } else {
    lista[lista.length - 1] = MyWidget(initHour: hourFullNow, finalHour: 'xxx');
    return lista[lista.length - 1];
  }
  // print(hourFullNow);

  // return lista;
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
