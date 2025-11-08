// lib/repositories/profile_repository.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:klubradio_archivum/models/user_profile.dart';
import 'package:klubradio_archivum/utils/device_id.dart';

class ProfileRepository {
  static const _kProfile = 'user_profile.json';

  Future<UserProfile> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_kProfile);
    if (raw == null) {
      final id = await AppIdentity.getAppId();
      final profile = UserProfile.initial(id);
      await save(profile);
      return profile;
    }
    try {
      return UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (_) {
      final id = await AppIdentity.getAppId();
      final profile = UserProfile.initial(id);
      await save(profile);
      return profile;
    }
  }

  Future<void> save(UserProfile profile) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kProfile, jsonEncode(profile.toJson()));
  }
}
