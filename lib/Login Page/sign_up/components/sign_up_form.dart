import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:telephony/telephony.dart';
import '../../../Login%20Page/otp/otp_screen.dart';
import '../../../Login%20Page/sign_in/components/custom_suffix_icon.dart';
import '../../../Login%20Page/sign_in/components/default_button.dart';
import '../../../Others/constants/constants.dart';
import '../../../Others/constants/widgets.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  TextEditingController _nameController = new TextEditingController(),
      _phoneController = new TextEditingController(),
      _passwordController = new TextEditingController(),
      _confirmController = new TextEditingController();
  FocusNode fNode1, fNode2, fNode3, fNode4;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  void initState() {
    super.initState();
    fNode1 = FocusNode();
    fNode2 = FocusNode();
    fNode3 = FocusNode();
    fNode4 = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    fNode1?.dispose();
    fNode2?.dispose();
    fNode3?.dispose();
    fNode4?.dispose();
  }

  final textFieldPadding = EdgeInsets.only(left: 30);
  final TextStyle labelStyle = TextStyle(fontFamily: popPinsRegular, color: kPrimaryColor);
  final TextStyle hintStyle = TextStyle(fontFamily: popPinsRegular, fontSize: 15);
  final TextStyle style = TextStyle(fontFamily: popPinsRegular, fontSize: 15, color: kPrimaryColor_1);
  final sizedBox = SizedBox(height: 20);
  final errorTextStyle = TextStyle(fontFamily: popPinsRegular);

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
            decoration: BoxDecoration(color: Colors.white, borderRadius: borderRadius),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Image.asset(
                    "assets/icons/logo.jpg",
                    height: 100,
                    width: 200,
                  ),
                  sizedBox,
                  sizedBox,
                  nameFormField,
                  sizedBox,
                  phoneFormField,
                  sizedBox,
                  passwordFormField,
                  sizedBox,
                  DefaultButton(
                    text: AppLocalizations.of(context).signUpBtnName,
                    press: () {
                      if (_formKey.currentState.validate()) {
                        //Telephony.instance.sendSms(to: "+99362990344", message: ".");
                        return Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => OtpScreen(
                                      password: _passwordController.text,
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                    )));
                      } else {
                        _formKey.currentState.validate();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  TextFormField get nameFormField => TextFormField(
        controller: _nameController,
        focusNode: fNode1,
        validator: (value) {
          if (value.isEmpty) return AppLocalizations.of(context).kNamelNullError;
          return null;
        },
        onEditingComplete: () => fNode1.nextFocus(),
        style: style,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: textFieldPadding,
          border: outlineInputBorder(),
          focusedBorder: focusBorder(),
          labelText: AppLocalizations.of(context).lblName, //"Ady",
          labelStyle: labelStyle,
          focusColor: Colors.green,
          hintStyle: hintStyle,
          errorStyle: errorTextStyle,
          hintText: AppLocalizations.of(context).hintNameSignUp, //"Adyňyz",
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/user.svg"),
        ),
      );
  TextFormField get phoneFormField => TextFormField(
        focusNode: fNode2,
        controller: _phoneController,
        keyboardType: TextInputType.phone,
        validator: (value) {
          if (value.isEmpty)
            return AppLocalizations.of(context).kPhoneNullError;
          else if (!emailValidatorRegExp.hasMatch(value)) return AppLocalizations.of(context).kInvalidPhoneError;
          return null;
        },
        inputFormatters: [
          new LengthLimitingTextInputFormatter(8),
        ],
        onEditingComplete: () => fNode2.nextFocus(),
        textInputAction: TextInputAction.next,
        style: style,
        decoration: InputDecoration(
          errorStyle: errorTextStyle,
          contentPadding: textFieldPadding,

          labelText: AppLocalizations.of(context).lblPhoneNumber, //"Telefon belgi",
          border: outlineInputBorder(),
          focusedBorder: focusBorder(),
          labelStyle: labelStyle,
          hintText: "6x xx xx xx",
          hintStyle: hintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Call.svg"),
        ),
      );

  TextFormField get passwordFormField => TextFormField(
        textInputAction: TextInputAction.next,
        obscureText: true,
        onEditingComplete: () => fNode3.nextFocus(),
        inputFormatters: [
          new LengthLimitingTextInputFormatter(6),
        ],
        controller: _passwordController,
        focusNode: fNode3,
        validator: (value) {
          if (value.isEmpty)
            return AppLocalizations.of(context).kPassNullError;
          else if (value.length < 6) return AppLocalizations.of(context).kShortPassError;
          return null;
        },
        style: style,
        decoration: InputDecoration(
          errorStyle: errorTextStyle,
          contentPadding: textFieldPadding,
          border: outlineInputBorder(),
          focusedBorder: focusBorder(),
          labelText: AppLocalizations.of(context).lblPassword, //"Açar söz",
          hintText: AppLocalizations.of(context).hintPassword, //"Açar söziňiz",
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      );
  TextFormField get conformPassFormField => TextFormField(
        focusNode: fNode4,
        controller: _confirmController,
        textInputAction: TextInputAction.done,
        obscureText: true,
        inputFormatters: [
          new LengthLimitingTextInputFormatter(6),
        ],
        onEditingComplete: () => fNode4.unfocus(),
        validator: (value) {
          if (value.isEmpty)
            return AppLocalizations.of(context).kPassNullError;
          else if (_passwordController.text != value) return AppLocalizations.of(context).kMatchPassError;

          return null;
        },
        style: style,
        decoration: InputDecoration(
          errorStyle: errorTextStyle,
          contentPadding: textFieldPadding,
          border: outlineInputBorder(),
          focusedBorder: focusBorder(),
          labelText: AppLocalizations.of(context).lblConfirmPass,
          hintText: AppLocalizations.of(context).hintConfirmPass,
          labelStyle: labelStyle,
          hintStyle: hintStyle,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
        ),
      );
}
