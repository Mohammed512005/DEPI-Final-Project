import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/app_cubit.dart';
import 'utils/app_routes.dart';
import 'utils/app_themes.dart';

void main() {
  runApp(const CommunityToolsApp());
}

class CommunityToolsApp extends StatelessWidget {
  const CommunityToolsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AppCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Community Tools Sharing',
        theme: AppThemes.lightTheme,
        darkTheme: AppThemes.darkTheme,
        themeMode: ThemeMode.light,
        initialRoute: AppRoutes.splash,
        routes: AppRoutes.routes,
      ),
    );
  }
}
