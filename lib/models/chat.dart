class Chat {
    String sender;
    String reciever;
    String message;
    DateTime time;
    bool isRead;

    Chat({
        required this.sender,
        required this.reciever,
        required this.message,
        required this.time,
        required this.isRead,
    });

    factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        sender: json["sender"],
        reciever: json["reciever"],
        message: json["message"],
        time: DateTime.parse(json["time"]),
        isRead: json["isRead"],
    );

    Map<String, dynamic> toJson() => {
        "sender": sender,
        "reciever": reciever,
        "message": message,
        "time": time.toIso8601String(),
        "isRead": isRead,
    };
}
