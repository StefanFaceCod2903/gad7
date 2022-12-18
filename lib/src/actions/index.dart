library actions;

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:gad7/src/models/index.dart';

part 'login.dart';
part 'index.freezed.dart';
part 'logout.dart';
part 'create_user.dart';

typedef ActionResponse = void Function(dynamic action);
