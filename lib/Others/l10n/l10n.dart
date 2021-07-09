import 'package:flutter/material.dart';

class L10n {
  static final all = [
    const Locale('tr'),
    const Locale('ru'),
  ];

  static String getFlag(String code) {
    switch (code) {
      case 'ru':
        return 'Русский';
      case 'tr':
        return 'Türkmen';
      default:
        return 'Türkmen';
    }
  }
}
