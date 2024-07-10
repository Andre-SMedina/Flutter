import 'package:flutter/material.dart';

class MyExpanded extends StatelessWidget {
  const MyExpanded({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expanded Example'),
        ),
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                color: Colors.red,
                child: const Center(child: Text('1 Flex')),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.green,
                child: const Center(child: Text('2 Flex')),
              ),
            ),
            // Expanded(
            //   flex: 3,
            //   child: Container(
            //     color: Colors.blue,
            //     child: const Center(child: Text('3 Flex')),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
