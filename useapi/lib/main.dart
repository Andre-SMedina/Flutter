import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:useapi/models/journal.dart';
import 'package:useapi/screens/add_journal_screen/add_journal_screen.dart';
import 'screens/home_screen/home_screen.dart';

void main() {
  runApp(const MyApp());
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
          actionsIconTheme: IconThemeData(color: Colors.white),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 0,
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        textTheme: GoogleFonts.bitterTextTheme(),
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: "home",
      routes: {
        "home": (context) => const HomeScreen(),
        // "add-journal": (context) => AddJournalScreen(
        //       journal: Journal(
        //           content: '',
        //           id: '',
        //           createdAt: DateTime.now(),
        //           updatedAt: DateTime.now()),
        //     ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == "add-journal") {
          final Journal journal = settings.arguments as Journal;
          return MaterialPageRoute(builder: (context) {
            return AddJournalScreen(journal: journal);
          });
        }
      },
    );
  }
}
