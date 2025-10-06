import 'package:flutter/material.dart';
import '../../cubit/app_cubit.dart';
import '../../utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/app_routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Tools'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AppCubit>().logout();
              Navigator.pushReplacementNamed(context, AppRoutes.login);
            },
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Welcome to Community Tools Sharing!',
          style: TextStyle(fontSize: 20, color: AppColors.text),
        ),
      ),
    );
  }
}
