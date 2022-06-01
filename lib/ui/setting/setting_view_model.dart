import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final settingViewModelProvider =
    ChangeNotifierProvider((ref) => SettingViewModel(ref.read));

class SettingViewModel extends ChangeNotifier {

  SettingViewModel(this._reader);

  final Reader _reader;

}
