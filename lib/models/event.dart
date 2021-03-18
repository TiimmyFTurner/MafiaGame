class Event {
  final int id, userId;
  final String title, description, locatioan;
  final DateTime date;
  final bool status;

  Event(
      {this.id,
      this.userId,
      this.title,
      this.description,
      this.locatioan,
      this.date,
      this.status});

  factory Event.fromJson(Map<String, dynamic> json) => Event(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      locatioan: json['location'],
      date: DateTime.parse(json['date']),
      status: json['status'] != 0);
}
