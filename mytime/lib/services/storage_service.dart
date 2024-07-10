import 'package:intl/intl.dart';
import 'package:mytime/models/entry.dart';
import 'package:mytime/models/history_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mytime/models/entry.dart';
// import 'package:mytime/models/history_entry.dart';

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

//   Future<void> saveEntries(List<Entry> entries) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> entriesStrings =
//         entries.map((entry) => entry.toString()).toList();
//     await prefs.setStringList('entries', entriesStrings);
//   }

//   Future<List<Entry>> loadEntries() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey('entries')) {
//       List<String> entriesStrings = prefs.getStringList('entries')!;
//       return entriesStrings.map((item) => Entry.fromString(item)).toList();
//     }
//     return [];
//   }

//   Future<void> saveHistory(List<HistoryEntry> history) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     List<String> historyList = history.map((entry) {
//       String entriesString = entry.entries.map((e) => e.toString()).join('|');
//       return '${entry.date};${entry.totalSeconds};$entriesString';
//     }).toList();
//     await prefs.setStringList('history', historyList);
//   }

//   Future<List<HistoryEntry>> loadHistory() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     if (prefs.containsKey('history')) {
//       List<String> historyStrings = prefs.getStringList('history')!;
//       return historyStrings.map((item) {
//         List<String> parts = item.split(';');
//         return HistoryEntry(
//           date: parts[0],
//           totalSeconds: int.parse(parts[1]),
//           entries: parts[2]
//               .split('|')
//               .map((entry) => Entry.fromString(entry))
//               .toList(),
//         );
//       }).toList();
//     }
//     return [];
//   }

//   Future<void> clearAllData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }
}
