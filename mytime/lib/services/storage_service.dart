import 'package:intl/intl.dart';
import 'package:mytime/models/entry.dart';
import 'package:mytime/models/history_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  void saveEntries(List<Entry> entries) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> entriesList =
        entries.map((entry) => entry.toString()).toList();
    await prefs.setStringList('entries', entriesList);
  }

  void saveHistory(List history) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyList = history.map((entry) {
      String entriesString = entry.entries.map((e) => e.toString()).join('|');
      return '${entry.date};${entry.totalSeconds};$entriesString';
    }).toList();
    prefs.setStringList('history', historyList);
  }

  loadEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('entries')) {
      List<Entry> entries = prefs
          .getStringList('entries')!
          .map((item) => Entry.fromString(item))
          .toList();
      if (entries.last.start == entries.last.end) {
        entries.removeLast();
      }

      return entries;
    }
  }

  void moveToHistory(List<Entry> entries, List history, DateTime currentDate,
      int totalSeconds) {
    if (entries.isNotEmpty) {
      history.add(HistoryEntry(
        date: DateFormat('yyyy-MM-dd').format(currentDate),
        totalSeconds: totalSeconds,
        entries: List.from(entries),
      ));
      saveHistory(history);
    }
  }
}
