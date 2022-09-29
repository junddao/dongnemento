import 'package:base_project/env.dart';
import 'package:base_project/global/model/account/response/me_result.dart';
import 'package:base_project/global/operation/accounts/query/me.dart';
import 'package:base_project/global/repository/common/exception_handler.dart';
import 'package:base_project/global/repository/common/repo_interface.dart';
import 'package:base_project/global/repository/gql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AccountRepository {
  static final AccountRepository instance = AccountRepository._internal();

  factory AccountRepository() {
    return instance;
  }
  AccountRepository._internal();

  String apiUrl = Env.apiAccountUrl;

  Future<DataOrFailure<MeResult>> me() async {
    QueryResult result = await GQLService().query(apiUrl, meSyntax);
    if (DUExceptionHandler().shouldHandleException(result)) {
      var failure = DUExceptionHandler().handleException(result.exception);
      return DataOrFailure.withFailure(failure);
    }
    MeResult meResult = MeResult.fromMap(result.data!);

    return DataOrFailure.withData(meResult);
  }
}
