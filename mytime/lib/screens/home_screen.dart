import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mytime/models/entry.dart';
import 'package:mytime/models/history_entry.dart';
import 'package:mytime/widgets/entry_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Entry> _entries = [];
  List<HistoryEntry> _history = [];
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
      // print(prefs.getStringList('history'));
      setState(() {
        _history = prefs.getStringList('history')!.map((item) {
          List<String> parts = item.split(';');
          return HistoryEntry(
            date: parts[0],
            totalSeconds: int.parse(parts[1]),
            entries: parts[2]
                .split('|')
                .map((entry) => Entry.fromString(entry))
                .toList(),
          );
        }).toList();
      });
    }
  }

  void _saveHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> historyList = _history.map((entry) {
      String entriesString = entry.entries.map((e) => e.toString()).join('|');
      return '${entry.date};${entry.totalSeconds};$entriesString';
    }).toList();
    prefs.setStringList('history', historyList);
  }

  void _loadEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('entries')) {
      setState(() {
        _entries = prefs
            .getStringList('entries')!
            .map((item) => Entry.fromString(item))
            .toList();
        if (_entries.last.start == _entries.last.end) {
          _entries.removeLast();
        }
        _calculateTotalSeconds();
      });
    }
  }

  void _saveEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> entriesList =
        _entries.map((entry) => entry.toString()).toList();
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
        _entries[_entries.length - 1].end = endTime;
        _isStarted = false;
        _calculateTotalSeconds();
        _saveEntries();
      });
    } else {
      _startTime = DateFormat('kk:mm:ss').format(DateTime.now());
      setState(() {
        _entries.add(Entry(start: _startTime!, end: _startTime!));
        _isStarted = true;
        _saveEntries();
      });
    }
  }

  void _finalizeLastEntryIfNeeded() {
    if (_isStarted && _entries.isNotEmpty && _entries.last.end.isEmpty) {
      String endTime = DateFormat('kk:mm:ss').format(DateTime.now());
      setState(() {
        _entries[_entries.length - 1].end = endTime;
        _isStarted = false;
        _calculateTotalSeconds();
      });
    }
  }

  void _calculateTotalSeconds() {
    int total = 0; // Inicializa uma variável para armazenar o total de segundos

    for (var entry in _entries) {
      String? start = entry.start;
      String? end = entry.end;

      // Converte as strings de início e fim em objetos DateTime
      DateTime startTime = DateFormat('kk:mm:ss').parse(start);
      DateTime endTime = DateFormat('kk:mm:ss').parse(end);
      // Calcula a diferença entre o tempo de início e fim
      Duration difference = endTime.difference(startTime);
      // Adiciona a diferença em segundos ao total
      total += difference.inSeconds;
    }

    // Atualiza o estado para armazenar o total de segundos calculado
    setState(() {
      totalSeconds = total;
    });
  }

  void _moveToHistory() {
    if (_entries.isNotEmpty) {
      _history.add(HistoryEntry(
        date: DateFormat('yyyy-MM-dd').format(_currentDate),
        totalSeconds: totalSeconds,
        entries: List.from(_entries),
      ));
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
        title: const Text('My Time', style: TextStyle(color: Colors.white)),
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
                style: const TextStyle(color: Colors.white, fontSize: 18),
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
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: EntryList(entries: _entries),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Histórico',
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
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
                            title: Text(
                              'Data: ${_history[index].date}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            subtitle: Text(
                              'Total: ${_formatDuration(Duration(seconds: _history[index].totalSeconds))}',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
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
