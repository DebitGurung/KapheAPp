import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

//constructor to initialize the fields
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

//helper function to get full name
  String get fullName => '$firstName $lastName';

  //helper function to get formatted phone number
  String get formattedPhoneNumber => '+977 $phoneNumber';

  //static method to split full name into first and last name
  static List<String> nameParts(String fullName) => fullName.split(" ");

//static method to generate username from full name
  static String generateUserName(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : "";

    String camelCaseUserName =
        "$firstName $lastName"; //combine first and last name
    String usernameWithPrefix = "cwt_$camelCaseUserName"; //add "cwt_" prefix

    return usernameWithPrefix;
  }

  static UserModel empty() => UserModel(
        id: 'guest123',
        firstName: 'Guest',
        lastName: 'User',
        userName: 'guest_user',
        email: 'guest@example.com',
        phoneNumber: '',
        profilePicture: '',
      );

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data(); // Get data once
    if (data != null) {
      return UserModel(
        id: document.id,
        firstName: data['FirstName'] ?? '',
        lastName: data['LastName'] ?? '',
        userName: data['UserName'] ?? '',
        email: data['Email'] ?? '',
        phoneNumber: data['PhoneNumber'] ?? '',
        profilePicture: data['ProfilePicture'] ?? '',
      );
    } else {
      return UserModel.empty();
    }
  }
}
