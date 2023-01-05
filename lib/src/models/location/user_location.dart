part of models;

@freezed
class UserLocation with _$UserLocation {
  const factory UserLocation({
    double? lat,
    double? lng,
    String? uid,
  }) = UserLocation$;

  factory UserLocation.fromJson(Map<dynamic, dynamic> json) => _$UserLocationFromJson(Map<String, dynamic>.from(json));
}
