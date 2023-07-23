// ignore_for_file: use_build_context_synchronously

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/ui/auth/providers/auth_notifier_provider.dart';
import 'package:todo/ui/auth/register_page.dart';
import 'package:todo/ui/components/loading_layer.dart';
import 'package:todo/utils/extensions.dart';
import 'package:todo/utils/labels.dart';
import 'package:todo/utils/validator.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final model = ref.watch(authProvider);
    final notifier = ref.read(authProvider.notifier);
    return LoadingLayer(
      loading: model.loading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(Labels.appName),
        ),
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Login",
                      style: context.style.headlineLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.scheme.primary),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      validator: Validators.email,
                      initialValue: model.email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      onChanged: notifier.emailChanged,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      validator: Validators.required,
                      initialValue: model.password,
                      obscureText: model.obscureText,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          onPressed: () {
                            notifier.toggleObscuredText();
                          },
                          icon: Icon(
                            model.obscureText
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                      onChanged: notifier.passwordChanged,
                    ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: notifier.isLoginReady
                          ? () async {
                              try {
                                await notifier.login();
                                context.goToRoot();
                              } catch (e) {
                                context.error(e);
                              }
                            }
                          : null,
                      child: const Text('Login'),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: "Don't have as account?",
                          style: TextStyle(
                            color: context.scheme.outline,
                          ),
                          children: [
                            TextSpan(
                              text: " Sign Up",
                              style: context.style.labelLarge!.copyWith(
                                color: context.scheme.primary,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go(RegisterPage.route);
                                },
                            )
                          ]),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
