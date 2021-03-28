import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ChangeNotifierProvider<HomeViewModel> homeViewModelProvider = ChangeNotifierProvider((ref) => HomeViewModel(ref));

class HomeViewModel extends ChangeNotifier {
  ProviderReference _ref;

  HomeViewModel(this._ref);
}
