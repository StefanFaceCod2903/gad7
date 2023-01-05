part of actions;

@freezed
class GetUser with _$GetUser {
  const factory GetUser() = GetUserStart;

  const factory GetUser.successful(AppUser? user) = GetUserSuccessful;

  const factory GetUser.error(Object error, StackTrace stackTrace) = GetUserError;
}
