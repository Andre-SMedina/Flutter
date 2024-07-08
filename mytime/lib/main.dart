import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF3F51B5),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFF4081),
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF212121)),
          bodyMedium: TextStyle(color: Color(0xFF757575)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> _entries = [];
  List<Map<String, dynamic>> _history = [];
  bool _isStarted = false;
  String? _startTime;
  DateTime _currentDate = DateTime.now();
  int totalSeconds = 0;

  @override
  void initState() {
    super.initState();
    _loadHistory();
    _loadEntries();
  }

  void _loadHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('history')) {
      setState(() {
        _history = prefs.getStringList('history')!.map((item) {
          List<String> parts = item.split(';');
          return {
            'date': parts[0],
            'totalSeconds': int.parse(parts[1]),
            'entries':
                List<Map<String, String>>.from(parts[2].split('|').map((entry) {
              List<String> entryParts = entry.split(':');
              return {'start': entryParts[0], 'end': entryParts[1]};
            })),
          };
        }).toList();
      });
    }
  }

  void _saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyList = _history.map((entry) {
      String entriesString =
          entry['entries'].map((e) => '${e['start']}:${e['end']}').join('|');
      return '${entry['date']};${entry['totalSeconds']};$entriesString';
    }).toList();
    prefs.setStringList('history', historyList);
  }

  void _loadEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('entries')) {
      setState(() {
        _entries = prefs
            .getStringList('entries')!
            .map((item) => item.split(':'))
            .map((parts) => {'start': parts[0], 'end': parts[1]})
            .toList();
        _calculateTotalSeconds();
      });
    }
  }

  void _saveEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> entriesList = _entries.map((entry) {
      return '${entry['start']}:${entry['end']}';
    }).toList();
    await prefs.setStringList('entries', entriesList);
  }

  void _toggleButton() {
    if (_entries.isNotEmpty && _currentDate.day != DateTime.now().day) {
      _finalizeLastEntryIfNeeded();
      _moveToHistory();
    }

    if (_isStarted) {
      String endTime = DateFormat('kk:mm:ss').format(DateTime.now());
      setState(() {
        _entries[_entries.length - 1]['end'] = endTime;
        _isStarted = false;
        _calculateTotalSeconds();
        _saveEntries();
      });
    } else {
      _startTime = DateFormat('kk:mm:ss').format(DateTime.now());
      setState(() {
        _entries.add({'start': _startTime!, 'end': ''});
        _isStarted = true;
        _saveEntries();
      });
    }
  }

  void _finalizeLastEntryIfNeeded() {
    if (_isStarted && _entries.isNotEmpty && _entries.last['end'] == '') {
      String endTime = DateFormat('kk:mm:ss').format(DateTime.now());
      setState(() {
        _entries[_entries.length - 1]['end'] = endTime;
        _isStarted = false;
        _calculateTotalSeconds();
      });
    }
  }

  void _calculateTotalSeconds() {
    int total = 0;
    for (var entry in _entries) {
      if (entry['start'] != null && entry['end'] != null) {
        DateTime startTime = DateFormat('kk:mm:ss').parse(entry['start']!);
        DateTime endTime = DateFormat('kk:mm:ss').parse(entry['end']!);
        Duration difference = endTime.difference(startTime);
        total += difference.inSeconds;
      }
    }
    setState(() {
      totalSeconds = total;
    });
  }

  void _moveToHistory() {
    if (_entries.isNotEmpty) {
      _history.add({
        'date': DateFormat('yyyy-MM-dd').format(_currentDate),
        'totalSeconds': totalSeconds,
        'entries': List.from(_entries),
      });
      _saveHistory();
    }
    setState(() {
      _entries.clear();
      totalSeconds = 0;
      _currentDate = DateTime.now();
    });
  }

  void _clearAllData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    setState(() {
      _entries.clear();
      _history.clear();
      totalSeconds = 0;
      _currentDate = DateTime.now();
    });
  }

  Future<void> _confirmClearData() async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: const Text('Confirmar Limpeza de Dados'),
          content:
              const Text('Tem certeza que deseja apagar todos os registros?'),
          actions: [
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Confirmar'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      _clearAllData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Time'),
        backgroundColor: const Color(0xFF3F51B5),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever),
            onPressed: _confirmClearData,
            color: const Color.fromARGB(255, 250, 58, 58),
            iconSize: 25,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _toggleButton,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    _isStarted ? Colors.redAccent : const Color(0xFF4CAF50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                _isStarted ? 'Finalizar' : 'Iniciar',
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Registros de hoje',
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                Text(
                  'Total: ${_formatDuration(Duration(seconds: totalSeconds))}',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: _entries.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Início: ${_entries[index]['start']}'),
                          Text('Término: ${_entries[index]['end']}'),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Histórico',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: _history.isEmpty
                    ? const Center(child: Text('Histórico vazio'))
                    : ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount: _history.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text('Data: ${_history[index]['date']}'),
                            subtitle: Text(
                                'Total: ${_formatDuration(Duration(seconds: _history[index]['totalSeconds']))}'),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}
