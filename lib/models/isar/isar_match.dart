import 'package:isar/isar.dart';
import 'isar_user.dart';
import 'isar_message.dart';

part 'isar_match.g.dart';

@collection
class IsarMatch {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String matchId = ''; 

  final matchedUser = IsarLink<IsarUser>();

  @Backlink(to: 'match')
  final messages = IsarLinks<IsarMessage>();
}
