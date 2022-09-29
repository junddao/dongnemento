const String refreshSighSyntax = r'''
mutation RefreshSign($input: RefreshSignInput!) {
  refreshSign(input: $input) {
    token
    refreshToken
    expiresIn
  }
}
''';
