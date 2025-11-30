import 'package:community_tools_sharing/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/app_cubit.dart';
import 'utils/app_routes.dart';
import 'utils/app_themes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

const supabaseUrl = 'https://aocxtygybbboqmurwfoz.supabase.co';
// const supabaseKey = String.fromEnvironment('SUPABASE_KEY');
const supabaseKey =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFvY3h0eWd5YmJib3FtdXJ3Zm96Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjM5ODIzMDQsImV4cCI6MjA3OTU1ODMwNH0.86datZvRN45ijoezIAmnSyvTUWfHH6NoJRLXl7nh4MQ';
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // request notification permissions
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  // get FCM token
  String? fcmToken = await FirebaseMessaging.instance.getToken();
  print("FCM Token: $fcmToken");

  // listen for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Foreground message received: ${message.notification?.title}');
  });
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('Notification clicked: ${message.data}');
  });

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
