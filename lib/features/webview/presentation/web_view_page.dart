import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:odiya_news_app/features/webview/controllers/web_controller.dart';

class WebViewPage extends ConsumerWidget {
  const WebViewPage({super.key, required this.url, required this.title});

  final String url;
  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webState = ref.watch(webControllerProvider(url, title));
    final controller = ref.read(webControllerProvider(url, title).notifier);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(
          webState.currentUrl,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        actionsPadding: const EdgeInsets.only(right: 12.0),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.reload,
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'open_external':
                  controller.openInExternalBrowser();
                  break;
                case 'copy_url':
                  controller.copyUrl();
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'open_external',
                child: Row(
                  children: [
                    Icon(Icons.open_in_browser),
                    SizedBox(width: 8),
                    Text('Open in Browser'),
                  ],
                ),
              ),
              PopupMenuItem(
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
      body: webState.errorMessage.isNotEmpty
          ? SafeArea(top: false, child: _buildErrorWidget(context, controller))
          : webState.isLoading
          ? const SafeArea(
              top: false,
              child: Center(child: CircularProgressIndicator()),
            )
          : SafeArea(
              top: false,
              child: WebViewWidget(controller: controller.webViewController),
            ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, WebController controller) {
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
                'Please try again.',
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
                fixedSize: const Size(180, 48),
              ),
              onPressed: controller.reload,
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(fixedSize: const Size(180, 48)),
              onPressed: controller.openInExternalBrowser,
              icon: const Icon(Icons.open_in_browser),
              label: const Text('Open in Browser'),
            ),
          ],
        ),
      ),
    );
  }
}
