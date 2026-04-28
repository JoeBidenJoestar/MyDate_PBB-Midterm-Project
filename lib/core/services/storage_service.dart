import 'dart:io';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;

final storageServiceProvider = Provider((ref) => StorageService());

class StorageService {

  Future<String?> uploadProfilePicture(String userId, File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(bytes);
      return base64Image;
    } catch (e) {
      print('Error converting image to base64: $e');
      return null;
    }
  }

  Future<List<String>> uploadMultiplePictures(String userId, List<File> files) async {
    List<String> urls = [];
    for (var file in files) {
      String? url = await uploadProfilePicture(userId, file);
      if (url != null) {
        urls.add(url);
      }
    }
    return urls;
  }
}
