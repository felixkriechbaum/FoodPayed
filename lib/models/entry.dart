class Entry {
  final String id;
  final String firebaseId;
  final String title;
  final DateTime date;

  Entry(
      {required this.id,
      required this.firebaseId,
      required this.title,
      required this.date});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firebaseId': firebaseId,
      'title': title,
      'date': date.toIso8601String()
    };
  }

  factory Entry.fromJson(Map<String, dynamic> json) {
    return Entry(
      id: json['id'],
      firebaseId: json['firebaseId'],
      title: json['title'],
      date: DateTime.parse(json['date']),
    );
  }
}
