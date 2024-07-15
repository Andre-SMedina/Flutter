import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:useapi/screens/add_journal_screen/add_journal_screen.dart';
import 'package:useapi/services/journal_service.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const ApiTest());
}

class ApiTest extends StatelessWidget {
  const ApiTest({super.key});

  @override
  Widget build(BuildContext context) {
    JournalService service = JournalService();

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              service.get();
            },
            child: const Text('Aperte'),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Journal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: "add-journal",
      routes: {
        "home": (context) => const HomeScreen(),
        "add-journal": (context) => const AddJournalScreen(),
      },
    );
  }
}
