import 'dart:convert';
import 'dart:io';
import 'package:e_commerce_app/Others/NoConnectionPages/NoConnection.dart';
import 'package:e_commerce_app/Others/NoConnectionPages/dataError.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../Login%20Page/sign_in/components/default_button.dart';
import '../../Others/Models/common.dart';
import '../../Others/constants/constants.dart';
import '../../Others/constants/sizeconfig.dart';
import '../../Others/constants/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import '../../BottomNavBar.dart';
import 'package:http/http.dart' as http;

class UserPage extends StatefulWidget {
  final String title;

  const UserPage({@required this.title});
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> with TickerProviderStateMixin {
  bool isEdit = false;
  TextEditingController _nameController = new TextEditingController(), _oldpassController = new TextEditingController(), _newpassController = new TextEditingController();
  final GlobalKey<FormState> _passdialogFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _image;
  AnimationController anmController;
  Animation<double> fadeAnm;

  void dispose() {
    anmController.dispose();
    _nameController?.dispose();
    super.dispose();
  }

  void initState() {
    super.initState();
    _nameController = new TextEditingController();
    anmController = AnimationController(vsync: this, duration: Duration(milliseconds: 500), reverseDuration: Duration(milliseconds: 500));
    fadeAnm = Tween<double>(begin: 0.0, end: 1.0).animate(anmController);
  }

  Future getImage(ImageSource source) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker.platform.pickImage(source: source);
    if (pickedFile != null) {
      try {
        setState(() {
          _image = File(pickedFile.path);
        });
      } catch (Exception) {
        throw Exception(AppLocalizations.of(context).changePhotoNotSucces);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          AppLocalizations.of(context).changePhotoNotSucces,
          style: TextStyle(fontFamily: popPinsRegular, color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
        ),
        action: SnackBarAction(label: 'OK', onPressed: () {}),
      ));
    }
  }

  final errorTextStyle = TextStyle(fontFamily: popPinsRegular);
  @override
  Widget build(BuildContext context) {
    final TextStyle _style = TextStyle(color: Colors.grey[500], fontFamily: popPinsRegular);
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: primaryAppBar(actions: [
          IconButton(
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 500),
                child: Icon(
                  isEdit ? Icons.clear : Icons.edit_outlined,
                  size: 25,
                  color: kPrimaryColor_1,
                ),
              ),
              onPressed: () {
                setState(() {
                  isEdit = !isEdit;
                  if (isEdit)
                    anmController.forward();
                  else
                    anmController.reverse();
                });
              }),
        ], title: widget.title, context: context),
        body: FutureBuilder<UserModel>(
            future: UserModel.getMe,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError)
                  return NoDataErrorPage(
                    onTap: () {
                      setState(() {});
                    },
                  );
                else if (snapshot.hasData) {
                  return SizedBox(
                    height: SizeConfig.screenHeight,
                    width: SizeConfig.screenWidth,
                    child: SingleChildScrollView(
                      child: AnimatedSize(
                        reverseDuration: Duration(milliseconds: 500),
                        duration: Duration(milliseconds: 500),
                        vsync: this,
                        child: Container(
                          padding: symmetricPadding,
                          decoration: BoxDecoration(border: Border.fromBorderSide(BorderSide.none), color: Colors.white, borderRadius: borderRadius),
                          margin: symmetricPadding,
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(60),
                                    child: CircleAvatar(
                                      radius: 60,
                                      child: snapshot.data.image == null
                                          ? Container(
                                              width: 50,
                                              height: 50,
                                              child: SvgPicture.asset(
                                                "assets/icons/user.svg",
                                                color: Colors.grey,
                                              ),
                                            )
                                          : Image.network("$serverUrl${snapshot.data.image}", fit: BoxFit.contain),
                                      backgroundColor: Color(0xFFF5F6F9),
                                    ),
                                  ),
                                  isEdit
                                      ? Positioned(
                                          right: 0,
                                          bottom: 0,
                                          child: InkWell(
                                            onTap: () => primaryDialog(actions: [
                                              TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context).closeBtn, style: buttonTextStyle)),
                                            ], content: [
                                              DefaultButton(
                                                  text: AppLocalizations.of(context).cameraBtn,
                                                  press: () {
                                                    getImage(ImageSource.camera);
                                                  }),
                                              SizedBox(height: 10),
                                              DefaultButton(
                                                  text: AppLocalizations.of(context).galleryBtn,
                                                  press: () {
                                                    getImage(ImageSource.gallery);
                                                  }),
                                            ], title: AppLocalizations.of(context).titleSelect),
                                            child: FadeTransition(
                                              opacity: fadeAnm,
                                              child: CircleAvatar(
                                                radius: 20,
                                                child: SvgPicture.asset('assets/icons/Camera Icon.svg', color: kPrimaryColor),
                                                backgroundColor: Colors.indigo,
                                              ),
                                            ),
                                          ))
                                      : SizedBox(),
                                ],
                              ),
                              TextFormField(
                                initialValue: snapshot.data.name,
                                style: buttonTextStyle,
                                enabled: false,
                                decoration: InputDecoration(labelText: AppLocalizations.of(context).lblName, labelStyle: _style),
                              ),
                              TextFormField(
                                initialValue: "+993 ${snapshot.data.phoneNumber}",
                                style: buttonTextStyle,
                                enabled: false,
                                decoration: InputDecoration(labelText: AppLocalizations.of(context).lblPhoneNum, labelStyle: _style),
                              ),
                              isEdit
                                  ? Align(
                                      alignment: Alignment.centerRight,
                                      // ignore: deprecated_member_use
                                      child: FlatButton(
                                          child: Text(
                                            AppLocalizations.of(context).changePassBtn,
                                            style: _style,
                                          ),
                                          onPressed: () {
                                            _oldpassController.clear();
                                            _newpassController.clear();
                                            primaryDialog(
                                              content: [
                                                TextFormField(
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  controller: _oldpassController,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(6),
                                                  ],
                                                  validator: (value) {
                                                    if (value.isEmpty) return AppLocalizations.of(context).valcurrentpass; //"Häzirki açar söziňizi giriziň";
                                                    return null;
                                                  },
                                                  style: buttonTextStyle,
                                                  enabled: true,
                                                  obscureText: true,
                                                  obscuringCharacter: '*',
                                                  decoration: InputDecoration(labelText: AppLocalizations.of(context).lblCurrentPass, labelStyle: _style, errorStyle: errorTextStyle),
                                                ),
                                                TextFormField(
                                                  controller: _newpassController,
                                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                                  inputFormatters: [
                                                    LengthLimitingTextInputFormatter(6),
                                                  ],
                                                  validator: (value) {
                                                    if (value.isEmpty) return AppLocalizations.of(context).valnewpass;
                                                    return null;
                                                  },
                                                  style: buttonTextStyle,
                                                  enabled: true,
                                                  obscureText: true,
                                                  obscuringCharacter: '*',
                                                  decoration: InputDecoration(labelText: AppLocalizations.of(context).lblNewPass, labelStyle: _style, errorStyle: errorTextStyle),
                                                ),
                                              ],
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      if (_passdialogFormKey.currentState.validate()) {
                                                        UserModel().changePassword(newPassword: _newpassController.text, oldPassword: _oldpassController.text).then((isSucces) {
                                                          if (isSucces) {
                                                            UserModel().loginUser(phoneNumber: snapshot.data.phoneNumber, password: _newpassController.text).then((value) {
                                                              if (value != null) {
                                                                Auth().login(name: value.name, uid: value.id, phone: value.phoneNumber);
                                                                Navigator.pop(context);
                                                                Future.delayed(Duration(milliseconds: 500), () {
                                                                  _scaffoldKey.currentState.setState(() {});
                                                                  showMessage(AppLocalizations.of(context).changePassSnakPos, context);
                                                                });
                                                              }
                                                            });
                                                          } else {
                                                            Navigator.pop(context);
                                                            Future.delayed(Duration(milliseconds: 500), () {
                                                              showMessage(AppLocalizations.of(context).changePassSnakNeg, context);
                                                            });
                                                          }
                                                        });
                                                      }
                                                    },
                                                    child: Text(AppLocalizations.of(context).changePassPos, style: buttonTextStyle)),
                                                TextButton(onPressed: () => Navigator.pop(context), child: Text(AppLocalizations.of(context).closeBtn, style: buttonTextStyle)),
                                              ],
                                              title: AppLocalizations.of(context).changePassBtn,
                                            );
                                          }))
                                  : SizedBox(),
                              isEdit
                                  ? Padding(
                                      padding: symmetricPadding,
                                      child: FadeTransition(
                                        opacity: fadeAnm,
                                        child: DefaultButton(
                                          text: AppLocalizations.of(context).changePassPos,
                                          press: () {
                                            UserModel().changeMe(name: _nameController.text, photo: _image).then((_user) {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  content: Text(AppLocalizations.of(context).nameAndPhotoSucces, style: TextStyle(fontFamily: popPinsRegular, fontSize: 13)),
                                                  action: SnackBarAction(
                                                    label: "OK",
                                                    onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                                                  )));
                                            }).onError((error, stackTrace) {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                  content: Text(AppLocalizations.of(context).nameAndPhotoNotSucces, style: TextStyle(fontFamily: popPinsRegular, fontSize: 13)),
                                                  action: SnackBarAction(
                                                    label: "OK",
                                                    onPressed: () => ScaffoldMessenger.of(context).removeCurrentSnackBar(),
                                                  )));
                                            });
                                          },
                                        ),
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
              } else if (snapshot.connectionState == ConnectionState.none) {
                return NoConnnectionPage();
              }

              return SpinKitChasingDots(color: kPrimaryColor_1);
            }),
      ),
    );
  }

  primaryDialog({
    List<Widget> actions,
    List<Widget> content,
    String title,
  }) {
    showGeneralDialog(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                scrollable: true,
                shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: borderRadius),
                title: Text(
                  title,
                  style: buttonTextStyle,
                ),
                content: Form(
                  key: _passdialogFormKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: content,
                  ),
                ),
                actions: actions,
              ),
            ),
          );
        },
        transitionDuration: kAnimationDuration,
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, __, ___) {});
  }
}
