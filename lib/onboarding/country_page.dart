import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';

class IndiaMapPage extends StatefulWidget {
  const IndiaMapPage({super.key});

  @override
  State<IndiaMapPage> createState() => _IndiaMapPageState();
}

class _IndiaMapPageState extends State<IndiaMapPage> {
  String? _svgRaw;
  Map<String, String> _statePaths = {};
  String? _selectedStateId;

  // Valid state codes - only these will be interactive
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
  void initState() {
    super.initState();
    _loadSvg();
  }

  Future<void> _loadSvg() async {
    final raw = await rootBundle.loadString('assets/in.svg');
    final extracted = _extractStatePaths(raw);
    setState(() {
      _svgRaw = raw;
      _statePaths = extracted;
    });
  }

  Map<String, String> _extractStatePaths(String svg) {
    final map = <String, String>{};
    final viewBoxRegex = RegExp(r'<svg[^>]*viewBox="([^"]+)"', multiLine: true);
    final vbMatch = viewBoxRegex.firstMatch(svg);
    final viewBox = vbMatch?.group(1) ?? '0 0 1000 1000';

    // Only extract <path> elements with valid state IDs
    // This avoids picking up <circle> elements from label_points group
    final pathRegex = RegExp(
      r'<path[^>]*id="([^"]+)"[^>]*(?:/>|>[\s\S]*?</path>)',
      multiLine: true,
    );

    for (final m in pathRegex.allMatches(svg)) {
      final id = m.group(1)!;
      // Only include paths with valid state codes
      if (!_validStateCodes.contains(id)) continue;

      final pathTag = m.group(0)!;
      final wrapped =
          '<svg xmlns="http://www.w3.org/2000/svg" viewBox="$viewBox">$pathTag</svg>';
      map[id] = wrapped;
    }

    // Don't process groups - they may contain label circles, not actual boundaries
    return map;
  }

  String _colorizedSvg(
    String svgWrapped,
    Color fillColor, {
    bool selected = false,
  }) {
    var s = svgWrapped;
    final hex = '#${fillColor.value.toRadixString(16).substring(2)}';

    // Always apply fill
    if (s.contains('fill="')) {
      s = s.replaceAll(RegExp(r'fill="[^"]*"'), 'fill="$hex"');
    } else {
      s = s.replaceFirstMapped(
        RegExp(r'(<path\b[^>]*)(\/?>)'),
        (m) => '${m.group(1)} fill="$hex"${m.group(2)}',
      );
    }

    // White stroke for borders
    if (s.contains('stroke="')) {
      s = s.replaceAll(RegExp(r'stroke="[^"]*"'), 'stroke="#FFFFFF"');
      s = s.replaceAll(RegExp(r'stroke-width="[^"]*"'), 'stroke-width="1"');
    } else {
      s = s.replaceFirstMapped(
        RegExp(r'(<path\b[^>]*)(\/?>)'),
        (m) => '${m.group(1)} stroke="#FFFFFF" stroke-width="1"${m.group(2)}',
      );
    }

    // Highlight selected state
    if (selected) {
      s = s.replaceAll('stroke-width="1"', 'stroke-width="2.5"');
      s = s.replaceAll('stroke="#FFFFFF"', 'stroke="#000000"');
    }

    return s;
  }

  void _onTapState(String id) {
    setState(() => _selectedStateId = id);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected State: $id'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget _buildMap() {
    if (_svgRaw == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_statePaths.isEmpty) {
      return const Center(child: Text('No state paths found'));
    }

    final children = _statePaths.entries.mapIndexed((i, entry) {
      final id = entry.key;
      final svgWrapped = entry.value;
      final isSelected = _selectedStateId == id;

      final color = isSelected
          ? Colors.blue.shade800
          : Colors.lightBlue.shade400;
      final svgWithFill = _colorizedSvg(
        svgWrapped,
        color,
        selected: isSelected,
      );

      return Positioned.fill(
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          onTap: () => _onTapState(id),
          child: SvgPicture.string(
            svgWithFill,
            fit: BoxFit.contain,
            allowDrawingOutsideViewBox: true,
          ),
        ),
      );
    }).toList();

    return InteractiveViewer(
      minScale: 0.7,
      maxScale: 10,
      boundaryMargin: const EdgeInsets.all(200),
      child: AspectRatio(aspectRatio: 1, child: Stack(children: children)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Interactive India Map'),
        centerTitle: true,
      ),
      body: Center(child: _buildMap()),
      bottomNavigationBar: _selectedStateId != null
          ? Container(
              height: 50,
              color: Colors.blue.shade50,
              alignment: Alignment.center,
              child: Text(
                'Selected: $_selectedStateId',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : null,
    );
  }
}