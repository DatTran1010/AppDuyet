import 'package:flutter_riverpod/flutter_riverpod.dart';

class Token {
  String? token;
  DateTime? expires;
  Token();
}

class TokenNotifier extends StateNotifier<Token> {
  TokenNotifier() : super(Token());

  void setToken(String token, DateTime expires) {
    state.token = token;
    state.expires = expires;
  }

  void removeToken() {
    state.token = null;
    state.expires = null;
  }
}

final tokenProvider =
    StateNotifierProvider<TokenNotifier, Token>((ref) => TokenNotifier());
