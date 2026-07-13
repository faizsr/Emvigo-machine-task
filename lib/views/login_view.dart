import 'package:emvigo_machine_task/constants/app_constants.dart';
import 'package:emvigo_machine_task/controllers/auth_bloc/auth_bloc.dart';
import 'package:emvigo_machine_task/controllers/auth_bloc/auth_event.dart';
import 'package:emvigo_machine_task/controllers/auth_bloc/auth_state.dart';
import 'package:emvigo_machine_task/views/home_page.dart';
import 'package:emvigo_machine_task/views/register_view.dart';
import 'package:emvigo_machine_task/widgets/k_filled_button.dart';
import 'package:emvigo_machine_task/widgets/k_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitLogin(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;

    context.read<AuthBloc>().add(
      AuthLoginRequested(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Welcome to TestApp',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontFamily: dmSerifDisplay,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'All users are verified to help prevent fake accounts',
                ),

                const SizedBox(height: 40),
                KTextFormField(
                  hintText: 'Email',
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                KTextFormField(
                  hintText: 'Password',
                  controller: _passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthAuthenticated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Login successful')),
                      );
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else if (state is AuthFailure) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;
                    return KFilledButton(
                      onPressed: isLoading
                          ? () {}
                          : () => _submitLogin(context),
                      text: isLoading ? 'LOADING...' : 'LOGIN',
                    );
                  },
                ),

                const Spacer(),
                buildHelperText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center buildHelperText(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            const TextSpan(text: "Don't have an account? "),
            TextSpan(
              text: 'SignUp',
              style: const TextStyle(fontWeight: FontWeight.bold),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const RegisterView()),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
}
