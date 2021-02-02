import 'dart:async';

import 'package:mobile/src/clean_arch/usecase.dart';
import 'package:mobile/src/domain/entities/register/RegisterResponse.dart';
import 'package:mobile/src/domain/repositories/register/register_repository.dart';

class RegisterUserUseCase
    extends UseCase<GetRegisterCaseResponse, GetRegisterUserCaseParam> {
  final RegisterRepository registerRepository;
  RegisterUserUseCase(this.registerRepository);

  @override
  Future<Stream<GetRegisterCaseResponse>> buildUseCaseStream(
      GetRegisterUserCaseParam params) async {
    final StreamController<GetRegisterCaseResponse> controller =
        StreamController();
    try {
      //get Login Response
      RegisterResponse registerResponse = await registerRepository.registerUser(
          params.fullName, params.userID, params.password);
      // Adding it triggers the .onNext() in the `Observer`
      // It is usually better to wrap the reponse inside a respose object.
      controller.add(GetRegisterCaseResponse(registerResponse));
//      logger.finest('GetUserRegisterCaseResponse successful.');
      controller.close();
    } catch (e) {
      logger.e('GetUserRegisterCaseResponse unsuccessful, ${e.toString()}');
      // Trigger .onError
      controller.addError(e);
    }
    return controller.stream;
  }
}

/// Wrapping params inside an object makes it easier to change later
class GetRegisterUserCaseParam {
  final String fullName;
  final String userID;
  final String password;
  GetRegisterUserCaseParam(this.fullName, this.userID, this.password);
}

/// Wrapping response inside an object makes it easier to change later
class GetRegisterCaseResponse {
  final RegisterResponse registerResponse;
  GetRegisterCaseResponse(this.registerResponse);
}
