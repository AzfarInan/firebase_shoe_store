import 'package:firebase_shoe_store/core/navigation_service/app_router.dart';
import 'package:firebase_shoe_store/core/service_locator/service_locator.dart';
import 'package:firebase_shoe_store/core/widgets/custom_error_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

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
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'SHOESLY',
      routerConfig: getIt<AppRouter>().router,
      theme: ThemeData(
        fontFamily: "Inter",
        canvasColor: Colors.transparent,
      ),
      builder: (BuildContext context, Widget? widget) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return CustomErrorScreen(errorDetails: errorDetails);
        };
        return widget!;
      },
    );
  }
}

//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   // final FirestoreService _firestoreService = FirestoreService();
//
//   @override
//   void initState() {
//     super.initState();
//
//     // final product = Product(
//     //   id: '3',
//     //   name: 'Red',
//     //   price: 7.21,
//     // );
//     // _createProduct(product);
//   }
//
//   // Future<void> _createProduct(Product product) async {
//   //   await _firestoreService.addProduct(product);
//   //   print(product);
//   // }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final FirestoreService _firestoreService = FirestoreService();
//   final List<Product> _products = [];
//   double _counter = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     _firestoreService.getProducts().then((products) {
//       setState(() {
//         _products.addAll(products);
//       });
//     });
//   }
//
//   void _incrementCounter() {
//     fetchAveragePrice().then((value) {
//       setState(() {
//         _counter = value;
//       });
//     });
//   }
//
//   Future<double> fetchAveragePrice() async {
//     // HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('computeAveragePrice');
//     // final results = await callable.call();
//     // return results.data['average'];
//     dynamic result;
//     try {
//       result = await FirebaseFunctions.instance
//           .httpsCallable('computeAveragePrice')
//           .call();
//     } on FirebaseFunctionsException catch (error) {
//       print(error.code);
//       print(error.details);
//       print(error.message);
//     }
//     return result.data['average'] ?? 404;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: <Widget>[
//           const Text(
//             'You have pushed the button this many times:',
//           ),
//           Text(
//             '$_counter',
//             style: Theme.of(context).textTheme.headlineMedium,
//           ),
//           ListView.builder(
//             shrinkWrap: true,
//             itemCount: _products.length,
//             itemBuilder: (context, index) {
//               final product = _products[index];
//               return ListTile(
//                 leading: Image.network(product.image ?? 'https://via.placeholder.com/150'),
//                 title: Text(product.name),
//                 subtitle: Text(product.price.toString()),
//               );
//             },
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
//
// class FirestoreService {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;
//
//   Future<void> addProduct(Product product) {
//     return _db.collection('products').doc(product.id).set(product.toJson());
//   }
//
//   Future<List<Product>> getProducts() async {
//     final snapshot = await _db.collection('products').get();
//     return snapshot.docs.map((doc) => Product.fromJson(doc.data())).toList();
//   }
// }
