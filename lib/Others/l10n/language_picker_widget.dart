import 'package:e_commerce_app/Others/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'l10n.dart';
import 'locale_provider.dart';

class LanguagePickerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      shape: RoundedRectangleBorder(borderRadius: borderRadius10),
      color: Colors.white,
      icon: Icon(
        Icons.language,
        size: 30,
        color: kPrimaryColor_1,
      ),
      onSelected: (locale) {
        final provider = Provider.of<LocaleProvider>(context, listen: false);
        provider.setLocale(Locale(locale));
      },
      tooltip: 'Goşmaça',
      itemBuilder: (BuildContext context) {
        return L10n.all.map((locale) {
          final languageName = L10n.getFlag(locale.languageCode);
          print(languageName);
          return PopupMenuItem<String>(
            value: locale.languageCode,
            textStyle: TextStyle(fontFamily: popPinsSemiBold),
            child: Text(
              languageName,
              style: TextStyle(fontFamily: popPinsSemiBold, color: kPrimaryColor_1),
            ),
          );
        }).toList();
      },
    );
  }
}
