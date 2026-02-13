import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoFeedController extends GetxController {
  // Mock Data: In a real app, this comes from your server
  final List<String> videoUrls = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
  ];

  // Map to store initialized video controllers by index
  final Map<int, VideoPlayerController> _controllers = {};

  // Observable to track if the current video is initialized
  var initializedIndexes = <int>{}.obs; 

  @override
  void onInit() {
    super.onInit();
    // Initialize the first video immediately
    _initializeControllerAtIndex(0).then((_) {
      _playControllerAtIndex(0);
    });
    // Preload the second video for smooth scrolling
    _initializeControllerAtIndex(1);
  }

  VideoPlayerController? getController(int index) {
    return _controllers[index];
  }

  Future<void> _initializeControllerAtIndex(int index) async {
    if (index < 0 || index >= videoUrls.length) return;
    
    // If already initialized, stop
    if (_controllers.containsKey(index)) return;

    // Create new controller
    final controller = VideoPlayerController.networkUrl(Uri.parse(videoUrls[index]));
    _controllers[index] = controller;

    try {
      await controller.initialize();
      controller.setLooping(true);
      initializedIndexes.add(index); // Update UI
    } catch (e) {
      print("Error initializing video at index $index: $e");
    }
  }

  void _playControllerAtIndex(int index) {
    if (_controllers[index] != null && _controllers[index]!.value.isInitialized) {
      _controllers[index]!.play();
    }
  }

  void _stopControllerAtIndex(int index) {
    if (_controllers[index] != null) {
      _controllers[index]!.pause();
    }
  }

  void _disposeControllerAtIndex(int index) {
    if (_controllers[index] != null) {
      _controllers[index]!.dispose();
      _controllers.remove(index);
      initializedIndexes.remove(index);
    }
  }

  // Called when PageView changes pages
  void onPageChanged(int index) {
    // 1. Play current video
    _playControllerAtIndex(index);

    // 2. Stop previous video
    _stopControllerAtIndex(index - 1);
    _stopControllerAtIndex(index + 1);

    // 3. Preload next video
    _initializeControllerAtIndex(index + 1);

    // 4. Dispose videos far away (e.g., 2 steps back) to save RAM
    _disposeControllerAtIndex(index - 2);
    _disposeControllerAtIndex(index + 2);
  }

  @override
  void onClose() {
    // Dispose all when closing the screen
    _controllers.forEach((key, controller) => controller.dispose());
    super.onClose();
  }
}