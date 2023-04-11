abstract class AppFailureMessages {
  /// region - Auth Messages
  static const kFailedToSaveUserLocally =
      'Failed to save the user credentials for future use. Please provide appropriate storage permission to the app.';
  static const kFailedToSignInWithGoogle =
      'Failed to sign in with google. Please try again later.';
  static const kFailedToSignInWithApple =
      'Failed to sign in with apple. Please try again later.';
  static const kFailedToSignInWithFacebook =
      'Failed to sign in with facebook. Please try again later.';
  static const kAccountExistsWithDifferentCredentials =
      'User has already logged in using other social logins. Please login using the same provider used previously.';
  static const kUserDisabled =
      'Unfortunately, your user has been disabled. Please connect with us for more details.';
  static const kProviderAlreadyLinked =
      'This provider has already been linked to the user.';
  static const kProviderAlreadyInUse =
      'The account used already exists or is already linked to a Firebase User.';
  static const kEmailAlreadyInUse =
      'A user with this email already exists. Please try using another email.';
  static const kInvalidCredentials = 'Username or password is not valid.';

  static const kInternalServerError =
      'We are unable to fulfill your request at the time. Please try again later.';
  static const kUnknownError =
      'Something went wrong. We are unable to fulfill your request. Please try again later.';
  static const kNoInternet =
      'You are currently offline. Please try again when internet connection is available.';
  static const kUnauthorized =
      'You have been logged out automatically due to session expiration. Please log in again to continue.';
  static const kUsernameOrPasswordInvalid =
      'The username or password supplied is incorrect. Please correct them and try again.';
  static const kForbidden = 'You do not have access to perform this action.';
  static const kUnProcessableEntity =
      'The request is valid however is not acceptable.';
  static const kNotFound = 'The resource is not found.';
  static const kBadRequest = 'The request is not valid.';
  static const kTimeOut = 'The request timed out. Please try again.';

  /// endregion

  /// region - Verification failure messages
  static const kSendOTPToEmailFailed =
      'Failed to send OTP to provided email. Please try again.';
  static const kEmailVerificationCodeInvalid =
      'The code being used for email verification does not match. Please try again.';
  static const kVerifyOTPSentToEmailFailed =
      'Failed to verify OTP sent to the email. Please try again.';
  static const String kEmailInvalid = 'It must be a valid email address.';
  static const String kEmailVerifyCodeInvalid =
      'Email Verification Code must be a valid 6-digit number.';

  /// endregion

  /// region - Password reset section
  static const kUnableToSendPasswordLink = 'Unable to send link';
  static const kUnableToSendPasswordLinkDetail =
      'We are unable to send the link to reset the password at this moment. Would you like to try again?';

  /// endregion

  /// region - Cache exceptions
  static const kCacheException =
      'Failed to save/retrieve data from local cache.';

  /// endregion - Cache exceptions
}
