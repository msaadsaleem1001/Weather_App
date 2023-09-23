

class AppExceptions implements Exception{
  final String? message;
  AppExceptions([this.message]);
  @override
  String toString(){
    return message.toString();
  }
}

class InternetException extends AppExceptions{
  InternetException([String? message]) : super(message);
}

class RequestTimeOut extends AppExceptions{
  RequestTimeOut([String? message]) : super(message);
}

class ServerException extends AppExceptions{
  ServerException([String? message]) : super(message);
}

class InvalidUrlException extends AppExceptions{
  InvalidUrlException([String? message]) : super(message);
}

class FetchDataException extends AppExceptions{
  FetchDataException([String? message]) : super(message);
}