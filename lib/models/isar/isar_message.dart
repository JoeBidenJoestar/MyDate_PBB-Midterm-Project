import 'package:isar/isar.dart';
import 'isar_match.dart';

part 'isar_message.g.dart';

@collection
class IsarMessage {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String firebaseMessageId = '';

  String text = '';
  int timestamp = 0;
  String senderId = '';

  // Flag for offline-first tracking
  @Index()
  bool isSynced = false;

  final match = IsarLink<IsarMatch>();
}
