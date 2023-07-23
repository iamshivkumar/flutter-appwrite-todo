import 'package:flutter/material.dart';
import 'package:todo/utils/extensions.dart';

class LoadingLayer extends StatelessWidget {
  const LoadingLayer({super.key, required this.child, this.loading = false});

  final Widget child;
  final bool loading;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          Material(
            color: context.scheme.primary.withOpacity(0.25),
            child: const SafeArea(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          )
      ],
    );
  }
}
