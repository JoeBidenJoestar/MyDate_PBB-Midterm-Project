import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/firestore_service.dart';
import '../../models/notification_model.dart';
import '../chat/chat_page.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authService = ref.watch(authServiceProvider);
    final user = authService.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Please log in to view notifications.')));
    }

    final firestoreService = ref.watch(firestoreServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<NotificationModel>>(
        stream: firestoreService.getNotifications(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading notifications'));
          }

          final notifications = snapshot.data ?? [];
          
          if (notifications.isEmpty) {
            return const Center(child: Text('No new notifications'));
          }

          return ListView.separated(
            itemCount: notifications.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final notif = notifications[index];
              return _buildNotificationItem(context, ref, notif);
            },
          );
        },
      ),
    );
  }

  Widget _buildNotificationItem(BuildContext context, WidgetRef ref, NotificationModel notif) {
    bool isMessage = notif.type == 'message';
    bool isDateRequest = notif.type == 'date_request'; // keeping for legacy
    bool isMatch = notif.type == 'match';
    bool isLike = notif.type == 'like' || notif.type == 'like_sent';

    return ListTile(
      onTap: isMatch || isMessage ? () {
        // Navigate to Chat page
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatPage(
              matchUserId: notif.senderId,
              matchUserName: notif.senderName,
            ),
          ),
        );
      } : null,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: isMatch ? Colors.amber : (isMessage ? Colors.blueAccent : (isDateRequest ? Colors.pinkAccent : Colors.red[100])),
        child: Icon(
          isMatch ? Icons.star : (isMessage ? Icons.chat_bubble : (isDateRequest ? Icons.calendar_today : Icons.favorite)),
          color: (isMatch || isMessage || isDateRequest) ? Colors.white : Colors.red,
        ),
      ),
      title: Text(
        isMessage ? '${notif.senderName} sent you a message:' : notif.message, 
        style: TextStyle(fontWeight: (isMessage || isMatch) ? FontWeight.bold : FontWeight.w600)
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMessage) ...[
            const SizedBox(height: 4),
            Text(
              '"${notif.message}"',
              style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.white),
            ),
          ],
          if (isMatch) ...[
            const SizedBox(height: 4),
            const Text(
              'Tap to chat!',
              style: TextStyle(fontSize: 14, color: Colors.amber, fontWeight: FontWeight.bold),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            _formatDate(notif.createdAt),
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
          if (isDateRequest && notif.status == 'pending') ...[
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    ref.read(firestoreServiceProvider).updateNotificationStatus(notif.id, 'accepted');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(80, 32),
                  ),
                  child: const Text('Accept'),
                ),
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () {
                    ref.read(firestoreServiceProvider).updateNotificationStatus(notif.id, 'rejected');
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.red,
                    minimumSize: const Size(80, 32),
                  ),
                  child: const Text('Reject'),
                ),
              ],
            )
          ] else if (isDateRequest && notif.status != 'pending') ...[
            const SizedBox(height: 8),
            Text(
              'Status: ${notif.status.toUpperCase()}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: notif.status == 'accepted' ? Colors.green : Colors.red,
              ),
            ),
          ]
        ],
      ),
      isThreeLine: isMessage || isDateRequest || isMatch,
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
