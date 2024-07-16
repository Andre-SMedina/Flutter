import 'package:flutter/material.dart';
import 'package:useapi/helpers/weekday.dart';
import 'package:useapi/models/journal.dart';

class AddJournalScreen extends StatelessWidget {
  final Journal journal;
  const AddJournalScreen({super.key, required this.journal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${WeekDay(journal.createdAt.weekday).long.toLowerCase()}, ${journal.createdAt.day}  |  ${journal.createdAt.month}  |  ${journal.createdAt.year}'),
        actions: const [Icon(Icons.check)],
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: TextField(
          maxLines: null,
          minLines: null,
          keyboardType: TextInputType.multiline,
          expands: true,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
