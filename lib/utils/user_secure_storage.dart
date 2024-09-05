// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserSecureStorage {
  static final _storage = FlutterSecureStorage();

  static const _email = 'email';
  static const _name = 'name';
  static const _matricno = 'matricno';

  static const _level = 'level';
  static const _school = 'school';
  static const _accessKey = 'accesskey';
  static const _latitude = 'latitude';
  static const _longitude = 'longitude';
  static const _currentAddress = 'current-address';

  static const _source = 'source';
  static const _destination = 'destination';
  static const _id = 'id';

  static Future setUserId(String? id) async =>
      await _storage.write(key: _id, value: id);

  static Future<String?> getUserId() async => await _storage.read(key: _id);

  // Methods for source
  static Future setSource(String source) async =>
      await _storage.write(key: _source, value: source);

  static Future<String?> getSource() async => await _storage.read(key: _source);

  // Methods for destination
  static Future setDestination(String destination) async =>
      await _storage.write(key: _destination, value: destination);

  static Future<String?> getDestination() async =>
      await _storage.read(key: _destination);

  // Methods for latitude and longitude
  static Future setLatitude(double latitude) async =>
      await _storage.write(key: _latitude, value: latitude.toString());

  static Future<double?> getLatitude() async {
    final value = await _storage.read(key: _latitude);
    return value != null ? double.parse(value) : null;
  }

  static Future setLongitude(double longitude) async =>
      await _storage.write(key: _longitude, value: longitude.toString());

  static Future<double?> getLongitude() async {
    final value = await _storage.read(key: _longitude);
    return value != null ? double.parse(value) : null;
  }

  // Method to get LatLng
  static Future<LatLng?> getCurrentLatLng() async {
    final lat = await getLatitude();
    final lng = await getLongitude();
    if (lat != null && lng != null) {
      return LatLng(lat, lng);
    }
    return null;
  }

  // Methods for current address
  static Future setCurrentAddress(String address) async =>
      await _storage.write(key: _currentAddress, value: address);

  static Future<String?> getCurrentAddress() async =>
      await _storage.read(key: _currentAddress);

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
