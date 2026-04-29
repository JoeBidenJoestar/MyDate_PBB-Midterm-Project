import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/firestore_service.dart';
import '../../core/services/isar_service.dart';
import '../../models/isar/isar_message.dart';

class ChatPage extends ConsumerStatefulWidget {
  final String matchUserId;
  final String matchUserName;

  const ChatPage({
    super.key,
    required this.matchUserId,
    required this.matchUserName,
  });

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final TextEditingController _msgCtrl = TextEditingController();
  late String _chatRoomId = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final currentUserId = ref.read(authServiceProvider).currentUser?.uid ?? '';
      _chatRoomId = ref.read(firestoreServiceProvider).getChatRoomId(currentUserId, widget.matchUserId);
      ref.read(isarServiceProvider).hydrateChatRoom(_chatRoomId);
      setState(() {});
    });
  }

  void _sendMessage() {
    if (_msgCtrl.text.trim().isEmpty) return;

    final currentUser = ref.read(authServiceProvider).currentUser;
    if (currentUser == null) return;

    // Save locally to Isar first (Offline-first approach)
    ref.read(isarServiceProvider).saveLocalMessage(
      _chatRoomId,
      currentUser.uid,
      _msgCtrl.text.trim(),
    );
    
    // We also trigger the old push notification logic if needed
    ref.read(firestoreServiceProvider).sendMessage(
      currentUser.uid,
      widget.matchUserId,
      _msgCtrl.text.trim(),
      'Current User',
    );

    _msgCtrl.clear();
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = ref.watch(authServiceProvider).currentUser?.uid ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with ${widget.matchUserName}'),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: _chatRoomId.isEmpty 
              ? const Center(child: CircularProgressIndicator())
              : StreamBuilder<List<IsarMessage>>(
              stream: ref.watch(isarServiceProvider).watchMessages(_chatRoomId),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                
                final messages = snapshot.data!;

                return ListView.builder(
                  reverse: true,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final msg = messages[index];
                    final isMe = msg.senderId == currentUserId;

                    return Align(
                      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (isMe && !msg.isSynced)
                            const Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Icon(Icons.access_time, size: 12, color: Colors.grey),
                            ),
                          Container(
                            margin: EdgeInsets.only(
                              bottom: 8,
                              right: isMe ? 0 : 40,
                              left: isMe ? 40 : 0,
                            ),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: isMe 
                                ? const LinearGradient(
                                    colors: [Colors.pinkAccent, Colors.purpleAccent],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  )
                                : null,
                              color: isMe ? null : Colors.grey[800],
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(16),
                                topRight: const Radius.circular(16),
                                bottomLeft: Radius.circular(isMe ? 16 : 0),
                                bottomRight: Radius.circular(isMe ? 0 : 16),
                              ),
                            ),
                            child: Text(
                              msg.text,
                              style: const TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _msgCtrl,
                    decoration: const InputDecoration(
                      hintText: 'Type a message...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  backgroundColor: Colors.pinkAccent,
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white, size: 20),
                    onPressed: _sendMessage,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
