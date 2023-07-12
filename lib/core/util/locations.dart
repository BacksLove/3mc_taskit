import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:taks_3mc/features/task/data/models/task_model.dart';

Future<Position> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error("Location services are disabled");
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permissions are denied");
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return Future.error(
        "Location permissions are permanently denied, we cannot request permission");
  }

  return await Geolocator.getCurrentPosition();
}

Future<Placemark> getAdressFromLatLong(double lat, double long) async {
  var place = await placemarkFromCoordinates(lat, long);
  return place.first;
}

String addressFormatter(Placemark adress) {
  return "${adress.street}, ${adress.locality} - ${adress.country}";
}

Future<List<TaskModel>> sortTasksByDistance(List<TaskModel> list) async {
  Position currentPosition = await getCurrentLocation();

  list.sort((a, b) {
    double distanceToA = Geolocator.distanceBetween(currentPosition.latitude,
        currentPosition.longitude, a.latitude, a.longitude);
    double distanceToB = Geolocator.distanceBetween(currentPosition.latitude,
        currentPosition.longitude, b.latitude, b.longitude);
    return distanceToA.compareTo(distanceToB);
  });

  return list;
}
