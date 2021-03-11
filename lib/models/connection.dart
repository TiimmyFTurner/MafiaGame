class Connection {
  final int id, userId;
  final String type, value;

  Connection({
    this.id,
    this.userId,
    this.type,
    this.value,
  });

  factory Connection.fromJson(Map<String, dynamic> json) => Connection(
        id: json['id'],
        userId: json['user_id'],
        type: json['type'],
        value: json['value'],
      );
}
