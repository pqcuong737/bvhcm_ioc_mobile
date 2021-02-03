import 'package:mobile/src/domain/entities/login/LoginResponse.dart';
import 'package:mobile/src/domain/entities/register/RegisterResponse.dart';
import 'package:mobile/src/domain/repositories/base_reposiroty.dart';
import 'package:mobile/src/utility/APIProvider.dart';

class RegisterRepository extends BaseRepository {
  APIProvider _apiProvider = APIProvider();

  Future<RegisterResponse> registerUser(
      String fullName, String userID, String password, String confirmPassword) {
    return _apiProvider.registerUser(
      fullName,
      userID,
      password,
      confirmPassword,
    );
  }
}
