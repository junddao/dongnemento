import 'package:base_project/env.dart';
import 'package:base_project/global/model/auth/request/sign_in_input.dart';
import 'package:base_project/global/model/auth/response/sign_in_result.dart';
import 'package:base_project/global/model/auth/response/sign_out_result.dart';
import 'package:base_project/global/operation/auth/mutation/refresh_sign.dart';
import 'package:base_project/global/operation/auth/mutation/sign_in.dart';
import 'package:base_project/global/operation/auth/mutation/sign_out.dart';
import 'package:base_project/global/repository/common/exception_handler.dart';
import 'package:base_project/global/repository/common/repo_interface.dart';
import 'package:base_project/global/repository/gql_service.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AuthRepository {
  static final AuthRepository instance = AuthRepository._internal();

  factory AuthRepository() {
    return instance;
  }
  AuthRepository._internal();

  String apiUrl = Env.apiAuthUrl;

  Future<DataOrFailure<SignInResult>> signIn(SignInInput signInInput) async {
    final variables = {
      "input": signInInput.toMap()..removeWhere((key, value) => value == null),
    };

    try {
      QueryResult result = await GQLService().mutation(apiUrl, signInSyntax, variables: variables, useToken: false);
      if (DUExceptionHandler().shouldHandleException(result)) {
        var failure = DUExceptionHandler().handleException(result.exception);
        return DataOrFailure.withFailure(failure);
      }
      SignInResult signInResult = SignInResult.fromMap(result.data!);
      return DataOrFailure.withData(signInResult);
    } catch (e) {
      throw Exception('Api Call Error in Repository');
    }
  }

  Future<DataOrFailure<SignOutResult>> signOut() async {
    QueryResult result = await GQLService().mutation(apiUrl, signOutSyntax);
    if (DUExceptionHandler().shouldHandleException(result)) {
      var failure = DUExceptionHandler().handleException(result.exception);
      return DataOrFailure.withFailure(failure);
    }
    SignOutResult signOutResult = SignOutResult.fromMap(result.data!);

    return DataOrFailure.withData(signOutResult);
  }
}
