enum AuthErrorEnum {
  none,
  notRegistered,
  badCode,
  unknowError,
}

enum AuthSteps {
  initial,
  loading,
  codeSent,
  loggedIn,
}
