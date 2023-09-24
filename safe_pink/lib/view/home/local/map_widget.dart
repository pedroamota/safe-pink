import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_pink/database/servicesDB.dart';
import 'package:safe_pink/services/auth_service.dart';
import 'package:safe_pink/services/position_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final position = Provider.of<PositionService>(context, listen: false);
    final auth = Provider.of<AuthService>(context, listen: false);
    final db = ServicesDB(auth: auth);
    db.saveLocal(position.latitude, position.longitude);

    return Container(
      width: size.width * .8,
      height: size.height * .5,
      color: Colors.white,
      child: GoogleMap(
        mapToolbarEnabled: false,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            position.latitude,
            position.longitude,
          ),
          zoom: 13,
        ),
        myLocationEnabled: true,
        markers: {
          const Marker(
            markerId: MarkerId('2'),
            position: LatLng(-22.2522, -45.7037),
            infoWindow: InfoWindow(title: 'Nome da pessoa'),
          ),
          const Marker(
            markerId: MarkerId('1'),
            position: LatLng(-22.2271, -45.9394),
            infoWindow: InfoWindow(title: 'Nome da pessoa'),
          ),
        },
      ),
    );
  }
}
