import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load/load.dart';
import 'package:mobile/src/app/pages/home/main_home_view.dart';
import 'package:mobile/src/app/pages/login_screen/login_controller.dart';
import 'package:mobile/src/clean_arch/view.dart';
import 'package:mobile/src/domain/entities/login.dart';
import 'package:mobile/src/domain/repositories/login/login_repository.dart';
import 'package:mobile/src/utility/DialogUtilities.dart';
import 'package:mobile/src/utility/ImagePath.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/NavigationUtilities.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';

class LoginScreen extends View {
  LoginScreen({Key key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ViewState<LoginScreen, LoginScreenController> {
  LoginScreenState() : super(LoginScreenController(LoginRepository()));
  Size _size;
  bool isCheckLoginButton = false;
  bool isCheckForgotButton = false;
  bool isInternetConnected = false;

  bool checkRememberMe = false;
  String valueLogin;
  String email = null;
  String password = null;
  String dropdownValue = '';

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => onCheckNavigate(context, controller, isCheckLoginButton));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => handleCheckRememberMeCallBack());
  }

  ///Handle set account when have remember me
  Future<void> handleCheckRememberMeCallBack() async {
    final checkRememberMeStored = await LocalStorageService.getFlagRememberMe();

    ///Check box remember me auto check or not
    setState(() {
      checkRememberMe = checkRememberMeStored;
    });
    valueLogin = await LocalStorageService.getLogin();
    if (valueLogin != null && checkRememberMe) {
      final parseLoginObject = jsonDecode(valueLogin);
      if (parseLoginObject != null) {
        email = parseLoginObject["email"];
        password = parseLoginObject["password"];
      }
    }
    controller.myEmailListener.text = email;
    controller.myPasswordListener.text = password;
  }

