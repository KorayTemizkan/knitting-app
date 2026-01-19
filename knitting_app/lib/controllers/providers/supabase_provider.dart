import 'dart:io';
import 'package:flutter/material.dart';
import 'package:knitting_app/models/profile_model.dart';
import 'package:path/path.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:knitting_app/controllers/providers/shared_preferences_provider.dart';

class SupabaseProvider extends ChangeNotifier {
  final SupabaseClient supabase = Supabase.instance.client;
  late SharedPreferencesProvider sharedPreferencesProvider;

  SupabaseProvider({required this.sharedPreferencesProvider});

  List<ProfileModel> _profiles = [];
  List<ProfileModel> get profiles => _profiles;

  List<Map<String, dynamic>> posts = [];
  bool _internetConnectionController = false;
  bool get internetConnectionController => _internetConnectionController;

  // AUTH FONKSİYONLARI

  Future<bool> signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      final Session? session = res.session;
      final User? user = res.user;

      fetchProfile();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> signInUser({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      final Session? session = res.session;
      final User? user = res.user;

      fetchProfile();

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<void> updateUser({
    required String email,
    required String password,
  }) async {
    final UserResponse res = await supabase.auth.updateUser(
      UserAttributes(email: email, password: password),
    );
  }

  Future<void> signOutUser() async {
    await supabase.auth.signOut();
  }

  Future<void> listen() async {
    final authSubscription = supabase.auth.onAuthStateChange.listen((data) {
      final AuthChangeEvent event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        print('signedIn');
      }
    });
  }

  // PROFİL FONKSİYONLARI

  String imageUrl = '';

  Future<void> uploadPhoto({required File selectedImage}) async {
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}';

    await supabase.storage
        .from('posts-images')
        .upload(
          fileName,
          selectedImage,
          fileOptions: const FileOptions(cacheControl: '3600', upsert: false),
        );
    imageUrl = supabase.storage.from('posts-images').getPublicUrl(fileName);
  }

  Future<void> updateProfile({
    required String firstName,
    required String lastName,
    required String phone,
  }) async {
    final response = await supabase
        .from('profiles')
        .update({
          'first_name': firstName,
          'last_name': lastName,
          'phone': phone,
        })
        .eq('id', supabase.auth.currentUser!.id);

    await sharedPreferencesProvider.setFirstName(firstName);
    await sharedPreferencesProvider.setLastName(lastName);
    await sharedPreferencesProvider.setPhone(phone);
  }

  // DATABASE - POST FONKSİYONLARI

  Future<void> readPosts() async {
    try {
      final data = await supabase.from('posts').select();
      posts = List<Map<String, dynamic>>.from(data);
      _internetConnectionController = true;
      notifyListeners();
    } catch (e) {
    }
  }

  Future<void> insert({required String header, required String content}) async {
    await supabase.from('posts').insert({
      'header': header,
      'content': content,
      'image_url': imageUrl,
    });
  }

  Future<void> update({required String header, required String content}) async {
    await supabase
        .from('posts')
        .update({'header': header, 'content': content})
        .eq('header', header);
  }

  Future<void> delete({required String header}) async {
    await supabase.from('posts').delete().eq('column', header);
  }

  // DATABASE - NOT FONKSİYONLARI

  Future<void> insertNote({required String title, required String note}) async {
    await supabase.from('notes').insert({
      'profile_id': supabase.auth.currentUser!.id,
      'title': title,
      'content': note,
    });
  }

  // DATABASE - PROFİL FONKSİYONLARI

  Future<void> fetchProfile() async {
    final response = await supabase
        .from('profiles')
        .select()
        .eq('id', supabase.auth.currentUser!.id)
        .single();

    await sharedPreferencesProvider.setFirstName(response['first_name'] ?? '');
    await sharedPreferencesProvider.setLastName(response['last_name'] ?? '');
    await sharedPreferencesProvider.setPhone(response['phone'] ?? '');
  }

  Future<void> fetchProfiles() async {
    final response = await supabase.from('profiles').select();

    // Burayı AI ile yaptım yapacak bir şey yok
    _profiles = (response as List).map((e) => ProfileModel.fromMap(e)).toList();
    notifyListeners();
  }
}
