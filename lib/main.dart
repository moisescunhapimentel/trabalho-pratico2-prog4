import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:trabalho2/providers/dog_provider.dart';
import 'package:trabalho2/repositories/dog_repository.dart';
import 'package:trabalho2/screens/home_page.dart';
import 'package:trabalho2/services/dog_service.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => DogProvider(
            dogService: DogService(repository: DogRepository(dio: Dio()))),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CutDogs',
        theme: ThemeData(
            fontFamily: GoogleFonts.poppins().fontFamily,
            scaffoldBackgroundColor: const Color(0xFFFFF8E1),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            appBarTheme: const AppBarTheme(backgroundColor: Color(0xFFFFE4E1))),
        home: const HomePage());
  }
}
