import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<FirebaseAuth> authProvider = Provider<FirebaseAuth>((_) => FirebaseAuth.instance);
