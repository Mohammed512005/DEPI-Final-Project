import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  // ---------------------------
  // Upload User ID Photos
  // ---------------------------
  Future<String> uploadUserIdImage({
    required File image,
    required String userId,
    required bool isFront,
  }) async {
    try {
      final fileName = isFront ? 'front.jpg' : 'back.jpg';
      final path = 'user_ids/$userId/$fileName';

      await _client.storage
          .from('id_images')
          .upload(path, image, fileOptions: FileOptions(upsert: true));

      return _client.storage.from('id_images').getPublicUrl(path);
    } catch (e) {
      throw Exception('Supabase upload failed: $e');
    }
  }

  // ---------------------------
  // Upload Tool Images
  // ---------------------------
  Future<String> uploadToolImage({
    required File image,
    required String toolId,
    required String fileName,
  }) async {
    try {
      final path = 'tools/$toolId/$fileName';

      await _client.storage
          .from('tool_images')
          .upload(path, image, fileOptions: FileOptions(upsert: true));

      return _client.storage.from('tool_images').getPublicUrl(path);
    } catch (e) {
      throw Exception('Supabase tool image upload failed: $e');
    }
  }

  // ---------------------------
  // Delete OLD images if needed
  // ---------------------------
  Future<void> deleteImage({
    required String bucket,
    required String path,
  }) async {
    try {
      await _client.storage.from(bucket).remove([path]);
    } catch (e) {
      throw Exception('Delete failed: $e');
    }
  }
}
