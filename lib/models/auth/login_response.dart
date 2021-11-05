class LoginResponse {
  String? message;

  LoginResponse({required this.message});

  factory LoginResponse.fromMap(Map<String, dynamic> json) => LoginResponse(
        message: json['message'],
      );

  Map<String, dynamic> toMap() => {
        "message": message,
      };
}
