import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:either_dart/either.dart';
import 'package:test_projectt/core/global/constants/end_points.dart';
import 'package:test_projectt/core/services/api_services.dart';
import 'package:test_projectt/core/services/offline_service.dart';
import 'package:test_projectt/feature/home/models/products_list_model.dart';

class ProductRepository {
  final ApiService _apiService = ApiService();
  final OfflineService _offlineService = OfflineService();

  Future<Either<String, ProductListModel>> getProductsList({
    required int limit,
    required int skip,
  }) async {
    final cacheKey = "${EndPoints.homeProducts}_${limit}_$skip";

    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (_offlineService.hasData(cacheKey)) {
        final data = _offlineService.getData(cacheKey);
        return Right(ProductListModel.fromJson(data));
      }
      return const Left("No internet connection and no offline data");
    }

    try {
      final response = await _apiService.get(
        "${EndPoints.homeProducts}?limit=$limit&skip=$skip",
      );
      if (response.isRight) {
        if (response.right.statusCode == 200) {
          if (response.right.data != null) {
            _offlineService.saveData(cacheKey, response.right.data);
            return Right(ProductListModel.fromJson(response.right.data));
          }
        }
        return Left(response.right.data['message']);
      } else if (response.isLeft) {
        return Left(response.left.toString());
      }
      return const Left("Something went wrong");
    } catch (e) {
      return Left(e.toString());
    }
  }
}
