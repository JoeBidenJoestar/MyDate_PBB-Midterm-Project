import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/user_model.dart';
import '../../models/notification_model.dart';

final firestoreServiceProvider = Provider((ref) => FirestoreService());

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserProfile(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  Future<void> updateUserProfile(UserModel user) async {
    await _db.collection('users').doc(user.id).update(user.toMap());
  }

  Future<UserModel?> getUser(String uid) async {
    final doc = await _db.collection('users').doc(uid).get();
    if (doc.exists && doc.data() != null) {
      return UserModel.fromMap(doc.data()!, doc.id);
    }
    return null;
  }

  Future<List<UserModel>> searchBaddies(String city, String oppositeGender, String currentUserId) async {
    // Basic implementation: get all users with opposite gender in the same city.
    // Ideally, we'd also filter out users we've already swiped on.
    final snapshot = await _db.collection('users')
        .where('domicile', isEqualTo: city)
        .where('gender', isEqualTo: oppositeGender)
        .get();

    return snapshot.docs
        .where((doc) => doc.id != currentUserId) // exclude self just in case
        .map((doc) => UserModel.fromMap(doc.data(), doc.id))
        .toList();
  }

  Future<void> sendLike(String currentUserId, String targetUserId, String currentUserName) async {
    // Check if targetUser already liked currentUser
    final existingLikeQuery = await _db.collection('notifications')
        .where('senderId', isEqualTo: targetUserId)
        .where('receiverId', isEqualTo: currentUserId)
        .where('type', isEqualTo: 'like')
        .get();

    if (existingLikeQuery.docs.isNotEmpty) {
      // It's a MATCH!
      // 1. Update the old like status to 'matched'
      final oldLikeDocId = existingLikeQuery.docs.first.id;
      await _db.collection('notifications').doc(oldLikeDocId).update({'status': 'matched'});

      // 2. Create the Match document
      final matchRef = _db.collection('matches').doc();
      await matchRef.set({
        'id': matchRef.id,
        'userIds': [currentUserId, targetUserId],
        'createdAt': FieldValue.serverTimestamp(),
      });

      final targetUser = await getUser(targetUserId);
      final targetUserName = targetUser != null ? '${targetUser.firstName} ${targetUser.lastName}' : 'Someone';

      // 3. Notify BOTH users that they matched
      final notificationRefA = _db.collection('notifications').doc();
      await notificationRefA.set(NotificationModel(
        id: notificationRefA.id,
        receiverId: currentUserId,
        senderId: targetUserId,
        senderName: targetUserName,
        type: 'match',
        message: 'Congrats, you are matched with $targetUserName!',
        status: 'matched',
        createdAt: DateTime.now(),
      ).toMap());

      final notificationRefB = _db.collection('notifications').doc();
      await notificationRefB.set(NotificationModel(
        id: notificationRefB.id,
        receiverId: targetUserId,
        senderId: currentUserId,
        senderName: currentUserName,
        type: 'match',
        message: 'Congrats, you are matched with $currentUserName!',
        status: 'matched',
        createdAt: DateTime.now(),
      ).toMap());

    } else {
      // Regular Like
      final notificationRef = _db.collection('notifications').doc();
      final notification = NotificationModel(
        id: notificationRef.id,
        receiverId: targetUserId,
        senderId: currentUserId,
        senderName: currentUserName,
        type: 'like',
        message: '$currentUserName liked you!',
        status: 'pending',
        createdAt: DateTime.now(),
      );
      await notificationRef.set(notification.toMap());

      // Log for the sender
      final targetUser = await getUser(targetUserId);
      final targetUserName = targetUser != null ? '${targetUser.firstName} ${targetUser.lastName}' : 'Someone';
      
      final senderLogRef = _db.collection('notifications').doc();
      final senderLog = NotificationModel(
        id: senderLogRef.id,
        receiverId: currentUserId,
        senderId: targetUserId,
        senderName: targetUserName,
        type: 'like_sent',
        message: 'You liked $targetUserName!',
        status: 'delivered',
        createdAt: DateTime.now(),
      );
      await senderLogRef.set(senderLog.toMap());
    }
  }

  String getChatRoomId(String user1, String user2) {
    if (user1.compareTo(user2) < 0) {
      return '${user1}_$user2';
    } else {
      return '${user2}_$user1';
    }
  }

  Future<void> sendMessage(String currentUserId, String targetUserId, String messageText, String currentUserName) async {
    final roomId = getChatRoomId(currentUserId, targetUserId);
    
    // Save to dedicated chat room
    await _db.collection('chats').doc(roomId).collection('messages').add({
      'senderId': currentUserId,
      'receiverId': targetUserId,
      'message': messageText,
      'createdAt': FieldValue.serverTimestamp(),
    });

    final currentUser = await getUser(currentUserId);
    final actualUserName = currentUser != null ? '${currentUser.firstName} ${currentUser.lastName}' : currentUserName;

    // Also push a notification so it appears in the bell tab
    final notificationRef = _db.collection('notifications').doc();
    final notification = NotificationModel(
      id: notificationRef.id,
      receiverId: targetUserId,
      senderId: currentUserId,
      senderName: actualUserName,
      type: 'message',
      message: messageText,
      status: 'delivered', 
      createdAt: DateTime.now(),
    );

    await notificationRef.set(notification.toMap());
  }

  Stream<List<NotificationModel>> getNotifications(String userId) {
    return _db.collection('notifications')
        .where('receiverId', isEqualTo: userId)
        .snapshots()
        .map((snapshot) {
          final docs = snapshot.docs
              .map((doc) => NotificationModel.fromMap(doc.data(), doc.id))
              .toList();
          docs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return docs;
        });
  }

  Future<void> updateNotificationStatus(String notificationId, String status) async {
    await _db.collection('notifications').doc(notificationId).update({'status': status});
  }
}
