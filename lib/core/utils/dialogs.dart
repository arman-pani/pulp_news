import 'package:flutter/material.dart';
import 'package:odiya_news_app/core/constants/app_strings.dart';
import 'package:url_launcher/url_launcher.dart';

void showForceUpdateDialog(BuildContext context, bool isForce) {
  showDialog(
    barrierDismissible: !isForce, // can't dismiss if force update
    context: context,
    builder: (context) => AlertDialog(
      title: Text(isForce ? 'Update Required' : 'New Update Available'),
      content: Text(
        isForce
            ? 'You must update the app to continue using it.'
            : 'A new version of the app is available. Would you like to update now?',
      ),
      actions: [
        if (!isForce)
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Later'),
          ),
        ElevatedButton(
          onPressed: () async {
            final url = Uri.parse(AppStrings.playStoreUrl);
            if (await canLaunchUrl(url)) {
              await launchUrl(url, mode: LaunchMode.externalApplication);
            }
          },
          child: const Text('Update'),
        ),
      ],
    ),
  );
}

void showAlertDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
  required String title,
  required String content,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(onPressed: onConfirm, child: const Text('Confirm')),
      ],
    ),
  );
}
