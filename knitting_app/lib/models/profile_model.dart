import 'package:flutter/material.dart';

class ProfileModel extends ChangeNotifier {
  final String id;
  String firstName;
  String lastName;
  String phone;
  DateTime createdAt;

  ProfileModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.createdAt,
  });

  /// JSON / Map → Model
  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    return ProfileModel(
      id: map['id'],
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      phone: map['phone'] ?? '',
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  /// Model → JSON / Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'ProfileModel{id: $id, firstName: $firstName, lastName: $lastName}';
  }
}
