import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_poject_final/core/routing/routes_name.dart';

import '../manager/login_cubit.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      return;
    }

    context.read<LoginCubit>().login(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
  }

  void loginWithGoogle() {
    context.read<LoginCubit>().loginWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Login successful'),
                ),
              );

              Navigator.pushReplacementNamed(
                context,
                RoutesName.home,
              );
            }

            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is LoginLoading;

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : login,
                    child: isLoading
                        ? const CircularProgressIndicator()
                        : const Text('Login'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(
                      child: Divider(),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                      ),
                      child: const Text('OR'),
                    ),
                    const Expanded(
                      child: Divider(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: isLoading ? null : loginWithGoogle,
                    icon: const Icon(Icons.g_mobiledata),
                    label: const Text('Continue with Google'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                      onPressed: isLoading
                          ? null
                          : () {
                              Navigator.pushNamed(
                                context,
                                RoutesName.signup,
                              );
                            },
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
