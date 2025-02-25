class Entry {
  final String? id;
  final String firebaseId;
  final String title;
  final String date;

  Entry(
      {this.id,
      required this.firebaseId,
      required this.title,
      required this.date});

  Map<String, dynamic> toJson() {
    return {
      'id': id ?? "<filledAtRead>",
      'firebaseId': firebaseId,
      'title': title,
      'date': date
    };
  }

  factory Entry.fromJson(Map<String, dynamic> json, String id) {
    return Entry(
      id: id,
      firebaseId: json['firebaseId'],
      title: json['title'],
      date: json['date'],
    );
  }
}
