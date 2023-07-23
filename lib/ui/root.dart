import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/ui/auth/login_page.dart';
import 'package:todo/ui/auth/providers/user_provider.dart';
import 'package:todo/ui/home/home_page.dart';
import 'package:todo/ui/splash/providers/splash_seen_provider.dart';
import 'package:todo/ui/splash/splash_page.dart';

class Root extends ConsumerWidget {
  const Root({super.key});

  static const route = "/";
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final seen = ref.read(splashSeenProvider);
    return !seen
        ? const SplashPage()
        : ref.read(userProvider).when(
              data: (_) => const HomePage(),
              error: (error, stackTrace) {
                if (error is AppwriteException && error.code == 401) {
                  return const LoginPage();
                }
                return Scaffold(
                  body: Center(
                    child: Text('$error'),
                  ),
                );
              },
              loading: () => const Material(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
  }
}
