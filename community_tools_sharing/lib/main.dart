import 'package:community_tools_sharing/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/app_cubit.dart';
import 'utils/app_routes.dart';
import 'utils/app_themes.dart';


const supabaseUrl = 'https://aocxtygybbboqmurwfoz.supabase.co';
const supabaseKey = String.fromEnvironment('SUPABASE_KEY');

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
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
        onGenerateRoute: AppRoutes.onGenerateRoute,
      ),
    );
  }
}
