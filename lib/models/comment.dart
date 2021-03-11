class Comment {
  final int id, userId;
  final String body, date;

  Comment({
    this.id,
    this.userId,
    this.body,
    this.date,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json['id'],
        userId: json['user_id'],
        body: json['body'],
        date: json['created_at'],
      );
}
