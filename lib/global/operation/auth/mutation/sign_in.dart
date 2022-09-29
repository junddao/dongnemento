const String signInSyntax = r'''
  mutation Mutation($input: SignInInput!) {
  signIn(input: $input) {
    token
    refreshToken
    expiresIn
  }
}
''';
