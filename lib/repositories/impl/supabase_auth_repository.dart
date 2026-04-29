import 'package:supabase_flutter/supabase_flutter.dart';

import '../../models/user.dart' as app;
import '../auth_repository.dart';

class SupabaseAuthRepository implements AuthRepository {
  final _auth = Supabase.instance.client.auth;

  @override
  Future<app.User?> getCurrentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return app.User(
      id: user.id,
      name: user.userMetadata?['name'] as String? ?? '',
      email: user.email,
    );
  }

  @override
  Future<app.User> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final res = await _auth.signInWithPassword(
      email: email,
      password: password,
    );
    final user = res.user!;
    return app.User(
      id: user.id,
      name: user.userMetadata?['name'] as String? ?? '',
      email: user.email,
    );
  }

  @override
  Future<app.User> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    final res = await _auth.signUp(
      email: email,
      password: password,
      data: {'name': name},
    );
    final user = res.user!;
    return app.User(id: user.id, name: name, email: user.email);
  }

  @override
  Future<void> signOut() => _auth.signOut();
}
