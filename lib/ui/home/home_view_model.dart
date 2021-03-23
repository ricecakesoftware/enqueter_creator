import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<HomeViewModel> signInViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel(ref));

class HomeViewModel extends ChangeNotifier {
  ProviderReference _ref;

  HomeViewModel(this._ref);
}
