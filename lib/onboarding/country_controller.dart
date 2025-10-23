import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odiya_news_app/constants/app_colors.dart';
import 'package:xml/xml.dart';
import 'package:svg_path_parser/svg_path_parser.dart';

class StatePathData {
  final String id;
  final String name;
  final Path path;

  StatePathData({required this.id, required this.name, required this.path});
}

class Language {
  final String code;
  final String name;
  final String nativeName;

  Language({required this.code, required this.name, required this.nativeName});
}

class CountryController extends GetxController {
  // Observable variables
  final RxList<StatePathData> statePaths = <StatePathData>[].obs;
  final RxString? selectedStateId = RxString("");
  final Rx<Size?> svgViewBox = Rx<Size?>(null);
  final RxBool isLoading = true.obs;
  final RxString? selectedLanguage = RxString("");

  // Language data for different states
  final Map<String, List<Language>> stateLanguages = {
    'INOR': [
      // Odisha
      Language(code: 'or', name: 'Odia', nativeName: 'ଓଡ଼ିଆ'),
      Language(code: 'en', name: 'English', nativeName: 'English'),
    ],
    'INWB': [
      // West Bengal
      Language(code: 'bn', name: 'Bengali', nativeName: 'বাংলা'),
      Language(code: 'en', name: 'English', nativeName: 'English'),
    ],
    'INTG': [
      // Telangana
      Language(code: 'te', name: 'Telugu', nativeName: 'తెలుగు'),
      Language(code: 'en', name: 'English', nativeName: 'English'),
    ],
  };

  final Set<String> _validStateCodes = {
    'INAN',
    'INAP',
    'INAR',
    'INAS',
    'INBR',
    'INCH',
    'INCT',
    'INDH',
    'INDL',
    'INGA',
    'INGJ',
    'INHP',
    'INHR',
    'INJH',
    'INJK',
    'INKA',
    'INKL',
    'INLA',
    'INLD',
    'INMH',
    'INML',
    'INMN',
    'INMP',
    'INMZ',
    'INNL',
    'INOR',
    'INPB',
    'INPY',
    'INRJ',
    'INSK',
    'INTG',
    'INTN',
    'INTR',
    'INUP',
    'INUT',
    'INWB',
  };

  @override
  void onInit() {
    super.onInit();
    loadSvgPaths();
  }

  Future<void> loadSvgPaths() async {
    try {
      final svgString = await rootBundle.loadString('assets/in.svg');
      final document = XmlDocument.parse(svgString);

      // Get viewBox for proper scaling
      final svgElement = document.findElements('svg').first;
      final viewBoxStr = svgElement.getAttribute('viewBox') ?? '0 0 1000 1000';
      final viewBoxParts = viewBoxStr.split(' ').map(double.parse).toList();
      svgViewBox.value = Size(viewBoxParts[2], viewBoxParts[3]);

      final statePathsList = <StatePathData>[];

      // Find all path elements with valid state IDs
      for (var pathElement in document.findAllElements('path')) {
        final id = pathElement.getAttribute('id');
        final name = pathElement.getAttribute('name') ?? id ?? 'Unknown';
        final d = pathElement.getAttribute('d');

        // Only process paths with valid state codes
        if (id != null && d != null && _validStateCodes.contains(id)) {
          try {
            final path = parseSvgPath(d);
            statePathsList.add(StatePathData(id: id, name: name, path: path));
          } catch (e) {
            debugPrint('Error parsing path for $id: $e');
          }
        }
      }

      statePaths.value = statePathsList;
      isLoading.value = false;

      debugPrint('Loaded ${statePathsList.length} states');
    } catch (e) {
      debugPrint('Error loading SVG: $e');
      isLoading.value = false;
    }
  }

  void selectState(String stateId, String stateName) {
    selectedStateId?.value = stateId;
    selectedLanguage?.value = ""; // Reset language selection when state changes
  }

  void handleMapTap(TapDownDetails details, Size canvasSize, BuildContext context) {
    final svgViewBox = this.svgViewBox.value!;
    
    // Calculate transformation parameters
    final scale = (canvasSize.width / svgViewBox.width).clamp(0.0, canvasSize.height / svgViewBox.height);
    final offsetX = (canvasSize.width - svgViewBox.width * scale) / 2;
    final offsetY = (canvasSize.height - svgViewBox.height * scale) / 2;

    // Convert tap position to SVG coordinates
    final svgX = (details.localPosition.dx - offsetX) / scale;
    final svgY = (details.localPosition.dy - offsetY) / scale;

    // Find tapped state
    for (var stateData in statePaths.reversed) {
      if (stateData.path.contains(Offset(svgX, svgY))) {
        if (isStateSupported(stateData.id)) {
          selectState(stateData.id, stateData.name);
        } else {
          showComingSoonSnackBar(stateData.name, context);
        }
        return;
      }
    }
  }

  Size calculateMapSize(BoxConstraints constraints) {
    final svgViewBox = this.svgViewBox.value!;
    final aspectRatio = svgViewBox.width / svgViewBox.height;
    
    double width = constraints.maxWidth * 0.95;
    double height = width / aspectRatio;
    
    if (height > constraints.maxHeight * 0.95) {
      height = constraints.maxHeight * 0.95;
      width = height * aspectRatio;
    }
    
    return Size(width, height);
  }

  void showComingSoonSnackBar(String stateName, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Language support for $stateName is coming soon!'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.primaryOrange,
        action: SnackBarAction(
          label: 'OK',
          textColor: AppColors.white,
          onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
        ),
      ),
    );
  }

  void selectLanguage(String languageCode) {
    selectedLanguage?.value = languageCode;
  }

  bool isStateSupported(String stateId) {
    return stateLanguages.containsKey(stateId);
  }

  List<Language> getAvailableLanguages() {
    if (selectedStateId?.value == null) return [];

    final languages = stateLanguages[selectedStateId?.value];
    return languages ?? [];
  }

  String? getSelectedStateName() {
    if (selectedStateId?.value == null) return null;
    final state = statePaths.firstWhereOrNull(
      (s) => s.id == selectedStateId?.value,
    );
    return state?.name;
  }

  bool get canProceed {
    return selectedStateId?.value != null &&
        selectedLanguage?.value != null &&
        selectedLanguage?.value != "";
  }

  void proceedToNext() {
    if (canProceed) {
      // TODO: Navigate to next page
      debugPrint(
        'Proceeding with state: ${selectedStateId?.value}, language: ${selectedLanguage?.value}',
      );
    }
  }
}
