import 'dart:async';

import 'package:base_project/env.dart';
import 'package:base_project/global/bloc/auth/authentication/authentication_bloc.dart';
import 'package:base_project/global/model/auth/response/sign_in_result.dart';
import 'package:base_project/global/operation/auth/mutation/refresh_sign.dart';
import 'package:base_project/global/service/secure_storage/secure_storage.dart';
import 'package:base_project/global/util/simple_logger.dart';

import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:synchronized/synchronized.dart';

class GQLService {
  static Lock lock = Lock();
  Future<QueryResult> query(
    String apiUrl,
    String query, {
    Map<String, dynamic> variables = const {},
    bool cache = false,
    bool useToken = true,
  }) async {
    var syncResult = lock.synchronized(() async {
      logger.d('query');
      String? token;
      if (useToken) token = await _getAuthorizationToken();
      QueryOptions options = QueryOptions(
        document: gql(query),
        variables: variables,
      );
      QueryResult result;
      result = await _client(apiUrl, token).query(options).timeout(const Duration(seconds: 5));
      if (result.hasException) {
        String errMsg = result.exception?.graphqlErrors.first.message ?? '';
        if (errMsg.compareTo('SIGNATURE_DOES_NOT_EXIST') == 0) {
          SignIn? signIn = await getRefreshToken();
          if (signIn == null) {
            return result;
          } else {
            final newToken = await _getAuthorizationToken();
            result = await _client(apiUrl, newToken).query(options).timeout(
                  const Duration(seconds: 5),
                );
          }
        }
      }
      return result;
    });
    return syncResult;
  }

  Future<QueryResult> mutation(
    String apiUrl,
    String query, {
    Map<String, dynamic> variables = const {},
    bool useToken = true,
  }) async {
    var syncResult = lock.synchronized(() async {
      logger.d('mutation');
      String? token;
      if (useToken) token = await _getAuthorizationToken();
      QueryResult result;
      MutationOptions options = MutationOptions(document: gql(query), variables: variables);
      result = await _client(apiUrl, token).mutate(options).timeout(const Duration(seconds: 5));

      if (result.hasException) {
        String errMsg = result.exception?.graphqlErrors.first.message ?? '';
        if (errMsg.compareTo('SIGNATURE_DOES_NOT_EXIST') == 0) {
          SignIn? signIn = await getRefreshToken();
          if (signIn == null) {
            logger.d('refresh token expired');
            return result;
          } else {
            final newToken = await _getAuthorizationToken();
            result = await _client(apiUrl, newToken).mutate(options).timeout(
                  const Duration(seconds: 5),
                );
          }
        }
      }

      return result;
    });
    return syncResult;
  }

  GraphQLClient _client(String apiUrl, String? token) {
    //logger.d("API End Point $apiUrl");

    late HttpLink link;
    if (token != null) {
      link = HttpLink(apiUrl, defaultHeaders: {"Authorization": token});
    } else {
      link = HttpLink(apiUrl);
    }
    var cache = GraphQLCache();
    var client = GraphQLClient(cache: cache, link: link);

    return client;
  }

  Future<String?> _getAuthorizationToken() async {
    SignIn? result = await SecureStorage.instance.readToken();
    logger.d(result?.expiresIn);
    logger.d(result?.token);
    return result?.token;
  }

  Future<SignIn?> getRefreshToken() async {
    var jwt = await SecureStorage.instance.readToken();
    final variables = {
      "input": {
        "refreshToken": jwt?.refreshToken,
      },
    };

    String key = "refreshSign";

    String? token = await _getAuthorizationToken();
    QueryResult result;
    MutationOptions options = MutationOptions(document: gql(refreshSighSyntax), variables: variables);
    result = await _client(Env.apiAuthUrl, token).mutate(options).timeout(const Duration(seconds: 5));

    if (result.hasException) {
      return null;
    } else {
      var data = result.data![key];
      final SignIn refreshSignIn = SignIn.fromMap(data!);
      SecureStorage.instance.writeToken(refreshSignIn);
      return refreshSignIn;
    }
  }
}
