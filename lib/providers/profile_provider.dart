import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/profile.dart';

part 'profile_provider.g.dart';

@riverpod
class ProfileController extends _$ProfileController {
  SupabaseClient get _db => Supabase.instance.client;

  @override
  Future<Profile?> build() async {
    final userId = _db.auth.currentUser?.id;
    if (userId == null) return null;
    final data = await _db
        .from('profiles')
        .select()
        .eq('id', userId)
        .maybeSingle();
    if (data == null) return null;
    return Profile(
      id: data['id'] as String,
      nickname: data['nickname'] as String?,
      name: data['name'] as String?,
      avatarUrl: data['avatar_url'] as String?,
    );
  }

  Future<void> updateProfile({String? nickname, String? name}) async {
    final userId = _db.auth.currentUser?.id;
    if (userId == null) return;
    await _db.from('profiles').upsert({
      'id': userId,
      if (nickname != null) 'nickname': nickname,
      if (name != null) 'name': name,
      'updated_at': DateTime.now().toIso8601String(),
    });
    ref.invalidateSelf();
  }
}
