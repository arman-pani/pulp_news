import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:odiya_news_app/video_feed/video_feed_controller.dart';
import 'package:video_player/video_player.dart';
// Import your controller file here

class VideoFeedScreen extends StatelessWidget {
  // Inject the controller
  final VideoFeedController controller = Get.put(VideoFeedController());

  VideoFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: controller.videoUrls.length,
        onPageChanged: controller.onPageChanged,
        itemBuilder: (context, index) {
          // Use Obx to listen for changes specifically for this index
          return Obx(() {
            // Check if this specific index is initialized
            bool isInitialized = controller.initializedIndexes.contains(index);
            VideoPlayerController? videoController = controller.getController(
              index,
            );

            if (!isInitialized || videoController == null) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.white),
              );
            }

            return Stack(
              fit: StackFit.expand,
              children: [
                // 1. The Video Player
                GestureDetector(
                  onTap: () {
                    videoController.value.isPlaying
                        ? videoController.pause()
                        : videoController.play();
                  },
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: videoController.value.aspectRatio,
                      child: VideoPlayer(videoController),
                    ),
                  ),
                ),

                // 2. Overlay Info (Right Side Buttons)
                Positioned(
                  right: 10,
                  bottom: 100,
                  child: Column(
                    spacing: 20,
                    children: [
                      _buildIconButton(Icons.favorite, "25K"),
                      _buildIconButton(Icons.comment, "104"),
                      _buildIconButton(Icons.share, "Share"),
                    ],
                  ),
                ),

                // 3. Overlay Info (Bottom Text)
                const Positioned(
                  left: 20,
                  bottom: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "@Username",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "This is a cool video description! #flutter #getx",
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 35),
        const SizedBox(height: 5),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ],
    );
  }
}
