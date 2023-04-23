import 'package:location/location.dart';

class LocationsHelper {
  late double latitude;
  late double longitude;
  String? city = null;

  Future<void> getCurrentLocation() async {
    Location location = Location();
    bool _servisEnable;
    PermissionStatus _permissionStatus;
    LocationData? _locationData;

    // Lokasyon servisi ayakta mı?
    _servisEnable = await location.serviceEnabled();
    if (!_servisEnable) {
      _servisEnable = await location.requestService();
      if (!_servisEnable) return;
    }

    // Kullanıcı izni kontrolü
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == PermissionStatus.denied) {
      _permissionStatus = await location.requestPermission();
      if (_permissionStatus == PermissionStatus.granted) {
        return;
      }
    }

    // İzinler tamam ise, konum verisini al
    _locationData = await location.getLocation();
    if (_locationData != null) {
      latitude = _locationData.latitude ?? 0;
      longitude = _locationData.longitude ?? 0;
    } else {
      // _locationData null ise yapılacak işlemler
      return;
    }
  }
}
