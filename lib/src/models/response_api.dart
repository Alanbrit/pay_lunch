import 'dart:convert';

ResponsiveApi responsiveApiFromJson(String str) => ResponsiveApi.fromJson(json.decode(str));

String responsiveApiToJson(ResponsiveApi data) => json.encode(data.toJson());

class ResponsiveApi {
  bool? success;
  String? message;
  dynamic data;

  ResponsiveApi({
    this.success,
    this.message,
    this.data
  });

  factory ResponsiveApi.fromJson(Map<String, dynamic> json) => ResponsiveApi(
    success: json["success"],
    message: json["message"],
    data: json["data"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}