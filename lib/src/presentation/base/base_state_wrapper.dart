import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

enum PlatformType {
  android,
  iOS,
}

abstract class BaseStateWrapper<T extends StatefulWidget> extends State<T>
    with WidgetsBindingObserver {
  void onInit();

  void onDispose();

  void onPause();

  void onResume();

  

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    onInit();
    super.initState();
  }

  Widget onBuild(
    BuildContext context,
    BoxConstraints constraints,
    PlatformType platform,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return onBuild(
        context,
        constraints,
        Platform.isAndroid ? PlatformType.android : PlatformType.iOS,
      );
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    onDispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        showLog('AppLifecycleState.resumed');
        onResume();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        showLog('AppLifecycleState.paused');
        onPause();
        break;
      case AppLifecycleState.detached:
        showLog('AppLifecycleState.detached');
        onDispose();
        break;
      case AppLifecycleState.hidden:
        showLog('AppLifecycleState.hidden');
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  void showLog(String message) {
    debugPrint('[$runtimeType] $message');
  }

  void showLoading() {
    BotToast.showLoading();
  }

  void hideLoading() {
    BotToast.closeAllLoading();
  }

  void showToast(String message) {
    BotToast.showText(
      text: message,
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      contentColor: Colors.blue,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 10,
      ),
      borderRadius: BorderRadius.circular(10),
      duration: const Duration(seconds: 2),
    );
  }

  void dismissKeyboard() {
    if (FocusScope.of(context).hasFocus) {
      FocusScope.of(context).unfocus();
    }
  }
}
