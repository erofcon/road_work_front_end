class RefreshResponse {
  RefreshResponse({
    this.access,
    this.code,
    this.detail,
  });

  String? access;
  String? detail;
  String? code;

  RefreshResponse.fromJson(Map<String, dynamic> json) {
    access = json['access'];
    detail = json['detail'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['access'] = access;
    data['detail'] = detail;
    data['code'] = code;
    return data;
  }
}
