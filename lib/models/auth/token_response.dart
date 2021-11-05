class TokenResponse {
  final String refresh;
  final String access;

  TokenResponse({required this.refresh, required this.access});

  factory TokenResponse.fromMap(Map<String, dynamic> json) {
    return TokenResponse(refresh: json['refresh'], access: json['access']);
  }

  Map<String, dynamic> toMap() => {"refresh": refresh, "access": access};
}
