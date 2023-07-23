// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/ui/auth/providers/user_provider.dart';
import 'package:todo/ui/root.dart';
import 'package:todo/ui/splash/providers/splash_seen_provider.dart';
import 'package:todo/utils/extensions.dart';
import 'package:todo/utils/labels.dart';

class SplashPage extends HookConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void init() async {
      try {
        await ref.read(userProvider.future);
      } catch (e) {
        debugPrint('$e');
      }
      await Future.delayed(const Duration(seconds: 1));
      ref.read(splashSeenProvider.notifier).state = true;
      context.replace(Root.route);
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return Scaffold(
      backgroundColor: context.scheme.primary,
      body: SafeArea(
        child: Center(
          child: Text(
            Labels.appName,
            style: context.style.displayMedium!
                .copyWith(color: context.scheme.onPrimary),
          ),
        ),
      ),
    );
  }
}
