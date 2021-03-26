import 'package:enqueter_creator/data/models/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  static final _instance = UserProfile._internal();
  User? user = null;
  Profile? profile = null;

  UserProfile._internal();

  factory UserProfile() => _instance;
}
