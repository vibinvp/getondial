class VideoModel {
  List<VideoDetailsList>? value;
  String? message;

  VideoModel({this.value, this.message});

  VideoModel.fromJson(Map<String, dynamic> json) {
    if (json['value'] != null) {
      value = <VideoDetailsList>[];
      json['value'].forEach((v) {
        value!.add(new VideoDetailsList.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class VideoDetailsList {
  int? id;
  int? moduleId;
  int? zoneId;
  String? title;
  String? url;
  int? status;
  String? type;
  int? featured;
  String? createdAt;
  String? updatedAt;
  List<Translations>? translations;

  VideoDetailsList(
      {this.id,
      this.moduleId,
      this.zoneId,
      this.title,
      this.url,
      this.status,
      this.type,
      this.featured,
      this.createdAt,
      this.updatedAt,
      this.translations});

  VideoDetailsList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moduleId = json['module_id'];
    zoneId = json['zone_id'];
    title = json['title'];
    url = json['url'];
    status = json['status'];
    type = json['type'];
    featured = json['featured'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['module_id'] = this.moduleId;
    data['zone_id'] = this.zoneId;
    data['title'] = this.title;
    data['url'] = this.url;
    data['status'] = this.status;
    data['type'] = this.type;
    data['featured'] = this.featured;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Translations {
  int? language;

  Translations({this.language});

  Translations.fromJson(Map<String, dynamic> json) {
    language = json['language'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    return data;
  }
}
