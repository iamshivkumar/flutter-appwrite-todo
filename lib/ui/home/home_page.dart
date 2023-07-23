// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/ui/auth/providers/auth_notifier_provider.dart';
import 'package:todo/utils/extensions.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          TextButton(
            onPressed: () async {
             await ref.read(authProvider.notifier).logout();
              context.goToRoot();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
