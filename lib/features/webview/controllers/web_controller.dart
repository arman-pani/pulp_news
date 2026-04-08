import 'package:flutter/services.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:odiya_news_app/core/providers/app_providers.dart';

part 'web_controller.freezed.dart';
part 'web_controller.g.dart';

@freezed
class WebScreenState with _$WebScreenState {
  const factory WebScreenState({
    required String currentUrl,
    required String pageTitle,
    @Default(true) bool isLoading,
    @Default('') String errorMessage,
  }) = _WebScreenState;
}

@riverpod
class WebController extends _$WebController {
  late final WebViewController webViewController;

  @override
  WebScreenState build(String initialUrl, String initialTitle) {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            state = state.copyWith(
              isLoading: true,
              errorMessage: '',
              currentUrl: url,
            );
          },
          onPageFinished: (url) async {
            state = state.copyWith(isLoading: false, currentUrl: url);
            await _updatePageTitle();
          },
          onWebResourceError: (error) {
            state = state.copyWith(
              isLoading: false,
              errorMessage: 'Failed to load page: ${error.description}',
            );
          },
        ),
      );

    Future.microtask(() => loadNewUrl(initialUrl, initialTitle));

    return WebScreenState(currentUrl: initialUrl, pageTitle: initialTitle);
  }

  void reload() {
    state = state.copyWith(errorMessage: '');
    webViewController.reload();
  }

  void loadNewUrl(String url, String title) {
    state = state.copyWith(
      currentUrl: url,
      pageTitle: title,
      isLoading: true,
      errorMessage: '',
    );
    webViewController.clearCache();
    webViewController.loadRequest(Uri.parse(url));
  }

  void goBack() => webViewController.goBack();

  void goForward() => webViewController.goForward();

  Future<void> openInExternalBrowser() async {
    try {
      final url = Uri.parse(state.currentUrl);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      ref
          .read(appSnackbarServiceProvider)
          .showError('Failed to open in external browser: $e');
    }
  }

  void copyUrl() {
    Clipboard.setData(ClipboardData(text: state.currentUrl));
    ref.read(appSnackbarServiceProvider).showSuccess('URL copied to clipboard');
  }

  Future<void> _updatePageTitle() async {
    try {
      final title = await webViewController.getTitle();
      if (title != null && title.isNotEmpty) {
        state = state.copyWith(pageTitle: title);
      }
    } catch (_) {}
  }
}
