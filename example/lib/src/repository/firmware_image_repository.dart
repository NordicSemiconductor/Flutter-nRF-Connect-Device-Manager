import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:mcumgr_flutter_example/src/model/firmware_image.dart';

class FirmwareImageRepository {
  static const String baseUrl =
      'https://nordicsemiconductor.github.io/nrfprogrammer-firmware-images/';
  String get url => '$baseUrl/manifest.json';

  Future<ApplicationResponse> getFirmwareImages() async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      return ApplicationResponse.fromJson(jsonBody);
    } else {
      throw Exception('Failed to load firmware images');
    }
  }
}
