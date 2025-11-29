import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'dart:typed_data';

class SupabaseService extends GetxService {
  final SupabaseClient client = Supabase.instance.client;

  // LOGIN
  Future<AuthResponse> login(String email, String password) {
    return client.auth.signInWithPassword(email: email, password: password);
  }

  // REGISTER
  Future<AuthResponse> register(String email, String password) {
    return client.auth.signUp(email: email, password: password);
  }

  // LOGOUT
  Future<void> logout() async {
    await client.auth.signOut();
  }

  // FETCH ALL BOUQUETS
  Future<List<Map<String, dynamic>>> getBouquets() async {
    final res = await client
        .from('bouquets')
        .select()
        .order('created_at', ascending: false);

    return List<Map<String, dynamic>>.from(res);
  }

  // GET SINGLE BOUQUET
  Future<Map<String, dynamic>?> getBouquetById(int id) async {
    final res = await client
        .from('bouquets')
        .select()
        .eq('id', id)
        .maybeSingle();

    return res;
  }

  // UPDATE BOUQUET
  Future<void> updateBouquet(int id, Map<String, dynamic> data) async {
    await client.from('bouquets').update(data).eq('id', id);
  }

  // DELETE BOUQUET
  Future<void> deleteBouquet(int id) async {
    await client.from('bouquets').delete().eq('id', id);
  }

  // UPLOAD IMAGE (FILE)
  Future<String> uploadBouquetImage(File file, String fileName) async {
    final storage = client.storage.from('bouquet-images');

    await storage.upload(fileName, file);

    return storage.getPublicUrl(fileName);
  }

  // UPLOAD IMAGE (BYTES) — recommended for mobile
  Future<String> uploadBouquetImageBytes(
    Uint8List bytes,
    String fileName,
  ) async {
    final storage = client.storage.from('bouquet-images');

    await storage.uploadBinary(
      fileName,
      bytes,
      fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
    );

    return storage.getPublicUrl(fileName);
  }
}
