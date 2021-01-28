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

  String username;
  String password;

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
      if (registerResponse.statusCode == 200) {
        refreshUI();
        DialogUtilities.showSimpleDialog(context, Strings.success_text,
            Strings.success_change_pass, Strings.OK_TEXT, null);
      } else {
        DialogUtilities.showSimpleDialog(
            context,
            Strings.error_text,
            Utils.mapKeyToMessageErr(registerResponse.error.message),
            Strings.OK_TEXT,
            null);
      }
      hideLoadingDialog();
      // if (registerResponse.statusCode == 500) {
      //   print('dddd' + registerResponse.error.message.toString());
      //   LocalStorageService.saveString(
      //       LocalStorageService.IS_SUCCESS, registerResponse.error.message);
      // } else {
      //   _registerResponse = registerResponse;
      //   refreshUI();
      // }
    };
  }

  RegisterResponse registerUser(String userId, String password) {
    this.username = userId;
    this.password = password;
    _registerResponse = registerPresenter.registerUser(userId, password);
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
