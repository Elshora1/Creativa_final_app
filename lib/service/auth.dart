import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  Auth._();
  static final Auth _instance = Auth._();
  static Auth get instance => _instance;
  final User? user = FirebaseAuth.instance.currentUser;
}
