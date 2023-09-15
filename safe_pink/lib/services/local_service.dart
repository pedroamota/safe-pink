import 'package:geolocator/geolocator.dart';

class Local{
  Future<Position> getLocation() async {
  bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

  if (isLocationServiceEnabled) {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  } else {
    throw Exception('Serviço de localização não habilitado.');
  }
}

}