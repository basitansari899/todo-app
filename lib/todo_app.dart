import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/app/constants/string_constants.dart';
import 'package:todoapp/app/routes/app_pages.dart';
import 'package:todoapp/app/theme/theme.dart';
import 'package:todoapp/app/widgets/keyboard_dismisser.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      child: _GetMaterialApp(),
    );
  }
}

class _GetMaterialApp extends StatelessWidget {
  _GetMaterialApp();



  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      title: AppString.appName,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
      onUnknownRoute: (_) {
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Ups! No route defined for this flow!!!')),
          ),
        );
      },
    );
  }
}