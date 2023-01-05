library actions;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gad7/src/models/index.dart';

part 'auth/login.dart';
part 'index.freezed.dart';
part 'auth/logout.dart';
part 'auth/create_user.dart';
part 'auth/get_user.dart';
part 'get_location.dart';
part 'listen_for_locations.dart';
part 'listen_for_users.dart';

typedef ActionResponse = void Function(dynamic action);
