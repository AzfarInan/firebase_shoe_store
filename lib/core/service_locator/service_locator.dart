import 'package:firebase_shoe_store/core/cache_service/cache_manager.dart';
import 'package:firebase_shoe_store/core/cache_service/cache_manager_impl.dart';
import 'package:firebase_shoe_store/core/navigation_service/app_router.dart';
import 'package:firebase_shoe_store/features/cart/presentation/manager/manage_cart_cubit.dart';
import 'package:firebase_shoe_store/features/dashboard/data/data_sources/brand_data_source.dart';
import 'package:firebase_shoe_store/features/dashboard/data/repositories/brand_repository_impl.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/repositories/brand_repository.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/use_cases/get_brands.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/manager/get_brands_cubit.dart';
import 'package:firebase_shoe_store/features/filter/presentation/manager/manage_filter_cubit.dart';
import 'package:firebase_shoe_store/features/order/data/data_sources/order_data_source.dart';
import 'package:firebase_shoe_store/features/order/data/repositories/order_repository_impl.dart';
import 'package:firebase_shoe_store/features/order/domain/repositories/order_repository.dart';
import 'package:firebase_shoe_store/features/order/domain/use_cases/create_order.dart';
import 'package:firebase_shoe_store/features/order/domain/use_cases/get_order_history.dart';
import 'package:firebase_shoe_store/features/order/presentation/manager/create_order_cubit.dart';
import 'package:firebase_shoe_store/features/order/presentation/manager/get_order_history_cubit.dart';
import 'package:firebase_shoe_store/features/product/data/data_sources/product_data_source.dart';
import 'package:firebase_shoe_store/features/product/data/repositories/product_repository_impl.dart';
import 'package:firebase_shoe_store/features/product/domain/repositories/product_repository.dart';
import 'package:firebase_shoe_store/features/product/domain/use_cases/get_products.dart';
import 'package:firebase_shoe_store/features/product/presentation/manager/get_products_cubit.dart';
import 'package:firebase_shoe_store/features/product/presentation/manager/manage_product_cubit.dart';
import 'package:firebase_shoe_store/features/reviews/presentation/manager/manage_review_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// Cache Service
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton<CacheManager>(
    () => CacheManagerImpl(sharedPreferences),
  );

  /// Blocs
  getIt.registerFactory(() => GetBrandsCubit(useCase: getIt()));
  getIt.registerFactory(() => GetProductsCubit(useCase: getIt()));
  getIt.registerFactory(() => ManageReviewCubit());
  getIt.registerFactory(() => ManageProductCubit());
  getIt.registerFactory(() => ManageCartCubit());
  getIt.registerFactory(() => ManageFilterCubit());
  getIt.registerFactory(() => CreateOrderCubit(useCase: getIt()));
  getIt.registerFactory(() => GetOrderHistoryCubit(useCase: getIt()));

  /// Use cases
  getIt.registerLazySingleton(() => GetBrands(repository: getIt()));
  getIt.registerLazySingleton(() => GetProducts(repository: getIt()));
  getIt.registerLazySingleton(() => CreateOrder(repository: getIt()));
  getIt.registerLazySingleton(() => GetOrderHistory(repository: getIt()));

  /// Repositories
  getIt.registerLazySingleton<BrandRepository>(
    () => BrandRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(getIt()),
  );

  /// Data sources
  getIt.registerLazySingleton<BrandDataSource>(() => BrandDataSourceImpl());
  getIt.registerLazySingleton<ProductDataSource>(() => ProductDataSourceImpl());
  getIt.registerLazySingleton<OrderDataSource>(() => OrderDataSourceImpl());

  /// Other dependencies
  getIt.registerLazySingleton(() => AppRouter());
}
