import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gad7/src/models/index.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

class LocationApi {
  LocationApi(this.firestore, {required this.location});

  final Location location;
  final FirebaseFirestore firestore;

  Stream<void> getLocation(String uid) async* {
    PermissionStatus permission = await location.hasPermission();
    if (permission == PermissionStatus.denied || permission == PermissionStatus.deniedForever) {
      permission = await location.requestPermission();

      if (permission == PermissionStatus.denied || permission == PermissionStatus.deniedForever) {
        yield const Stream<void>.empty();
        return;
      }
    }

    yield location.onLocationChanged.startWith(await location.getLocation()).map((LocationData result) {
      return UserLocation(
        uid: uid,
        lat: result.latitude ?? 0.0,
        lng: result.longitude ?? 0.0,
      );
    }).asyncMap((UserLocation userLocation) {
      return firestore.collection('locations').doc(uid).set(userLocation.toJson());
    });
  }

  Stream<List<UserLocation>> listenLocations() {
    return firestore.collection('locations').snapshots().map((QuerySnapshot<Map<String, dynamic>> snapshot) {
      return snapshot.docs
          .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => UserLocation.fromJson(doc.data()))
          .toList();
    });
  }
}
