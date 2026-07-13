import 'package:emvigo_machine_task/constants/app_colors.dart';
import 'package:emvigo_machine_task/constants/app_constants.dart';
import 'package:emvigo_machine_task/views/login_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: outfit,
        scaffoldBackgroundColor: AppColors.white,
      ),
      home: const LoginView(),
    );
  }
}
