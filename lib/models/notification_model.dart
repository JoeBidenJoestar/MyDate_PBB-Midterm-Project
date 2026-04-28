class NotificationModel {
  final String id;
  final String receiverId;
  final String senderId;
  final String senderName;
  final String type; // 'like', 'date_request', 'system'
  final String message;
  final String status; // 'pending', 'accepted', 'rejected'
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.receiverId,
    required this.senderId,
    required this.senderName,
    required this.type,
    required this.message,
    required this.status,
    required this.createdAt,
  });

  factory NotificationModel.fromMap(Map<String, dynamic> data, String id) {
    return NotificationModel(
      id: id,
      receiverId: data['receiverId'] ?? '',
      senderId: data['senderId'] ?? '',
      senderName: data['senderName'] ?? '',
      type: data['type'] ?? '',
      message: data['message'] ?? '',
      status: data['status'] ?? 'pending',
      createdAt: data['createdAt'] != null 
          ? (data['createdAt'] as dynamic).toDate() 
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'receiverId': receiverId,
      'senderId': senderId,
      'senderName': senderName,
      'type': type,
      'message': message,
      'status': status,
      'createdAt': createdAt,
    };
  }
}
