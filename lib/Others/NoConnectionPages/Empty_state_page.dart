import 'package:auto_size_text/auto_size_text.dart';
import '../constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyPage extends StatelessWidget {
  final int selectedIndex;
  final VoidCallback onTap;

  EmptyPage({Key key, this.selectedIndex, this.onTap}) : super(key: key);

  Widget build(BuildContext context) {
    final List<Map<String, String>> page = [
      {
        "text": AppLocalizations.of(context).emptyCart, //"Sebediňiz boş",
        "description": AppLocalizations.of(context).descEmptyCart, //"Sargyt etmek üçin sebediňize haryt goşuň",
        "buttonText": "",
        "image": "assets/images/emptyState/NoItemsCart.png",
      },
      {
        "text": AppLocalizations.of(context).cartText, //"Sebet",
        "description": AppLocalizations.of(context).cartDesc, //"Sebediňize haryt goşmak üçin ulgama giriň",
        "buttonText": AppLocalizations.of(context).login, //"Ulgama girmek",
        "image": "assets/images/emptyState/NoItemsCart.png",
      },
      {
        "text": AppLocalizations.of(context).favoritespagetitle, //"Halanlarym",
        "description": AppLocalizations.of(context).favoriteDesc, //"Harytlary halananlaryňyza goşmak üçin ulgama giriň",
        "buttonText": AppLocalizations.of(context).login, //"Ulgama girmek",
        "image": "assets/images/emptyState/NoItemsCart.png",
      },
      {
        "text": AppLocalizations.of(context).favEmpty, //"Halanlaryňyz boş!",
        "description": AppLocalizations.of(context).favDescription, //"Harytlary soň görmek üçin halanlaryňyza goşuň",
        "buttonText": "",
        "image": "assets/images/emptyState/Done.png",
      },
      {
        "text": AppLocalizations.of(context).noresult, //"Haryt tapylmady!",
        "description": AppLocalizations.of(context).noresultDesc, //"Şu wagtlykça şu kategoriýada harytlar ýok",
        "buttonText": "",
        "image": "assets/images/emptyState/NoDocuments.png",
      },
      {
        "text": AppLocalizations.of(context).nopruduct, // "Haryt ýok",
        "description": AppLocalizations.of(context).noProductDesc, //"Hiç hili haryt tapylmady",
        "buttonText": "",
        "image": "assets/images/emptyState/NoDocuments.png",
      },
      {
        "text": AppLocalizations.of(context).myorders, //"Sargytlarym",
        "description": AppLocalizations.of(context).orderDesc, //"Sargyt etmek üçin ulgama giriň we sebediňize haryt goşuň",
        "buttonText": AppLocalizations.of(context).login, //"Ulgama girmek",
        "image": "assets/images/emptyState/NoItemsCart.png",
      },
    ];

    return Center(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(height: 100),
            Image.asset(
              page[selectedIndex]["image"],
            ),
            Column(
              children: [
                AutoSizeText(page[selectedIndex]["text"],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    presetFontSizes: [22, 20, 18, 16, 14, 12, 10, 8],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold)),
                AutoSizeText(page[selectedIndex]["description"],
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    presetFontSizes: [18, 16, 14, 12, 10, 8],
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.grey[400], fontFamily: popPinsRegular)),
              ],
            ),
            page[selectedIndex]["buttonText"].length > 1
                ? RaisedButton(
                    onPressed: onTap,
                    shape: RoundedRectangleBorder(borderRadius: borderRadius10),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    elevation: 1.0,
                    disabledColor: kPrimaryColor_1,
                    color: kPrimaryColor_1,
                    hoverColor: kPrimaryColor_1,
                    child: AutoSizeText(page[selectedIndex]["buttonText"],
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        presetFontSizes: [22, 20, 18, 16, 14, 12, 10, 8],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: kPrimaryColor, fontFamily: popPinsMedium)),
                  )
                : SizedBox.shrink(),
            SizedBox(height: 100),
          ],
        ),
      ),
    ));
  }
}
