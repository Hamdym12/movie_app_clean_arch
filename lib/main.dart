import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_prime_wave_task/task/presentation/screens/articles_screen.dart';
import 'core/di/service_locater.dart';

void main()async{
  runZonedGuarded(()async{
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load(fileName: ".env");
    configureDependencies();
    runApp(const MyApp());
  }, (e,s){
    log('error $e');
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Task - Prime Wave',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ArticlesScreen(),
    );
  }
}

