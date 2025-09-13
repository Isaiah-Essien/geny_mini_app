
//The Entry point of my Mini Application. 
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  final dio = Dio(BaseOptions(connectTimeout: const Duration(seconds: 2)));
  dio.interceptors.add(LocalAssetMockInterceptor());

  runApp(MyApp(dio: dio));
}


//For now, there are dummy classes.
class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.dio});
  final Dio dio;

  @override
  Widget build(BuildContext context) {
    final repo = BusinessRepository(dio, LocalCache());

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BusinessProvider(repo)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF0F1220),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7A3AFF)),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
