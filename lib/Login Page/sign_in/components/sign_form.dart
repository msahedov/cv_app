import 'package:e_commerce_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../Others/Models/common.dart';
import '../../../Others/constants/constants.dart';
import '../../../Others/constants/widgets.dart';
import 'custom_suffix_icon.dart';
import 'default_button.dart';

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  FocusNode focusNode;
  TextEditingController _phoneController = new TextEditingController(), _passwordController = new TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    _phoneController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    focusNode.dispose();
  }

  void nextField(String value, FocusNode focusNode) {
    if (value.length == 8) {
      focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Material(
          elevation: 3,
          borderRadius: borderRadius,
          child: Container(
            padding: symmetricPadding,
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: borderRadius, color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/icons/logo.jpg",
                  height: 100,
                  width: 200,
                ),
                sizedBox,
                Text(
                  AppLocalizations.of(context).signIncontext,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: popPinsRegular,
                    color: Colors.grey[500],
                  ),
                ),
                sizedBox,
                phoneFormField,
                sizedBox,
                passwordFormField,
                SizedBox(
                  height: 60,
                ),
                DefaultButton(
                  text: AppLocalizations.of(context).signInBtnName,
                  press: () async {
                    if (_formKey.currentState.validate()) {
                      UserModel().loginUser(phoneNumber: _phoneController.text, password: _passwordController.text).then((user) {
                        if (user != null) {
                          Auth().login(name: user.name, uid: user.id, phone: user.phoneNumber);
                          RestartWidget.restartApp(context);
                        } else {
                          ScaffoldMessenger.of(context)
                            ..removeCurrentSnackBar()
                            ..showSnackBar(SnackBar(content: Text("Telefon belgi ýa-da açar söziniň nädogry", style: TextStyle(fontFamily: popPinsRegular, fontSize: 13))));
                          _formKey.currentState.reset();
                        }
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  TextFormField get phoneFormField => TextFormField(
        controller: _phoneController,
        inputFormatters: [
          new LengthLimitingTextInputFormatter(8),
        ],
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        onChanged: (value) {
          nextField(value, focusNode);
        },
        validator: (value) {
          if (value.isEmpty) {
            return AppLocalizations.of(context).kPhoneNullError;
          } else if (!emailValidatorRegExp.hasMatch(value)) {
            return AppLocalizations.of(context).kInvalidPhoneError;
          }
          return null;
        },
        style: style,
        decoration: InputDecoration(
          errorStyle: errorTextStyle,
          contentPadding: textFieldPadding,
          border: outlineInputBorder(),
          focusedBorder: focusBorder(),
          labelText: AppLocalizations.of(context).lblPhoneNumber,
          labelStyle: labelStyle,
          hintText: "6x xx xx xx",
          hintStyle: hintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
        ),
      );

  TextFormField get passwordFormField => TextFormField(
        focusNode: focusNode,
        controller: _passwordController,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        inputFormatters: [
          new LengthLimitingTextInputFormatter(6),
        ],
        obscureText: true,
        onChanged: (value) {
          if (value.length == 6) {
            focusNode.unfocus();
          }
        },
        validator: (value) {
          if (value.isEmpty) {
            return AppLocalizations.of(context).kPassNullError;
          } else if (value.length < 6) {
            return AppLocalizations.of(context).kShortPassError;
          }
          return null;
        },
        style: style,
        decoration: InputDecoration(
          errorStyle: errorTextStyle,
          contentPadding: textFieldPadding,
          focusedBorder: focusBorder(),
          border: outlineInputBorder(),
          labelText: AppLocalizations.of(context).lblPassword, //"Açar söz",
          hintStyle: hintStyle,
          hintText: AppLocalizations.of(context).hintPassword, //"Açar söziňiz",
          labelStyle: labelStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      );
}
