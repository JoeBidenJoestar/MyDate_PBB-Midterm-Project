class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String gender;
  final String domicile;
  final String bio;
  final String? dateOfBirth;
  final String? phoneNumber;
  final List<String> photoUrls;
  final double latitude;
  final double longitude;

  int? get age {
    if (dateOfBirth == null || dateOfBirth!.isEmpty) return null;
    try {
      final dob = DateTime.parse(dateOfBirth!);
      final today = DateTime.now();
      int calculatedAge = today.year - dob.year;
      if (today.month < dob.month || (today.month == dob.month && today.day < dob.day)) {
        calculatedAge--;
      }
      return calculatedAge;
    } catch (e) {
      return null;
    }
  }

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.domicile,
    required this.bio,
    this.dateOfBirth,
    this.phoneNumber,
    required this.photoUrls,
    required this.latitude,
    required this.longitude,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      id: id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      gender: data['gender'] ?? '',
      domicile: data['domicile'] ?? '',
      bio: data['bio'] ?? '',
      dateOfBirth: data['dateOfBirth'],
      phoneNumber: data['phoneNumber'],
      photoUrls: List<String>.from(data['photoUrls'] ?? []),
      latitude: (data['latitude'] ?? 0.0).toDouble(),
      longitude: (data['longitude'] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'domicile': domicile,
      'bio': bio,
      'dateOfBirth': dateOfBirth,
      'phoneNumber': phoneNumber,
      'photoUrls': photoUrls,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
