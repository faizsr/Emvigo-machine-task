import 'package:emvigo_machine_task/constants/app_constants.dart';
import 'package:emvigo_machine_task/widgets/k_filled_button.dart';
import 'package:emvigo_machine_task/widgets/k_text_form_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text(
                'Create Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontFamily: dmSerifDisplay,
                ),
              ),
              SizedBox(height: 4),
              Text('All users are verified to help prevent fake accounts'),

              SizedBox(height: 40),
              KTextFormField(hintText: 'Email'),
              SizedBox(height: 16),
              KTextFormField(hintText: 'Password'),
              SizedBox(height: 16),
              KTextFormField(hintText: 'Confirm Password'),

              SizedBox(height: 24),

              KFilledButton(onPressed: () {}, text: 'SIGNUP'),
              Spacer(),

              Center(
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.bodyMedium,
                    children: [
                      const TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: 'SignIn',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (_) => const LoginView(),
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
