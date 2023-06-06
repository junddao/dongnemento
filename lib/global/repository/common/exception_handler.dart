import 'dart:convert';

import 'package:base_project/global/repository/common/repo_interface.dart';
import 'package:base_project/global/repository/common/request_error_code.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DUExceptionHandler {
  bool shouldHandleException(QueryResult result) {
    if (result.hasException) {
      var linkException = result.exception!.linkException;
      if (linkException != null && linkException is UnknownException) {
        var originalException = linkException.originalException;
        // Turn off wrong exception throw caused by GraphQL lib
        if (originalException is JsonUnsupportedObjectError
            // && originalException.unsupportedObject is MultipartFile
            ) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  Failure handleException(OperationException? exception) {
    if (exception?.graphqlErrors != null && exception!.graphqlErrors.isNotEmpty) {
      var errMsg = exception.graphqlErrors.elementAt(0).message;
      var failure = failureInstanceFromErrorCode(errMsg);

      return failure;
    }
    if (exception?.linkException != null) {
      if (exception!.linkException is ServerException) {
        return ServerFailure(exception.linkException.toString());
      }
      return InternalFailure(exception.linkException.toString());
    }
    return InternalFailure("Unknown failure!");
  }
}
