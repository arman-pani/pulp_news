import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:odiya_news_app/controllers/web_controller.dart';

class WebViewPage extends StatelessWidget {
  final String url;
  final String title;

  const WebViewPage({super.key, required this.url, required this.title});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller with the provided URL and title
    final webController = Get.put(WebController(
      initialUrl: url,
      initialTitle: title,
    ));

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Obx(() => Text(
          webController.currentUrl.value,
          style: Theme.of(context).textTheme.titleMedium,
        )),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        actionsPadding: const EdgeInsets.only(right: 12.0),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: webController.reload,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'open_external':
                  webController.openInExternalBrowser();
                  break;
                case 'copy_url':
                  webController.copyUrl();
                  break;
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'open_external',
                child: Row(
                  children: [
                    Icon(Icons.open_in_browser),
                    SizedBox(width: 8),
                    Text('Open in Browser'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'copy_url',
                child: Row(
                  children: [
                    Icon(Icons.copy),
                    SizedBox(width: 8),
                    Text('Copy URL'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Obx(() {
        if (webController.hasError) {
          return _buildErrorWidget(context, webController);
        }
        
        if (webController.isWebViewLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return WebViewWidget(controller: webController.webViewController);
      }),
    );
  }

  Widget _buildErrorWidget(BuildContext context, WebController webController) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to Load',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 200,
              child: Text(
                "Please try again.",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                fixedSize: Size(180, 48),
              ),
              onPressed: webController.reload,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                fixedSize: Size(180, 48),
              ),
              onPressed: webController.openInExternalBrowser,
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open in Browser'),
            ),
          ],
        ),
      ),
    );
  }
}