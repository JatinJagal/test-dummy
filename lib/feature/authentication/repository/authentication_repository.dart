import 'package:either_dart/either.dart';
import 'package:test_projectt/core/global/constants/end_points.dart';
import 'package:test_projectt/core/services/api_services.dart';
import 'package:test_projectt/feature/authentication/login/models/login_response_model.dart';

class AuthenticationRepository {
  ApiService apiService = ApiService();
  Future<Either<String, LoginResponseModel>> login(
    String userName,
    String password,
  ) async {
    try {
      final response = await apiService.post(EndPoints.login, {
        "username": userName,
        "password": password,
        "expiresInMins": 600,
      });

      if (response.isRight) {
        if (response.right.statusCode == 200) {
          return Right(LoginResponseModel.fromJson(response.right.data));
        } else {
          return Left(response.right.data['message']);
        }
      } else {
        return Left(response.left);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
