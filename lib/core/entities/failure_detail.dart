import '../failures/app_failures.dart';

class FailureDetail {
  final String? title;
  final String? description;

  FailureDetail({this.title, this.description});

  factory FailureDetail.fromAppFailure(AppFailure failure) {
    return failure.map(
        noInternetConnection: (f) =>
            FailureDetail(title: 'No internet!', description: f.message),
        badRequest: (f) => FailureDetail(description: f.message),
        unAuthorized: (f) =>
            FailureDetail(title: 'Unauthorized!', description: f.message),
        unProcessableEntity: (f) =>
            FailureDetail(title: 'Action failed!', description: f.message),
        forbidden: (f) =>
            FailureDetail(title: 'Permission denied!', description: f.message),
        formatNotParsable: (f) => FailureDetail(description: f.message),
        internalServerFailure: (f) => FailureDetail(
            title: 'Something went wrong!', description: f.message),
        cacheFailure: (f) => FailureDetail(description: f.message),
        unknownFailure: (f) => FailureDetail(
            title: 'Something went wrong!', description: f.message),
        timeOutFailure: (f) => FailureDetail(
            title: 'Connection timed out!', description: f.message),
        notFoundFailure: (f) => FailureDetail(
            title: 'Resource not found!', description: f.message));
  }
}
