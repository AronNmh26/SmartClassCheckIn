import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/check_in.dart';
import '../models/check_out.dart';

class StorageService {
  static const _checkInsKey = 'check_ins';
  static const _checkOutsKey = 'check_outs';

  Future<void> saveCheckIn(CheckIn checkIn) async {
    final list = await _readList(_checkInsKey);
    list.add(checkIn.toJson());
    await _writeList(_checkInsKey, list);
  }

  Future<void> saveCheckOut(CheckOut checkOut) async {
    final list = await _readList(_checkOutsKey);
    list.add(checkOut.toJson());
    await _writeList(_checkOutsKey, list);
  }

  Future<int> getCheckInCount() async {
    final list = await _readList(_checkInsKey);
    return list.length;
  }

  Future<int> getCheckOutCount() async {
    final list = await _readList(_checkOutsKey);
    return list.length;
  }

  Future<List<Map<String, dynamic>>> _readList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw != null && raw.isNotEmpty) {
      final decoded = jsonDecode(raw);
      if (decoded is List) {
        return decoded.cast<Map<String, dynamic>>();
      }
    }

    final legacy = prefs.getStringList(key);
    if (legacy != null && legacy.isNotEmpty) {
      final migrated = legacy
          .map((item) => jsonDecode(item) as Map<String, dynamic>)
          .toList();
      await _writeList(key, migrated);
      return migrated;
    }

    return <Map<String, dynamic>>[];
  }

  Future<void> _writeList(String key, List<Map<String, dynamic>> list) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(list));
  }
}
