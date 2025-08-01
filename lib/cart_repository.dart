import 'package:api_testing_app/api_service.dart';
import 'package:api_testing_app/data/offline/db_service.dart';
import 'package:api_testing_app/model/carts_model.dart';
import 'package:api_testing_app/util/app_contant.dart';

class CartRepository {
  final ApiService _apiService = ApiService();
  final DbService _dbService = DbService();

  /// Fetches data from API and inserts into local DB
  Future<CartsModel?> fetchCartsFromApi() async {
    try {
      final cartsModel = await _apiService.getData<CartsModel>(
        url: "${AppContant.baseUrl}/carts",
        fromjson: (json) => CartsModel.fromjson(json),
      );
      print("data succeffuly fetched");

      if (cartsModel != null) {
        await _dbService.cacheCarts(cartsModel);
        print("data succeffuly inserted to db");
      }

      return cartsModel;
    } catch (e) {
      print("API fetch failed: $e");
      return null;
    }
  }

  /// Fetches carts data from local database
  Future<CartsModel?> getCartsFromDb() async {
    try {
      return await _dbService.getCachedCarts();
    } catch (e) {
      print("DB fetch failed: $e");
      return null;
    }
  }

  /// Main function for UI: tries API, falls back to DB
  Future<CartsModel?> getCarts() async {
    final remoteData = await fetchCartsFromApi();
    if (remoteData != null) return remoteData;

    final localData = await getCartsFromDb();
    if (localData != null) return localData;

    throw Exception("No data available from API or local cache");
  }
}
