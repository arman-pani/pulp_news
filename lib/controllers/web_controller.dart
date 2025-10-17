import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebController extends GetxController {
  late final WebViewController webViewController;
  
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final RxString currentUrl = ''.obs;
  final RxString pageTitle = ''.obs;
  
  final String initialUrl;
  final String initialTitle;

  WebController({
    required this.initialUrl,
    required this.initialTitle,
  });

  @override
  void onInit() {
    super.onInit();
    currentUrl.value = initialUrl;
    pageTitle.value = initialTitle;
    _initializeWebView();
  }

  void _initializeWebView() {
    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isLoading.value = true;
            errorMessage.value = '';
            currentUrl.value = url;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
            currentUrl.value = url;
            _updatePageTitle();
          },
          onWebResourceError: (WebResourceError error) {
            isLoading.value = false;
            errorMessage.value = 'Failed to load page: ${error.description}';
          },
        ),
      )
      ..loadRequest(Uri.parse(initialUrl));
  }

  Future<void> _updatePageTitle() async {
    try {
      final title = await webViewController.getTitle();
      if (title != null && title.isNotEmpty) {
        pageTitle.value = title;
      }
    } catch (e) {
      debugPrint('Error getting page title: $e');
    }
  }

  void reload() {
    errorMessage.value = '';
    webViewController.reload();
  }

  void goBack() {
    webViewController.goBack();
  }

  void goForward() {
    webViewController.goForward();
  }

  Future<void> openInExternalBrowser() async {
    try {
      final Uri url = Uri.parse(currentUrl.value);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      _showSnackBar('Failed to open in external browser: $e', isError: true);
    }
  }

  void copyUrl() {
    Clipboard.setData(ClipboardData(text: currentUrl.value));
    _showSnackBar('URL copied to clipboard');
  }

  void _showSnackBar(String message, {bool isError = false}) {
    Get.snackbar(
      isError ? 'Error' : 'Success',
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError 
          ? Get.theme.colorScheme.error
          : Get.theme.colorScheme.surface,
      colorText: isError 
          ? Get.theme.colorScheme.onError
          : Get.theme.colorScheme.onSurface,
      duration: const Duration(seconds: 3),
    );
  }

  // Getters for UI state
  Future<bool> get canGoBack => webViewController.canGoBack();
  Future<bool> get canGoForward => webViewController.canGoForward();
  bool get hasError => errorMessage.value.isNotEmpty;
  bool get isWebViewLoading => isLoading.value;
}