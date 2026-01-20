import 'package:supabase_flutter/supabase_flutter.dart';

// Cấu hình Supabase
class SupabaseConfig {
  // Thay thế bằng URL và Anon Key của project Supabase của bạn
  static const String supabaseUrl = 'https://vxsmndiicspkrwbvdlvu.supabase.co';
  static const String supabaseAnonKey = 'sb_publishable_Lm1kO5bRu-Qr06Qyzv7kpA_xbBJJ9P3';
}

// Service để khởi tạo và quản lý kết nối Supabase (Singleton pattern)
class SupabaseService {
  static SupabaseService? _instance;
  
  SupabaseService._();
  
  static SupabaseService get instance {
    _instance ??= SupabaseService._();
    return _instance!;
  }

  SupabaseClient get client => Supabase.instance.client;

  // Khởi tạo Supabase
  static Future<void> initialize() async {
    await Supabase.initialize(
      url: SupabaseConfig.supabaseUrl,
      anonKey: SupabaseConfig.supabaseAnonKey,
    );
  }

  // Kiểm tra kết nối với Supabase
  Future<bool> testConnection() async {
    try {
      final session = client.auth.currentSession;
      print('Supabase connected successfully!');
      print('Session: ${session != null ? "Active" : "No active session"}');
      return true;
    } catch (e) {
      print('Supabase connection error: $e');
      return false;
    }
  }
}
