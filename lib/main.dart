import 'package:chatgpt_flutter/providers/currentBotState.dart';
import 'package:chatgpt_flutter/providers/currentState.dart';
import 'package:chatgpt_flutter/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CurrentState()),
        ChangeNotifierProvider(create: (context) => CurrentBotState()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: OurHome(),
        home: SplashScreen(),
      ),
    );
  }
}
