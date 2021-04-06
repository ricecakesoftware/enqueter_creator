import 'package:enqueter_creator/data/models/user_profile.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final Provider<UserProfile> userProfileProvider = Provider<UserProfile>((_) => UserProfile());
