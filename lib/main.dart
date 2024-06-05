import 'package:firebase_shoe_store/core/globals/global_providers.dart';
import 'package:firebase_shoe_store/core/navigation_service/app_router.dart';
import 'package:firebase_shoe_store/core/service_locator/service_locator.dart';
import 'package:firebase_shoe_store/core/theme/theme_data.dart';
import 'package:firebase_shoe_store/core/widgets/custom_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setupServiceLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: GlobalBlocProviders().providers,
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'SHOESLY',
        routerConfig: getIt<AppRouter>().router,
        theme: themeData,
        builder: (BuildContext context, Widget? widget) {
          ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
            return CustomErrorScreen(errorDetails: errorDetails);
          };
          return widget!;
        },
      ),
    );
  }
}
