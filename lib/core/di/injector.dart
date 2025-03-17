import 'package:coolstore/data/repositories/auth_repository_impl.dart';
import 'package:coolstore/domain/repositories/auth_repository.dart';
import 'package:coolstore/domain/usecases/auth_user.dart';
import 'package:coolstore/presentation/auth/bloc/auth_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/get_products.dart';
import '../../presentation/product/bloc/product_bloc.dart';

GetIt getIt = GetIt.instance;

registerDependencies() {
  registerConfigurations();
  registerProducts();
  registerAuth();
}

registerConfigurations() {
  getIt.registerLazySingleton<Dio>(() => Dio());
  getIt.registerSingleton(
      instanceName: "FakeStoreApi",
      Dio(
        BaseOptions(
            baseUrl: 'https://fakestoreapi.com',
            connectTimeout: const Duration(minutes: 5),
            receiveTimeout: const Duration(minutes: 5),
            sendTimeout: const Duration(minutes: 5)),
      )..interceptors.add(CustomDioInterceptor()));
}

registerProducts() {
  getIt
    ..registerFactory<ProductRepository>(
        () => ProductRepositoryImpl()) // Repositories
    ..registerFactory<GetProducts>(() => GetProducts(getIt())) // use Case
    ..registerFactory(() => ProductBloc(getProducts: getIt())); // Bloc
}

registerAuth() {
  getIt
    ..registerFactory<AuthRepository>(
        () => AuthRepositoryImpl()) // Repositories
    ..registerFactory<AuthUser>(() => AuthUser(getIt())) // use Case
    ..registerFactory(() => AuthBloc(authUser: getIt())); // Bloc
}

class CustomDioInterceptor extends Interceptor {
  CustomDioInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    print("Request sent: ${options.method} ${options.path}");

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    print("Response received: ${err.message} ${err.type} ");
    return super.onError(err, handler);
  }
}
