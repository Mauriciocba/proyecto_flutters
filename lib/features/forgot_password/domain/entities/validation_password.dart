import 'dart:convert';

class ValidationEmail {
    final String email;

    ValidationEmail({
        required this.email,
    });

    factory ValidationEmail.fromJson(String str) => ValidationEmail.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory ValidationEmail.fromMap(Map<String, dynamic> json) => ValidationEmail(
        email: json["email"],
    );

    Map<String, dynamic> toMap() => {
        "email": email,
    };
}
