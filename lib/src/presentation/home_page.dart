import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gad7/src/actions/index.dart';
import 'package:gad7/src/models/index.dart';
import 'package:gad7/src/presentation/containers/locations_container.dart';
import 'package:gad7/src/presentation/containers/user_container.dart';
import 'package:gad7/src/presentation/containers/users_container.dart';
import 'package:gad7/src/secrets.dart';
import 'package:latlong2/latlong.dart';
import 'package:redux/redux.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MapController _controller = MapController();

  late Store<AppState> _store;
  @override
  void initState() {
    _store = StoreProvider.of<AppState>(context, listen: false)
      ..dispatch(const GetLocation.start())
      ..dispatch(const ListenForLocationsStart());
    super.initState();
  }

  @override
  void dispose() {
    _store.dispatch(const ListenForLocations.done());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UsersContainer(
      builder: (BuildContext context, List<AppUser> users) {
        return LocationsContainer(
          builder: (BuildContext context, List<UserLocation> locations) {
            return UserContainer(
              builder: (BuildContext context, AppUser? user) {
                final UserLocation? currentUserLocation =
                    locations.firstWhereOrNull((UserLocation location) => location.uid == user!.uid);
                return Scaffold(
                  appBar: AppBar(
                    title: Text(user!.displayName),
                    actions: <Widget>[
                      IconButton(
                        onPressed: () {
                          StoreProvider.of<AppState>(context).dispatch(const Logout());
                        },
                        icon: const Icon(Icons.power_settings_new),
                      )
                    ],
                  ),
                  body: currentUserLocation == null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Stack(
                          children: <Widget>[
                            FlutterMap(
                              mapController: _controller,
                              options: MapOptions(
                                center: LatLng(
                                  currentUserLocation.lat!,
                                  currentUserLocation.lng!,
                                ),
                              ),
                              children: <Widget>[
                                TileLayer(
                                  urlTemplate: apiUrl,
                                  additionalOptions: const <String, String>{'access_token': accessToken},
                                ),
                                MarkerLayer(
                                  markers: <Marker>[
                                    for (UserLocation location in locations)
                                      Marker(
                                        point: LatLng(
                                          location.lat!,
                                          location.lng!,
                                        ),
                                        builder: (BuildContext context) {
                                          return GestureDetector(
                                            onTap: () {
                                              final AppUser? locationUser =
                                                  users.firstWhereOrNull((AppUser user) => user.uid == location.uid);
                                              if (locationUser == null) {
                                                return;
                                              }
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(content: Text(locationUser.displayName)));
                                            },
                                            child: Icon(
                                              Icons.location_city,
                                              color: location.uid == user.uid ? Colors.red : Colors.white,
                                            ),
                                          );
                                        },
                                      )
                                  ],
                                )
                              ],
                            ),
                            SafeArea(
                              child: Align(
                                alignment: AlignmentDirectional.bottomStart,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.add),
                                      color: Colors.red,
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(Icons.remove),
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                );
              },
            );
          },
        );
      },
    );
  }
}
