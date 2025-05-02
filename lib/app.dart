import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/di/locator.dart';
import 'presentation/providers/contact_provider.dart';
import 'presentation/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    setupLocator();
    return ChangeNotifierProvider(
      create: (context) => ContactProvider()..loadContacts(context: context),
      child: MaterialApp(
        title: 'Contact App',
        debugShowCheckedModeBanner: false,
        initialRoute: AppRoutes.home,
        routes: AppRoutes.routes,
      ),
    );
  }
}
