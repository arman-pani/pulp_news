
import 'package:flutter/material.dart';
import 'package:odiya_news_app/constants/app_colors.dart';
import 'package:odiya_news_app/onboarding/country_controller.dart';

class InteractiveIndiaMap extends StatelessWidget {
  final CountryController controller;

  const InteractiveIndiaMap({
    super.key,
    required this.controller,
  });


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final mapSize = controller.calculateMapSize(constraints);

        return GestureDetector(
          onTapDown: (details) => controller.handleMapTap(details, mapSize, context),
          child: Container(
            width: mapSize.width,
            height: mapSize.height,
            color: AppColors.grey50,
            child: CustomPaint(
              size: mapSize,
              painter: IndiaMapPainter(
                selectedStateId: controller.selectedStateId?.value,
                controller: controller,
              ),
            ),
          ),
        );
      },
    );
  }
}

class IndiaMapPainter extends CustomPainter {
  final String? selectedStateId;
  final CountryController controller;

  IndiaMapPainter({
    required this.selectedStateId,
    required this.controller,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Calculate scale to fit the SVG viewBox into the canvas size
    final scaleX = size.width / controller.svgViewBox.value!.width;
    final scaleY = size.height / controller.svgViewBox.value!.height;
    final scale = scaleX < scaleY ? scaleX : scaleY;

    // Center the map
    final offsetX = (size.width - controller.svgViewBox.value!.width * scale) / 2;
    final offsetY = (size.height - controller.svgViewBox.value!.height * scale) / 2;

    // Save canvas state
    canvas.save();
    canvas.translate(offsetX, offsetY);
    canvas.scale(scale);

    // Draw each state
    for (var stateData in controller.statePaths) {
      final isSelected = stateData.id == selectedStateId;
      final isSupported = controller.isStateSupported(stateData.id);

      // Define fill paint based on support status
      Color fillColor;
      if (isSelected) {
        fillColor = AppColors.primaryOrange;
      } else if (isSupported) {
        fillColor = AppColors.primaryOrangeLight;
      } else {
        fillColor = AppColors.accentOrange; // Light orange for unsupported states
      }

      final fillPaint = Paint()
        ..color = fillColor
        ..style = PaintingStyle.fill;

      // Define stroke paint
      final strokePaint = Paint()
        ..color = isSelected ? AppColors.primaryOrangeDark : AppColors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = isSelected ? 1.0 / scale : 0.5 / scale;

      // Draw the state
      canvas.drawPath(stateData.path, fillPaint);
      canvas.drawPath(stateData.path, strokePaint);
    }

    canvas.restore();
  }

  @override
  bool shouldRepaint(IndiaMapPainter oldDelegate) {
    return oldDelegate.selectedStateId != selectedStateId;
  }
}