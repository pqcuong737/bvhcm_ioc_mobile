import 'package:mobile/src/clean_arch/observer.dart';
import 'package:mobile/src/clean_arch/presenter.dart';
import 'package:mobile/src/domain/entities/register/RegisterResponse.dart';
import 'package:mobile/src/domain/usecases/register/register_user_usecase.dart';

class RegisterScreenPresenter extends Presenter {
  Function getRegisterOnComplete;
  Function getRegisterOnError;
  Function getRegisterOnNext;

  final RegisterUserUseCase registerUserUseCase;

  RegisterScreenPresenter(registerRepo)
      : registerUserUseCase = RegisterUserUseCase(registerRepo);

  RegisterResponse registerUser(
      String fullName, String userId, String password) {
    registerUserUseCase.execute(GetRegisterUseCaseObserver(this),
        GetRegisterUserCaseParam(fullName, userId, password));
  }

  @override
  void dispose() {
    registerUserUseCase.dispose();
  }
}

class GetRegisterUseCaseObserver extends Observer<GetRegisterCaseResponse> {
  RegisterScreenPresenter registerPresenter;
  GetRegisterUseCaseObserver(this.registerPresenter);
  @override
  void onComplete() {
    // TODO: implement onComplete

    if (registerPresenter.getRegisterOnComplete != null) {
      registerPresenter.getRegisterOnComplete();
    }
  }

  @override
  void onError(e) {
    // TODO: implement onError

    if (registerPresenter.getRegisterOnError != null) {
      registerPresenter.getRegisterOnError();
    }
  }

  @override
  void onNext(GetRegisterCaseResponse response) {
    // TODO: implement onNext

    if (registerPresenter.getRegisterOnNext != null) {
      registerPresenter.getRegisterOnNext(response.registerResponse);
    }
  }
}
