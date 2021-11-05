class Code {
  String uid;
  String code;

  Code({required this.uid, required this.code});

  factory Code.fromMap(Map<String, dynamic> json) => Code(
        uid: json['uid'],
        code: json["code"],
      );

  Map<String, dynamic> toMap() => {
        "uid": uid,
        "code": code,
      };
}
