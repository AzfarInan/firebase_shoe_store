import 'package:firebase_shoe_store/core/navigation_service/app_router.dart';
import 'package:firebase_shoe_store/features/dashboard/data/data_sources/brand_data_source.dart';
import 'package:firebase_shoe_store/features/dashboard/data/repositories/brand_repository_impl.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/repositories/brand_repository.dart';
import 'package:firebase_shoe_store/features/dashboard/domain/use_cases/get_brands.dart';
import 'package:firebase_shoe_store/features/dashboard/presentation/manager/get_brands_cubit.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  /// Blocs
  getIt.registerFactory(() => GetBrandsCubit(useCase: getIt()));

  /// Use cases
  getIt.registerLazySingleton(() => GetBrands(repository: getIt()));

  /// Repositories
  getIt.registerLazySingleton<BrandRepository>(
    () => BrandRepositoryImpl(getIt()),
  );

  /// Data sources
  getIt.registerLazySingleton<BrandDataSource>(() => BrandDataSourceImpl());

  /// Other dependencies
  getIt.registerLazySingleton(() => AppRouter());
}
