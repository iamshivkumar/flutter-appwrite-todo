// ignore_for_file: unused_result

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo/core/providers/account_provider.dart';
import 'package:todo/ui/auth/models/auth_state.dart';
import 'package:todo/ui/auth/providers/user_provider.dart';

part 'auth_notifier_provider.g.dart';

@riverpod
class Auth extends _$Auth {
  @override
  AuthState build() {
    return AuthState();
  }

  void nameChanged(String v) {
    state = state.copyWith(name: v);
  }

  void emailChanged(String v) {
    state = state.copyWith(email: v);
  }

  void passwordChanged(String v) {
    state = state.copyWith(password: v);
  }

  void toggleObscuredText() {
    state = state.copyWith(obscureText: !state.obscureText);
  }

  bool get isLoginReady =>
      state.email.isNotEmpty && state.password.isNotEmpty && !state.loading;

  bool get isSignUpReady =>
      state.name.isNotEmpty &&
      state.email.isNotEmpty &&
      state.password.isNotEmpty &&
      !state.loading;

  Account get _account => ref.read(accountProvider);

  Future<void> login() async {
    state = state.copyWith(loading: true);
    try {
      await _account.createEmailSession(
        email: state.email,
        password: state.password,
      );
     await ref.refresh(userProvider.future);
    } catch (e) {
      state = state.copyWith(loading: false);
      if (e is AppwriteException) {
        return Future.error(e.message ?? e);
      }
      return Future.error(e);
    }
  }

  Future<void> register() async {
    state = state.copyWith(loading: true);
    try {
      await _account.create(
        email: state.email,
        password: state.password,
        userId: ID.unique(),
        name: state.name,
      );
      await _account.createEmailSession(
        email: state.email,
        password: state.password,
      );
     await ref.refresh(userProvider.future);
    } catch (e) {
      state = state.copyWith(loading: false);
      if (e is AppwriteException) {
        return Future.error(e.message ?? e);
      }
      return Future.error(e);
    }
  }

  Future<void> logout()async{
    await _account.deleteSessions();
     try {
       await ref.refresh(userProvider.future);
     } catch (e) {
       debugPrint('$e');
     }
  }
}