  @override
  Widget buildPage() {
    isCheckLoginButton ? initState() : null;
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
            ImagePath.logo_digitech,
            fit: BoxFit.fitWidth,
          ),
          SizedBox(
            height: 10,
          ),
          FittedBox(
              child: Text(
            'CÔNG TY TNHH',
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white),
          )),
          SizedBox(
            height: 10,
          ),
          Text(
            'Digitech Solutions',
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
              padding: EdgeInsets.fromLTRB(
                  20, _size.width / 7, 20, _size.width / 10),
              child: Text(Strings.login_text,
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
              controller: controller.myEmailListener,
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
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0)),
              border: new Border.all(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            child: new TextField(
              controller: controller.myPasswordListener,
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
            margin: const EdgeInsets.only(top: 20.0),
            width: _size.width,
            decoration: new BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.amber,
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            child: FlatButton(
              textColor: Colors.white,
              child: Text(
                Strings.LOGIN_TEXT,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              onPressed: () {
                if (controller.myEmailListener?.text == null ||
                    controller.myEmailListener.text.isEmpty ||
                    controller.myPasswordListener.text == null ||
                    controller.myPasswordListener.text.isEmpty) {
                  DialogUtilities.showSimpleDialog(context, Strings.login_text,
                      Strings.email_or_pass_is_empty, Strings.OK_TEXT, () {});
                } else {
                  showLoadingDialog(tapDismiss: false);
                  isCheckLoginButton = true;
                  controller.userAuthenticate(controller.myEmailListener.text,
                      controller.myPasswordListener.text);
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 35),
                child: GestureDetector(
                  onTap: () {
                    DialogUtilities.showSimpleDialog2Button(
                      context,
                      Strings.forgot_pass_word,
                      Strings.email_or_pass_is_empty,
                      Strings.OK_TEXT,
                      (email) {
                        isCheckForgotButton = true;
                        showLoadingDialog(tapDismiss: false);
                        controller.forgotPassword(email);
                      },
                      Strings.cancel_text,
                    );
                  },
                  child: Text(Strings.forgot_pass_word,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.subhead.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.underline,
                          fontSize: 15)),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 35),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Theme(
                      data: Theme.of(context).copyWith(
                        unselectedWidgetColor: Colors.white,
                      ),
                      child: Checkbox(
                        checkColor: Colors.white,
                        activeColor: Colors.amber,
                        value:
                            checkRememberMe != null ? checkRememberMe : false,
                        onChanged: (bool value) {
                          setState(() {
                            checkRememberMe = value;
                            LocalStorageService.saveRememberMe(value);
                          });
                        },
                      ),
                    ),
                    Text(Strings.remember_me,
                        style: Theme.of(context).textTheme.subhead.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
//                        decoration: TextDecoration.underline,
                            fontSize: 15))
                  ],
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: const Divider(
                  height: 20,
                  thickness: 5,
                  indent: 20,
                  endIndent: 20,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 40, 10, 10),
                child: const Text(
                  'CHUYỂN TÀI KHOẢN Ở ĐÂY.',
                  style: TextStyle(
                    color: Colors.yellow,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: DropdownButton<String>(
                    value: '1',
                    dropdownColor: Colors.deepOrange,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.white),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        var account = DATA_MOCK_LOGIN
                            .where((e) => e['id'] == dropdownValue);
                        if (account != null) {
                          controller.myEmailListener.text =
                              account.first['email'];
                          controller.myPasswordListener.text =
                              account.first['pass'];
                        }
                      });
                    },
                    items: DATA_MOCK_LOGIN
                        .map<DropdownMenuItem<String>>((var obj) {
                      return DropdownMenuItem<String>(
                        value: obj['id'],
                        child: Text(obj['name']),
                      );
                    }).toList()),
              ),
            ],
          ),
          //isCheckLoginButton == true ? LoadingStypeLine() : SizedBox()
        ],
      ),
    );
  }

  onCheckNavigate(BuildContext context, LoginScreenController controller,
      bool isCheckLoginButton) async {
    final result = controller.loginResponse;
    if (result != null && isCheckLoginButton) {
      this.isCheckLoginButton = false;
      int code = result.statusCode;
      if (code == 200) {
        //if have remember me to handle
        if (checkRememberMe != null && checkRememberMe) {
          Login login = new Login(
              email: controller.myEmailListener.text,
              password: controller.myPasswordListener.text);
          final parseLogin = jsonEncode(login);
          LocalStorageService.saveLogin(parseLogin);
        } else {
          LocalStorageService.saveLogin("");
        }
        hideLoadingDialog();

        ///End handle remember me
        final user = await LocalStorageService.getUserInfor();
        NavigatorUtilities.pushAndRemoveUntil(context, MainHomePage(user));
      } else {
        hideLoadingDialog();
        DialogUtilities.showSimpleDialog(
            context,
            Strings.error_text,
            Utils.mapKeyToMessageErr(result.error.message),
            Strings.OK_TEXT,
            null);
      }
    } else if (controller.changePassResponse != null && isCheckForgotButton) {
      isCheckForgotButton = false;
      hideLoadingDialog();
      if (controller.changePassResponse.statusCode == 200) {
        DialogUtilities.showSimpleDialog(context, Strings.forgot_pass_word,
            Strings.newPassWasSent, Strings.OK_TEXT, null);
      } else {
        DialogUtilities.showSimpleDialog(
            context,
            Strings.forgot_pass_word,
            Utils.mapKeyToMessageErr(
                controller.changePassResponse.error.message),
            Strings.OK_TEXT,
            null);
      }
    }
  }

  @override
  void onConnectivityListener(bool result) {
    isInternetConnected = result;
  }

  final DATA_MOCK_LOGIN = [
    {
      "id": '1',
      "name": "Admin Account",
      "email": "admin@digitechglobalco.com",
      "pass": "12345678"
    },
    {
      "id": '2',
      "name": "Agency Account",
      "email": "phat2302aa@gmail.com",
      "pass": "123123123"
    },
    {
      "id": '3',
      "name": "Manager Account",
      "email": "andysmith123789456@gmail.com",
      "pass": "123123123"
    },
    {
      "id": '4',
      "name": "Director Account",
      "email": "director@digitechglobalco.com",
      "pass": "P@ssw0rd2020"
    },
    {
      "id": '5',
      "name": "Business_Staff Account",
      "email": "huyentrang081999@gmail.com",
      "pass": "P@ssw0rd2020"
    },
    {
      "id": '6',
      "name": "Officer Account",
      "email": "nthu061198@gmail.com",
      "pass": "P@ssw0rd2020"
    },
  ];
}
