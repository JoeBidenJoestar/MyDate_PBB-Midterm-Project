import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/isar/isar_user.dart';
import '../../models/isar/isar_match.dart';
import '../../models/isar/isar_message.dart';

final isarServiceProvider = Provider<IsarService>((ref) {
  return IsarService();
});

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openDB();
    _listenToConnectivity();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [IsarUserSchema, IsarMatchSchema, IsarMessageSchema],
        directory: dir.path,
        inspector: true,
      );
    }
    return Future.value(Isar.getInstance());
  }

  void _listenToConnectivity() {
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if (!results.contains(ConnectivityResult.none)) {
        _syncPendingMessagesToFirebase();
      }
    });
  }

  Future<void> _syncPendingMessagesToFirebase() async {
    final isar = await db;
    final unsyncedMessages = await isar.isarMessages.filter().isSyncedEqualTo(false).findAll();
    
    if (unsyncedMessages.isEmpty) return;

    for (var msg in unsyncedMessages) {
       await msg.match.load(); // Ensure the match is loaded to get the ID
       if (msg.match.value != null) {
          final matchId = msg.match.value!.matchId;
          
          try {
             await FirebaseFirestore.instance
               .collection('chats')
               .doc(matchId)
               .collection('messages')
               .doc(msg.firebaseMessageId)
               .set({
                 'senderId': msg.senderId,
                 'message': msg.text,
                 'createdAt': FieldValue.serverTimestamp(),
               }, SetOptions(merge: true));
               
             await isar.writeTxn(() async {
                msg.isSynced = true;
                await isar.isarMessages.put(msg);
             });
          } catch(e) {
             print("Error syncing message: $e");
          }
       }
    }
  }

  Future<void> hydrateChatRoom(String matchId) async {
     final isar = await db;
     
     var match = await isar.isarMatchs.filter().matchIdEqualTo(matchId).findFirst();
     if (match == null) {
       match = IsarMatch()..matchId = matchId;
       await isar.writeTxn(() async {
          await isar.isarMatchs.put(match!);
       });
     }

     FirebaseFirestore.instance
        .collection('chats')
        .doc(matchId)
        .collection('messages')
        .snapshots()
        .listen((snapshot) async {
            await isar.writeTxn(() async {
               for (var doc in snapshot.docs) {
                  final data = doc.data();
                  var isarMsg = await isar.isarMessages.filter().firebaseMessageIdEqualTo(doc.id).findFirst();
                  
                  if (isarMsg == null) {
                     isarMsg = IsarMessage()
                        ..firebaseMessageId = doc.id
                        ..text = data['message'] ?? ''
                        ..senderId = data['senderId'] ?? ''
                        ..timestamp = data['createdAt'] != null ? (data['createdAt'] as Timestamp).millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch
                        ..isSynced = true;
                     
                     await isar.isarMessages.put(isarMsg);
                     isarMsg.match.value = match;
                     await isarMsg.match.save();
                  }
               }
            });
        });
  }

  Future<void> saveLocalMessage(String matchId, String senderId, String text) async {
     final isar = await db;
     
     var match = await isar.isarMatchs.filter().matchIdEqualTo(matchId).findFirst();
     if (match == null) {
        match = IsarMatch()..matchId = matchId;
        await isar.writeTxn(() async {
           await isar.isarMatchs.put(match!);
        });
     }

     final newMessage = IsarMessage()
        ..firebaseMessageId = FirebaseFirestore.instance.collection('chats').doc(matchId).collection('messages').doc().id
        ..text = text
        ..senderId = senderId
        ..timestamp = DateTime.now().millisecondsSinceEpoch
        ..isSynced = false;

     await isar.writeTxn(() async {
        await isar.isarMessages.put(newMessage);
        newMessage.match.value = match;
        await newMessage.match.save();
     });
     
     _syncPendingMessagesToFirebase();
  }

  Stream<List<IsarMessage>> watchMessages(String matchId) async* {
     final isar = await db;
     yield* isar.isarMessages.filter().match((q) => q.matchIdEqualTo(matchId)).sortByTimestampDesc().watch(fireImmediately: true);
  }
}
