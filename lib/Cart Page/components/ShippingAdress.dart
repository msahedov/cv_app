import 'package:auto_size_text/auto_size_text.dart';
import 'package:e_commerce_app/Others/Models/common.dart';
import 'package:e_commerce_app/Profile%20Page/screens/OrdersPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Others/constants/constants.dart';
import '../../Others/constants/widgets.dart';

class ShippingAdress extends StatefulWidget {
  const ShippingAdress({Key key, this.bahasy, @required this.userId}) : super(key: key);

  final String bahasy;
  final int userId;

  _ShippingAdressState createState() => _ShippingAdressState();
}

class _ShippingAdressState extends State<ShippingAdress> {
  var group = AutoSizeGroup();
  TextEditingController textController = TextEditingController(), _addressController = new TextEditingController();
  final _formKEy = GlobalKey<FormState>();
  int _groupValue = 0;
  String _paymentMethod = "inCash";
  bool _ussaGerek = false;

  Widget ussaGerek() {
    return Column(
      children: [
        TextFormField(
          textAlign: TextAlign.start,
          keyboardType: TextInputType.text,
          style: TextStyle(fontSize: 16, fontFamily: popPinsMedium),
          textCapitalization: TextCapitalization.sentences,
          minLines: 2,
          maxLines: 3,
          validator: (value) {
            if (value.isEmpty && _ussaGerek) return AppLocalizations.of(context).valUssaGerek; //"Gerekli ussaň görnüşini we sebäbini giriziň";
            return null;
          },
          decoration: InputDecoration(
            errorStyle: TextStyle(fontFamily: popPinsRegular),
            hintText: AppLocalizations.of(context).hintussa, //'Ussaň görnüşini we sebäbini yazyň',
            labelText: AppLocalizations.of(context).ussa, //'Ussa',
            labelStyle: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
            hintStyle: TextStyle(fontSize: 16, fontFamily: popPinsMedium),
            border: OutlineInputBorder(
              borderRadius: borderRadius15,
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: borderRadius15,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
              borderRadius: borderRadius15,
            ),
            filled: true,
            contentPadding: EdgeInsets.all(16),
            fillColor: Colors.grey.shade50,
          ),
        ),

        // Padding(
        //   padding: const EdgeInsets.symmetric(vertical: 20),
        //   child: TextFormField(
        //     textAlign: TextAlign.start,
        //     keyboardType: TextInputType.text,
        //     style: TextStyle(fontSize: 16, fontFamily: popPinsMedium),
        //     textCapitalization: TextCapitalization.sentences,
        //     minLines: 1,
        //     maxLines: 1,
        //     validator: (value) {
        //       if (value.isEmpty && _ussaGerek) return "Gerekli ussaň görnüşini we sebäbini giriziň";
        //       return null;
        //     },
        //     decoration: InputDecoration(
        //       errorStyle: TextStyle(fontFamily: popPinsRegular),
        //       hintText: 'Telefon Belgiňiz',
        //       labelText: 'Telefon belgi',
        //       labelStyle: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
        //       hintStyle: TextStyle(fontSize: 16, fontFamily: popPinsMedium),
        //       border: OutlineInputBorder(
        //         borderRadius: borderRadius15,
        //         borderSide: BorderSide(
        //           width: 0,
        //           style: BorderStyle.none,
        //         ),
        //       ),
        //       focusedBorder: OutlineInputBorder(
        //         borderSide: BorderSide(color: Colors.white),
        //         borderRadius: borderRadius15,
        //       ),
        //       enabledBorder: UnderlineInputBorder(
        //         borderSide: BorderSide(color: Colors.white),
        //         borderRadius: borderRadius15,
        //       ),
        //       filled: true,
        //       contentPadding: EdgeInsets.all(16),
        //       fillColor: Colors.grey.shade50,
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade50,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(left: 10, top: 8, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: customButton(
                        image: 'assets/icons/arrow_small_left.svg',
                        color: kPrimaryColor_1,
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    AutoSizeText(
                      AppLocalizations.of(context).ordering, //'Sargyt Etmek',
                      overflow: TextOverflow.ellipsis,
                      stepGranularity: 2,
                      textAlign: TextAlign.center,
                      presetFontSizes: [22, 20, 18, 16, 14],
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: popPinsSemiBold,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                    )
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 70),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 10, left: 10),
                          child: Form(
                            key: _formKEy,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextFormField(
                                  controller: _addressController,
                                  validator: (input) {
                                    if (input.isEmpty) return AppLocalizations.of(context).inputAddress; //'Salgyňyzy giriziň';
                                    return null;
                                  },
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.text,
                                  maxLines: 3,
                                  minLines: 3,
                                  style: TextStyle(fontSize: 16, fontFamily: popPinsMedium),
                                  textCapitalization: TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    errorStyle: TextStyle(fontFamily: popPinsMedium),
                                    hintText: AppLocalizations.of(context).hintAddress, //'Sargydy eltmeli salgyňyzy giriziň.\nMeselem: Aşgabat şäheriniň Ata türk köçesi 52-nji jaý',
                                    labelText: AppLocalizations.of(context).yourAddress, //'Salgyňyz',
                                    labelStyle: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
                                    hintStyle: TextStyle(fontSize: 16, fontFamily: popPinsMedium),
                                    border: OutlineInputBorder(
                                      borderRadius: borderRadius15,
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: borderRadius15,
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red[300]),
                                      borderRadius: borderRadius15,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: borderRadius15,
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(16),
                                    fillColor: Colors.grey.shade50,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  textAlign: TextAlign.start,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(fontSize: 16, fontFamily: popPinsMedium),
                                  textCapitalization: TextCapitalization.sentences,
                                  decoration: InputDecoration(
                                    hintText: '',
                                    labelText: AppLocalizations.of(context).zametka, //'Bellik',
                                    labelStyle: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
                                    hintStyle: TextStyle(fontSize: 16, fontFamily: popPinsMedium),
                                    border: OutlineInputBorder(
                                      borderRadius: borderRadius15,
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: borderRadius15,
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Colors.white),
                                      borderRadius: borderRadius15,
                                    ),
                                    filled: true,
                                    contentPadding: EdgeInsets.all(16),
                                    fillColor: Colors.grey.shade50,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                        value: _ussaGerek,
                                        onChanged: (value) {
                                          setState(() {
                                            _ussaGerek = value;
                                          });
                                        }),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          _ussaGerek = !_ussaGerek;
                                        });
                                      },
                                      child: AutoSizeText(
                                        AppLocalizations.of(context).ussa_gerek, //'Ussa gerek',
                                        maxLines: 1,
                                        group: group,
                                        presetFontSizes: [18, 16, 14, 12, 10, 8],
                                        style: TextStyle(
                                          color: kPrimaryColor_1,
                                          fontFamily: popPinsSemiBold,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                _ussaGerek ? ussaGerek() : SizedBox.shrink(),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          AppLocalizations.of(context).payment, //"Töleg görnüşi",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          presetFontSizes: [20, 18, 16, 14, 12, 10, 8, 6],
                          style: TextStyle(color: Colors.black, fontFamily: popPinsSemiBold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _myRadioButton(
                          title: AppLocalizations.of(context).inCash, //"Nagt",
                          subtitle: AppLocalizations.of(context).inCashDesc, //"Sargydy alan wagtyňyz tölemek nagt pul görnüşinde hasaplaşmak",
                          value: 0,
                          onChanged: (newValue) => setState(() {
                            _groupValue = newValue;
                            _paymentMethod = "inCash";
                          }),
                        ),
                        _myRadioButton(
                          title: AppLocalizations.of(context).byTerminal, //"Bank karty",
                          subtitle: AppLocalizations.of(context).byTerminalDesc, //"Sargydy alan wagtyňyz töleg terminalyndan kart arkaly hasaplaşmak",
                          value: 1,
                          onChanged: (newValue) => setState(() {
                            _groupValue = newValue;
                            _paymentMethod = "byTerminal";
                          }),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 35, left: 20, right: 20),
                    child: Column(
                      children: [
                        AutoSizeText(
                          "\u2022  ${AppLocalizations.of(context).desc1}", // '\u2022  Hormatly müşderi sargydy barlap alanyňyzdan soňra töleg amala aşyrylýar. Eltip berijiniň size gowşurýan töleg resminamasynda siziň tölemeli puluňyz bellenendir. Töleg nagt we nagt däl görnüşde milli manatda amala aşyrylýar. Kabul edip tölegini geçiren harydyňyz yzyna alynmaýar;',
                          style: TextStyle(color: Colors.black45, fontSize: 16, fontFamily: popPinsRegular),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AutoSizeText(
                          "\u2022  ${AppLocalizations.of(context).desc2}", //'\u2022 Eltip bermek hyzmaty Aşgabat şäheriniň çägi bilen bir hatarda Büzmeýine we Änew şäherine hem elýeterlidir. Hyzmat mugt amala aşyrylýar;',
                          style: TextStyle(color: Colors.black45, fontSize: 16, fontFamily: popPinsRegular),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                  ),
                ],
              ),
            ),
          ),
          buildAlign()
        ],
      ),
    ));
  }

  Widget buildAlign() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 15),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  AppLocalizations.of(context).total, //'Jemi töleg:',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  presetFontSizes: [16, 15, 14, 13, 12, 11, 10],
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black54, fontFamily: popPinsSemiBold),
                ),
                RichText(
                  overflow: TextOverflow.ellipsis,
                  text: new TextSpan(
                    text: '${widget.bahasy} ',
                    style: TextStyle(color: kPrimaryColor_1, fontSize: 23, fontFamily: popPinsSemiBold),
                    children: <TextSpan>[
                      new TextSpan(
                        text: 'TMT ',
                        style: TextStyle(color: kPrimaryColor_1, fontSize: 15, fontFamily: popPinsSemiBold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    if (_formKEy.currentState.validate()) {
                      _formKEy.currentState.save();
                      Order().createOrder(userId: widget.userId, shippingAddress: _addressController.text, paymentMethod: _paymentMethod).then((value) {
                        if (value) {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context).taskOrderAdd, style: TextStyle(fontFamily: popPinsRegular, fontSize: 15, color: kPrimaryColor)),
                                backgroundColor: kPrimaryColor_1,
                                action: SnackBarAction(
                                  textColor: kPrimaryColor,
                                  label: "OK",
                                  onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                                )));
                          Future.delayed(Duration(milliseconds: 300), () {
                            Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => OrdersPage(title: AppLocalizations.of(context).myorders)));
                          });
                        } else {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(
                                content: Text(AppLocalizations.of(context).notOrdering, style: TextStyle(fontFamily: popPinsRegular, fontSize: 15, color: kPrimaryColor)),
                                backgroundColor: kPrimaryColor_1,
                                action: SnackBarAction(
                                  textColor: kPrimaryColor,
                                  label: "OK",
                                  onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                                )));
                        }
                      });
                    }
                  });
                },
                shape: RoundedRectangleBorder(borderRadius: borderRadius15),
                color: kPrimaryColor,
                child: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: AutoSizeText(
                    AppLocalizations.of(context).orderconfirm, //'Tassyklamak',
                    maxLines: 1,
                    presetFontSizes: [22, 21, 20, 18, 16, 14, 12, 10, 8],
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kPrimaryColor_1, fontFamily: popPinsSemiBold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _myRadioButton({String title, String subtitle, int value, Function onChanged}) {
    return RadioListTile(
      activeColor: kPrimaryColor,
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: AutoSizeText(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        presetFontSizes: [
          18,
          16,
          14,
          12,
          10,
          8,
        ],
        style: TextStyle(color: Colors.black, fontFamily: popPinsMedium),
      ),
      subtitle: AutoSizeText(
        subtitle,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
        presetFontSizes: [15, 13, 11, 9, 7],
        style: TextStyle(color: Colors.black54, fontFamily: popPinsRegular),
      ),
    );
  }
}
