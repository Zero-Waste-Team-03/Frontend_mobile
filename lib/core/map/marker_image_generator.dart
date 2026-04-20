import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

import '../enums/donation_urgency_value.dart';
import 'widgets/donation_marker_widget.dart';

class MarkerRenderException implements Exception {
  final String message;

  const MarkerRenderException(this.message);

  @override
  String toString() => 'MarkerRenderException: $message';
}

class MarkerImageGenerator {
  static Future<Uint8List> generate({
    required DonationUrgencyValue urgency,
    required String label,
    required double pixelRatio,
  }) async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      final view = WidgetsBinding.instance.platformDispatcher.views.first;
      final repaintBoundary = RenderRepaintBoundary();
      final renderView = RenderView(
        view: view,
        configuration: ViewConfiguration.fromView(view),
        child: RenderPositionedBox(
          alignment: Alignment.center,
          child: repaintBoundary,
        ),
      );

      final pipelineOwner = PipelineOwner();
      final buildOwner = BuildOwner(focusManager: FocusManager());

      pipelineOwner.rootNode = renderView;
      renderView.prepareInitialFrame();

      final rootElement = RenderObjectToWidgetAdapter<RenderBox>(
        container: repaintBoundary,
        child: Directionality(
          textDirection: TextDirection.ltr,
          child: MediaQuery(
            data: MediaQueryData.fromView(view),
            child: DonationMarkerWidget(urgency: urgency, label: label),
          ),
        ),
      ).attachToRenderTree(buildOwner);

      buildOwner.buildScope(rootElement);
      buildOwner.finalizeTree();

      pipelineOwner.flushLayout();
      pipelineOwner.flushCompositingBits();
      pipelineOwner.flushPaint();

      final image = await repaintBoundary.toImage(pixelRatio: pixelRatio);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      image.dispose();

      if (byteData == null) {
        throw const MarkerRenderException('Failed to encode marker image.');
      }

      return byteData.buffer.asUint8List();
    } catch (error) {
      if (error is MarkerRenderException) {
        rethrow;
      }
      throw MarkerRenderException(error.toString());
    }
  }
}
