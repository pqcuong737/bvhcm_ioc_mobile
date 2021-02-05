import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:mobile/src/app/pages/login_screen/login_view.dart';
import 'package:mobile/src/app/pages/register_screen/register_controller.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/register.dart';
import 'package:mobile/src/domain/repositories/register/register_repository.dart';
import 'package:mobile/src/utility/APIProvider.dart';
import 'package:mobile/src/utility/DialogUtilities.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';

class RegisterScreen extends View {
  RegisterScreen({Key key}) : super(key: key);

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState
    extends ViewState<RegisterScreen, RegisterScreenController> {
  RegisterScreenState() : super(RegisterScreenController(RegisterRepository()));
  Size _size;
  bool isInternetConnected = false;
  bool isCheckRegisterButton = false;
  String username = '';
  String password = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.context = context;
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage(ImagePath.background),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          child: SingleChildScrollView(
              child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(
                          _size.width / 10,
                          _size.height / 10,
                          _size.width / 10,
                          _size.height / 4),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          _buildHeader(),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          )),
        )
      ],
    ));
  }

  Widget _buildHeader() {
    _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            ImagePath.logo,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
              child: Text(
            'CÔNG TY BẢO VIỆT TP HỒ CHÍ MINH',
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            'BAOVIET HCM IOC',
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  20, _size.width / 7, 20, _size.width / 10),
              child: Text(Strings.register_text,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22))),
          Container(
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(8.0)),
              border: new Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            child: new TextField(
              controller: controller.textNameListener,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
//                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.person),
                hintText: Strings.name_text,
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              border: new Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            child: new TextField(
              controller: controller.textEmailListener,
//              onChanged: (value) {
//                setState((){
//                  controller.myEmailListener.text = value;
//                });
//              },
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
//                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.email),
                hintText: Strings.email_text,
                border: InputBorder.none,
              ),
            ),
          ),

          Container(
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
            ),
            child: new TextField(
              controller: controller.textPasswordListener,
//              onChanged: (value) {
//                print("Password $value");
//                setState((){
//                  controller.myPasswordListener.text = value;
//                });
//              },
              obscureText: true,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
//                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.lock),
                hintText: Strings.pass_word,
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            decoration: new BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0)),
              border: new Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            child: new TextField(
              controller: controller.textConfirmPasswordListener,
//              onChanged: (value) {
//                print("Password $value");
//                setState((){
//                  controller.myPasswordListener.text = value;
//                });
//              },
              obscureText: true,
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
//                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.lock),
                hintText: Strings.confirm_password,
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            width: _size.width,
            decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: FlatButton(
              textColor: Colors.white,
              child: Text(
                Strings.REGISTER_TEXT,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                if (controller.textNameListener.text == null ||
                    controller.textNameListener.text.isEmpty ||
                    controller.textEmailListener.text == null ||
                    controller.textEmailListener.text.isEmpty ||
                    controller.textPasswordListener.text == null ||
                    controller.textPasswordListener.text.isEmpty ||
                    controller.textConfirmPasswordListener.text == null ||
                    controller.textConfirmPasswordListener.text.isEmpty) {
                  DialogUtilities.showSimpleDialog(
                      context,
                      Strings.register_text,
                      Strings.field_is_empty,
                      Strings.OK_TEXT,
                      () {});
                } else if (controller.textConfirmPasswordListener.text !=
                    controller.textPasswordListener.text) {
                  DialogUtilities.showSimpleDialog(
                      context,
                      Strings.register_text,
                      Strings.CONFIRM_PASSWORD_NOT_MATCH,
                      Strings.OK_TEXT,
                      () {});
                } else {
                  showLoadingDialog(tapDismiss: false);
                  controller.registerUser(
                    controller.textNameListener.text,
                    controller.textEmailListener.text,
                    controller.textPasswordListener.text,
                    controller.textConfirmPasswordListener.text,
                  );
                  isCheckRegisterButton = true;
                }
              },
            ),
          ),
          // already account
          Container(
            padding: EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () {
                NavigatorUtilities.pushAndRemoveUntil(context, LoginScreen());
              },
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: Strings.already_have_account,
                      style: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 15),
                    ),
                    TextSpan(
                      text: Strings.login_text,
                      style: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              // Container(
              //   padding: EdgeInsets.only(top: 35),
              //   child: GestureDetector(
              //     onTap: () {
              //       DialogUtilities.showSimpleDialog2Button(
              //         context,
              //         Strings.forgot_pass_word,
              //         Strings.email_or_pass_is_empty,
              //         Strings.OK_TEXT,
              //         (email) {},
              //         Strings.cancel_text,
              //       );
              //     },
              //     child: Text(Strings.forgot_pass_word,
              //         textAlign: TextAlign.left,
              //         style: Theme.of(context).textTheme.subhead.copyWith(
              //             color: Colors.white,
              //             fontWeight: FontWeight.normal,
              //             decoration: TextDecoration.underline,
              //             fontSize: 15)),
              //   ),
              // ),
//               Container(
//                 padding: EdgeInsets.only(top: 35),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Theme(
//                       data: Theme.of(context).copyWith(
//                         unselectedWidgetColor: Colors.white,
//                       ),
//                       child: Checkbox(
//                         checkColor: Colors.white,
//                         activeColor: Colors.amber,
//                         value: false,
//                         onChanged: (bool value) {},
//                       ),
//                     ),
//                     Text(Strings.remember_me,
//                         style: Theme.of(context).textTheme.subhead.copyWith(
//                             color: Colors.white,
//                             fontWeight: FontWeight.normal,
// //                        decoration: TextDecoration.underline,
//                             fontSize: 15))
//                   ],
//                 ),
//               ),
            ],
          ),
          //isCheckLoginButton == true ? LoadingStypeLine() : SizedBox()
        ],
      ),
    );
  }

  @override
  Widget buildPage() {
    // TODO: implement buildPage
    _buildHeader();
  }

  @override
  void onConnectivityListener(bool result) {
    // TODO: implement onConnectivityListener
    isInternetConnected = result;
  }
}
