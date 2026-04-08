import 'package:flutter/material.dart';

class AppSnackbarService {
  AppSnackbarService(this._messengerKey);

  final GlobalKey<ScaffoldMessengerState> _messengerKey;

  GlobalKey<ScaffoldMessengerState> get messengerKey => _messengerKey;

  void hideCurrent() {
    _messengerKey.currentState?.hideCurrentSnackBar();
  }

  void showError(
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(message, isError: true, actionLabel: actionLabel, onAction: onAction);
  }

  void showSuccess(
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      message,
      isError: false,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  void _show(
    String message, {
    required bool isError,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final context = _messengerKey.currentContext;
    final state = _messengerKey.currentState;
    if (context == null || state == null) {
      return;
    }

    final scheme = Theme.of(context).colorScheme;
    state
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isError ? scheme.error : scheme.inverseSurface,
          action: actionLabel != null && onAction != null
              ? SnackBarAction(label: actionLabel, onPressed: onAction)
              : null,
        ),
      );
  }
}
