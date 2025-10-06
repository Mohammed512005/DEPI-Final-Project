import 'package:community_tools_sharing/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/app_cubit.dart';
import '../../cubit/app_state.dart';
import '../../utils/app_routes.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          if (state is AppLoggedIn) {
            Navigator.pushReplacementNamed(context, AppRoutes.home);
          } else if (state is AppError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AppLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                const SizedBox(height: 24),
                CustomButton(
                  text: 'Login',
                  onPressed: () {
                    context.read<AppCubit>().login(
                          usernameController.text,
                          passwordController.text,
                        );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
