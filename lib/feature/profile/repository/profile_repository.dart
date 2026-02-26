import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:test_projectt/core/global/constants/end_points.dart';
import 'package:test_projectt/core/services/api_services.dart';
import 'package:test_projectt/core/services/offline_service.dart';
import 'package:test_projectt/feature/profile/models/user_profile_model.dart';

class ProfileRepository {
  ApiService apiService = ApiService();
  final OfflineService _offlineService = OfflineService();

  Future<Either<String, UserProfileModel>> getUserProfile() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        if (_offlineService.hasData(EndPoints.userProfile)) {
          final data = _offlineService.getData(EndPoints.userProfile);
          return Right(UserProfileModel.fromJson(data));
        }
        return const Left("No internet connection and no offline data");
      }

      try {
        final response = await apiService.get(EndPoints.userProfile);
        if (response.isRight) {
          if (response.right.statusCode == 200) {
            _offlineService.saveData(
              EndPoints.userProfile,
              response.right.data,
            );
            return Right(UserProfileModel.fromJson(response.right.data));
          } else {
            return Left(response.right.data['message']);
          }
        } else {
          return Left(response.left);
        }
      } catch (e) {
        return Left(e.toString());
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
