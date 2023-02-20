import 'package:flutter_riverpod/flutter_riverpod.dart';

class TokenService {
  static final provider = Provider<TokenService>((ref) {
    return TokenService();
  });
  String? token;
}
