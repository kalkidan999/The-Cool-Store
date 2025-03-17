import 'package:coolstore/domain/repositories/product_repository.dart';
import 'package:dio/dio.dart';

import '../../core/di/injector.dart';
import '../../core/error/error_handler.dart';
import '../../domain/entities/product.dart';
import '../models/product_model.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    try {
      final response =
          await getIt<Dio>(instanceName: "FakeStoreApi").get("/products");

      final List<dynamic> result = response.data;

      if (response.statusCode == 200) {
        List<ProductModel> products =
            result.map((json) => ProductModel.fromJson(json)).toList();

        return products;
      } else {
        throw ErrorHandler(errorMessage: "Error fetching products");
      }
    } on DioException catch (e) {
      throw ErrorHandler.fromDioException(e);
    } on ErrorHandler catch (e) {
      throw ErrorHandler(errorMessage: e.errorMessage);
    } catch (e) {
      throw ErrorHandler(errorMessage: "Error fetching products");
    }
  }
}
