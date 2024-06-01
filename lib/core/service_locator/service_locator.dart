import 'package:firebase_shoe_store/core/navigation_service/app_router.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // await setupBlocs();
  // await setupUseCases();
  // await setupRepositories();
  // await setupDataSources();

  /// Other dependencies
  getIt.registerLazySingleton(() => AppRouter());
}