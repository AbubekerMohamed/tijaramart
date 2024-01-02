import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/auth/screens/auth_screen.dart';
import 'package:tijaramart/providers/user_provider.dart';
import 'package:tijaramart/routes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: GlobalVariables.secondaryColor,
          ),
          scaffoldBackgroundColor: GlobalVariables.backgroundColor,
          appBarTheme: const AppBarTheme(
              elevation: 0, iconTheme: IconThemeData(color: Colors.black))),
      home: const AuthScreen(),
      onGenerateRoute: (settings) => generateRoute(settings),
    );
  }
}
