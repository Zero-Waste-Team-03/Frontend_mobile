import 'package:flutter/material.dart';
import 'package:maplibre_gl/maplibre_gl.dart';

import '../env.dart';

class MapConfig {
  static const String _mapTilerStyleBaseUrl =
      'https://api.maptiler.com/maps/streets-v2/style.json';
  static const String _fallbackStyleUrl =
      'https://basemaps.cartocdn.com/gl/positron-gl-style/style.json';

  static const String _mapTilerStyleDarkUrl =
      'https://api.maptiler.com/maps/streets-v2-dark/style.json';
  static const String _fallbackStyleDarkUrl =
      'https://basemaps.cartocdn.com/gl/brunner-gl-style/style.json';

  static String get mapTilerApiKey =>
      (Env.get('MAPTILER_API_KEY') ?? '').trim();

  static String get styleUrl {
    final key = mapTilerApiKey;
    if (key.isEmpty) {
      return _fallbackStyleUrl;
    }
    return '$_mapTilerStyleBaseUrl?key=${Uri.encodeQueryComponent(key)}';
  }

  static String getStyleUrl(Brightness brightness) {
    final key = mapTilerApiKey;

    if (brightness == Brightness.dark) {
      if (key.isEmpty) return _fallbackStyleDarkUrl;
      return '$_mapTilerStyleDarkUrl?key=${Uri.encodeQueryComponent(key)}';
    } else {
      if (key.isEmpty) return _fallbackStyleUrl;
      return '$_mapTilerStyleBaseUrl?key=${Uri.encodeQueryComponent(key)}';
    }
  }

  static double get defaultLatitude =>
      double.tryParse((Env.get('MAP_DEFAULT_LATITUDE') ?? '').trim()) ?? 0.0;

  static double get defaultLongitude =>
      double.tryParse((Env.get('MAP_DEFAULT_LONGITUDE') ?? '').trim()) ?? 0.0;

  static double get defaultZoom =>
      double.tryParse((Env.get('MAP_DEFAULT_ZOOM') ?? '').trim()) ?? 15.0;

  static LatLng get defaultTarget => LatLng(defaultLatitude, defaultLongitude);

  static CameraPosition cameraPosition({LatLng? target, double? zoom}) {
    return CameraPosition(
      target: target ?? defaultTarget,
      zoom: zoom ?? defaultZoom,
    );
  }
}
