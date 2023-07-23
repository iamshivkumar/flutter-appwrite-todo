

import 'package:appwrite/models.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo/core/providers/account_provider.dart';

final userProvider = FutureProvider<User>((ref) => ref.read(accountProvider).get());