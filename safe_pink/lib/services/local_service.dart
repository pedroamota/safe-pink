import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class Local {
  Future<Position> getLocation(context) async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    Permission.location.request();

    if (isLocationServiceEnabled) {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
    } else {
      throw Exception('Serviço de localização não habilitado.');
    }
  }
}
