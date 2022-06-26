import 'package:day49_fitness_app_with_api/provider/home_provider.dart';
import 'package:day49_fitness_app_with_api/screen/anmationscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<HomeProvider>(
            create: (_)=>HomeProvider(),
        )
      ],
  child: const MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
