class TotalPostsResponseData {
  List<Data>? data;

  TotalPostsResponseData({this.data});

  TotalPostsResponseData.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? userId;
  int? id;
  String? title;
  String? body;

  Data({this.userId, this.id, this.title, this.body});

  Data.fromJson(Map<String, dynamic> json) {
    userId          = json['userId'];
    id              = json['id'];
    title           = json['title'];
    body            = json['body'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userId']  = userId;
    data['id']      = id;
    data['title']   = title;
    data['body']    = body;
    return data;
  }
}
