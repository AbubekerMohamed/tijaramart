import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tijaramart/common/components/bottom_navigation.dart';
import 'package:tijaramart/constants/global_variables.dart';
import 'package:tijaramart/features/admin/screens/admin_screen.dart';
import 'package:tijaramart/features/auth/screens/auth_screen.dart';
import 'package:tijaramart/features/auth/services/auth_service.dart';
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
  AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> homeKey = GlobalKey<FormState>(debugLabel: '_appkey');
    return MaterialApp(
      title: 'tijaramart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color.fromARGB(255, 136, 0, 255),
        ),
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        fontFamily: 'Poppins',
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Container(
        key: homeKey,
        child: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.role == 'customer'
                ? const BottomNavigation()
                : const AdminScreen()
            : const AuthScreen(),
      ),
    );
  }
}
