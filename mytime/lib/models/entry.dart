class Entry {
  String start;
  String end;

  Entry({required this.start, required this.end});

  @override
  String toString() {
    return '$start:$end';
  }

  static Entry fromString(String string) {
    List<String> parts = string.split(':');
    return Entry(
      start: parts[0],
      end: parts[1],
    );
  }
}
