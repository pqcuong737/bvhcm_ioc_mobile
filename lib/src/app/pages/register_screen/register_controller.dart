import 'package:flutter/cupertino.dart';
import 'package:load/load.dart';
import 'package:mobile/src/app/pages/register_screen/register_presenter.dart';
import 'package:mobile/src/clean_arch/controller.dart';
import 'package:mobile/src/domain/entities/register/RegisterResponse.dart';
import 'package:mobile/src/domain/repositories/register/register_repository.dart';
import 'package:mobile/src/utility/DialogUtilities.dart';
import 'package:mobile/src/utility/LocalStorageService.dart';
import 'package:mobile/src/utility/Strings.dart';
import 'package:mobile/src/utility/Utils.dart';

class RegisterScreenController extends Controller {
  final RegisterScreenPresenter registerPresenter;
  BuildContext context;
  RegisterResponse _registerResponse;
  RegisterResponse get registerResponse => _registerResponse;

  String fullname;
  String username;
  String password;
  String confirmPassword;

  TextEditingController textNameListener = TextEditingController();
  TextEditingController textEmailListener = new TextEditingController();
  TextEditingController textPasswordListener = new TextEditingController();
  TextEditingController textConfirmPasswordListener =
      new TextEditingController();

  RegisterScreenController(registerRepo)
      : registerPresenter = RegisterScreenPresenter(registerRepo),
        super();

  @override
  void initListeners() {
    // TODO: implement initListeners

    registerPresenter.getRegisterOnComplete = () {};

    registerPresenter.getRegisterOnError = () {
      _registerResponse = null;
    };

    registerPresenter.getRegisterOnNext = (RegisterResponse registerResponse) {
      // refreshUI();
      // DialogUtilities.showSimpleDialog(context, Strings.success_text,
      //     "Đăng ký thành công", Strings.OK_TEXT, null);
      // if (registerResponse.statusCode == 200) {
      //   refreshUI();
      //   DialogUtilities.showSimpleDialog(context, Strings.success_text,
      //       Strings.success_change_pass, Strings.OK_TEXT, null);
      // } else {
      //   DialogUtilities.showSimpleDialog(
      //       context,
      //       Strings.error_text,
      //       Utils.mapKeyToMessageErr(registerResponse.error.message),
      //       Strings.OK_TEXT,
      //       null);
      // }
      hideLoadingDialog();
      if (registerResponse.statusCode == 200) {
        refreshUI();
        DialogUtilities.showSimpleDialog(context, Strings.success_text,
            "Đăng ký thành công", Strings.OK_TEXT, null);
      } else {
        DialogUtilities.showSimpleDialog(
            context,
            Strings.error_text,
            Utils.mapKeyToMessageErr(registerResponse.error.message),
            Strings.OK_TEXT,
            null);
        refreshUI();
      }
    };
  }

  RegisterResponse registerUser(
      String fullName, String userId, String password, String confirmPassword) {
    this.fullname = fullName;
    this.username = userId;
    this.password = password;
    this.confirmPassword = confirmPassword;
    _registerResponse = registerPresenter.registerUser(
        fullName, userId, password, confirmPassword);
  }

  @override
  void onResumed() {
    print("On resumed");
    super.onResumed();
  }

  @override
  // ignore: must_call_super
  void dispose() {
    registerPresenter.dispose();
  }
}
