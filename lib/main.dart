import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tijaramart/common/components/bottom_navigation.dart';
import 'package:tijaramart/common/utils/screen_size_config.dart';
import 'package:tijaramart/features/admin/screens/admin_screen.dart';
import 'package:tijaramart/features/auth/screens/auth_screen.dart';
import 'package:tijaramart/features/auth/services/auth_service.dart';
import 'package:tijaramart/providers/user_provider.dart';
import 'package:tijaramart/routes.dart';
import 'package:tijaramart/theme.dart';

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
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ScreenSizeConfig().init(context);
    return MaterialApp(
      title: 'tijaramart',
      debugShowCheckedModeBanner: false,
      theme: theme(),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.role == 'customer'
              ? const BottomNavigation()
              : const AdminScreen()
          : const AuthScreen(),
    );
  }
}
