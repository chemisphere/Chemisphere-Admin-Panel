import '../../../utils/constants/enums.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../utils/formatters/formatter.dart';

/// MODEL CLASS REPRESENTING USER DATA
class AdminModel {
  final String? id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;

  /// CONSTRUCTOR FOR USERMODEL
  AdminModel({
    this.id,
    required this.email,
    this.firstName = '',
    this.lastName = '',
    this.userName = '',
    this.phoneNumber = '',
    this.profilePicture = '',
    this.role = AppRole.user,
    this.createdAt,
    this.updatedAt
  });

  /// HELPER METHODS
  String get fullName => "$firstName $lastName";

  String get formattedDate => TFormatter.formatDate(createdAt);

  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);

  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  /// STATIC FUNCTION TO CREATE AN EMPTY USER MODEL
  static AdminModel empty() => AdminModel(email: '');

  /// SERIALIZATION METHODS
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt,
    };
  }

  /// FACTORY METHOD TO CREATE USERMODEL FROM JSON OR SNAPSHOT
  factory AdminModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data()!;
      return AdminModel(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        userName: data.containsKey('UserName') ? data['UserName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        phoneNumber: data.containsKey('PhoneNumber')
            ? data['PhoneNumber'] ?? ''
            : '',
        profilePicture: data.containsKey('ProfilePicture')
            ? data['ProfilePicture'] ?? ''
            : '',
        role: data.containsKey("Role")
            ? (data['Role'] ?? AppRole.user) == AppRole.admin.name.toString()
            ? AppRole.admin
            : AppRole.user
            : AppRole.user,
        createdAt: data.containsKey('CreatedAt') ? data['CreatedAt']
            ?.toDate() ?? DateTime.now() : DateTime.now(),
        updatedAt: data.containsKey('UpdatedAt') ? data['UpdatedAt']
            ?.toDate() ?? DateTime.now() : DateTime.now(),
      );
    }
    else {
      return empty();
    }
  }
}