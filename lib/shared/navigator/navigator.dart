import 'package:url_launcher/url_launcher.dart';

Future<void> openNavigation(
  double latitude,
  double longitude,
) async {
  final uri = Uri.parse(
    'https://www.google.com/maps/dir/?api=1'
    '&destination=$latitude,$longitude'
    '&travelmode=driving',
  );

  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}

Future<void> callPhoneNumber(String phoneNumber) async {
  final uri = Uri.parse('tel:$phoneNumber');

  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}