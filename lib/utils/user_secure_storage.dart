// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _email = 'email';
  static const _name = 'name';
  static const _matricno = 'matricno';

  static const _level = 'level';
  static const _school = 'school';
  static const _accessKey = 'accesskey';

  static Future setName(String name) async =>
      await _storage.write(key: _name, value: name);

  static Future<String?> getName() async => await _storage.read(key: _name);
  static Future setEmail(String email) async =>
      await _storage.write(key: _email, value: email);

  static Future<String?> getEmail() async => await _storage.read(key: _email);

  static Future setLevel(String level) async =>
      await _storage.write(key: _name, value: level);

  static Future<String?> getLevel() async => await _storage.read(key: _level);

  static Future setMatricno(String matricno) async {
    await _storage.write(key: _matricno, value: matricno);
  }

  static Future<String?> getSchool() async => await _storage.read(key: _school);
  static Future setSchool(String school) async {
    await _storage.write(key: _matricno, value: school);
  }

  static Future<String?> getMatricno() async =>
      await _storage.read(key: _matricno);

  static Future setAccessKey(String accesskey) async {
    await _storage.write(key: _accessKey, value: accesskey);
  }

  static Future<String?> getAccessKey() async =>
      await _storage.read(key: _accessKey);

  static Future<void> clearUserData() async {
    await _storage.delete(key: _email);
    await _storage.delete(key: _name);

    await _storage.delete(key: _matricno);

    await _storage.delete(key: _school);

    await _storage.delete(key: _level);
    await _storage.delete(key: _accessKey);
  }
}
