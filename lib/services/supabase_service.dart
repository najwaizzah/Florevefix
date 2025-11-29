import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:io';
import 'dart:typed_data';


class SupabaseService extends GetxService {
  final SupabaseClient client = Supabase.instance.client;

  // LOGIN
  Future<AuthResponse> login(String email, String password) {
    return client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  // REGISTER
  Future<AuthResponse> register(String email, String password) {
    return client.auth.signUp(
      email: email,
      password: password,
    );
  }

  // LOGOUT
  Future<void> logout() async {
    await client.auth.signOut();
  }

  // FETCH BOUQUETS
  Future<List<Map<String, dynamic>>> getBouquets() async {
    final res = await client
        .from('bouquets')
        .select()
        .order('created_at', ascending: false);
    return List<Map<String, dynamic>>.from(res);
  }

  // UPLOAD IMAGE
  Future<String> uploadBouquetImage(File file, String fileName) async {
    final storage = Supabase.instance.client.storage.from('bouquet-images');

    final uploaded = await storage.upload(fileName, file);

    return storage.getPublicUrl(fileName);
  }
}
