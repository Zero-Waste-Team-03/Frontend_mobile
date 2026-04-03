import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class DonationsHomePage extends StatefulWidget {
  const DonationsHomePage({super.key});

  @override
  State<DonationsHomePage> createState() => _DonationsHomePageState();
}

class _DonationsHomePageState extends State<DonationsHomePage> {
  LatLng? _currentPosition;
  bool _isLoadingMap = true;

  @override
  void initState() {
    super.initState();
    _determinePosition();
  }

  Future<void> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _setDefaultPosition();
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _setDefaultPosition();
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _setDefaultPosition();
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      if (mounted) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _isLoadingMap = false;
        });
      }
    } catch (e) {
      _setDefaultPosition();
    }
  }

  void _setDefaultPosition() {
    if (mounted) {
      setState(() {
        _currentPosition = const LatLng(21.4225, 39.8262); // Mecca fallback
        _isLoadingMap = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoadingMap
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              options: MapOptions(
                initialCenter: _currentPosition!,
                initialZoom: 13.0,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.zerowaste.zerowaste',
                ),
              ],
            ),
    );
  }
}
