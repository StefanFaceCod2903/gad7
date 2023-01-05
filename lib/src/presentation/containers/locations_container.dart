import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:gad7/src/models/index.dart';
import 'package:redux/redux.dart';

class LocationsContainer extends StatelessWidget {
  const LocationsContainer({super.key, required this.builder});

  final ViewModelBuilder<List<UserLocation>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<UserLocation>>(
      converter: (Store<AppState> store) {
        return store.state.location.locations;
      },
      builder: builder,
    );
  }
}
