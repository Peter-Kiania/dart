import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:flutter/cupertino.dart';

class DataRepository {
  static String? loginName;
  static EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
  static Future<void> loadData(TextEditingController fn, TextEditingController ln,
      TextEditingController ph, TextEditingController em) async {
    fn.text = await prefs.getString('fname');
    ln.text = await prefs.getString('lname');
    ph.text = await prefs.getString('phone');
    em.text = await prefs.getString('email');
  }
  static Future<void> saveData(String key,String value ) async {
    await prefs.setString(key, value);
  }
}