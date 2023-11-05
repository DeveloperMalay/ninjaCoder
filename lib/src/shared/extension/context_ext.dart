part of '../shared.dart';

extension ContextExt on BuildContext {
  // Screen Width
  double get screenWidth => MediaQuery.of(this).size.width;

  // Screen Height
  double get screenHeight => MediaQuery.of(this).size.height;

  // Screen Orientation
  Orientation get screenOrientation => MediaQuery.of(this).orientation;

  // Screen Text Scale Factor
  double get screenTextScaleFactor => MediaQuery.of(this).textScaleFactor;

  // textTheme
  TextTheme get textTheme => Theme.of(this).textTheme;

  // SnackBar with default duration
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }
}
