import 'package:isar/isar.dart';

part 'isar_user.g.dart';

@collection
class IsarUser {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  String firebaseId = '';

  String firstName = '';
  String lastName = '';
  String gender = '';
  String domicile = '';
  String bio = '';
  String? dateOfBirth;
  String? phoneNumber;
  List<String> photoUrls = [];
  double latitude = 0.0;
  double longitude = 0.0;
}
