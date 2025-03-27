import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {
  /// Pushes a screen with a fade transition and keeps the iOS swipe gesture.
  static void push(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      _platformAwareFadePageRoute(screen),
    );
  }

  /// Pushes a screen and removes all previous screens with a fade transition.
  static void pushAndRemove(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      _platformAwareFadePageRoute(screen),
          (route) => false,
    );
  }
  static void pushReplacement(BuildContext context, Widget screen) {
    Navigator.pushReplacement(
      context,
      _platformAwareFadePageRoute(screen),

    );
  }
  /// Platform-aware PageRoute with fade transition and swipe-back gesture for iOS.
  static PageRoute _platformAwareFadePageRoute(Widget screen) {
    if (Platform.isIOS) {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
      );
    } else {
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => screen,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 500),
        reverseTransitionDuration: const Duration(milliseconds: 500),
      );
    }
  }
}
