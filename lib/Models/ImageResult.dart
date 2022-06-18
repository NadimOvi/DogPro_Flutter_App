class ImageResult {
  Response? response;
  String? id;
  String? imagePath;
  String? requestFulfilledAt;
  String? createdAt;
  String? updatedAt;
  String? imageUrl;

  ImageResult(
      {this.response,
        this.id,
        this.imagePath,
        this.requestFulfilledAt,
        this.createdAt,
        this.updatedAt,
        this.imageUrl});

  ImageResult.fromJson(Map<String, dynamic> json) {
    response = json['response'] != null
        ? new Response.fromJson(json['response'])
        : null;
    id = json['id'];
    imagePath = json['image_path'];
    requestFulfilledAt = json['request_fulfilled_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    imageUrl = json['image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.response != null) {
      data['response'] = this.response!.toJson();
    }
    data['id'] = this.id;
    data['image_path'] = this.imagePath;
    data['request_fulfilled_at'] = this.requestFulfilledAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['image_url'] = this.imageUrl;
    return data;
  }
}

class Response {
  String? classificationSummary;
  List<Data>? data;

  Response({this.classificationSummary, this.data});

  Response.fromJson(Map<String, dynamic> json) {
    classificationSummary = json['classification_summary'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['classification_summary'] = this.classificationSummary;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? breed;
  String? percentage;
  String? thumbnail;
  bool? additionalInfo;
  String? countryOfOrigin;
  String? briefHistory;
  List<String>? lifeSpan;
  List<String>? idealWeight;
  List<String>? idealHeight;
  List<String>? temperament;
  Null? countryOfPatronage;
  List<String>? utilization;
  List<String>? alternativeNames;
  String? fciClassification;

  Data(
      {this.breed,
        this.percentage,
        this.thumbnail,
        this.additionalInfo,
        this.countryOfOrigin,
        this.briefHistory,
        this.lifeSpan,
        this.idealWeight,
        this.idealHeight,
        this.temperament,
        this.countryOfPatronage,
        this.utilization,
        this.alternativeNames,
        this.fciClassification});

  Data.fromJson(Map<String, dynamic> json) {
    breed = json['breed'];
    percentage = json['percentage'];
    thumbnail = json['thumbnail'];
    additionalInfo = json['additional_info'];
    countryOfOrigin = json['country_of_origin'];
    briefHistory = json['brief_history'];
    lifeSpan = json['life_span'].cast<String>();
    idealWeight = json['ideal_weight'].cast<String>();
    idealHeight = json['ideal_height'].cast<String>();
    temperament = json['temperament'].cast<String>();
    countryOfPatronage = json['country_of_patronage'];
    utilization = json['utilization'].cast<String>();
    alternativeNames = json['alternative_names'].cast<String>();
    fciClassification = json['fci_classification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breed'] = this.breed;
    data['percentage'] = this.percentage;
    data['thumbnail'] = this.thumbnail;
    data['additional_info'] = this.additionalInfo;
    data['country_of_origin'] = this.countryOfOrigin;
    data['brief_history'] = this.briefHistory;
    data['life_span'] = this.lifeSpan;
    data['ideal_weight'] = this.idealWeight;
    data['ideal_height'] = this.idealHeight;
    data['temperament'] = this.temperament;
    data['country_of_patronage'] = this.countryOfPatronage;
    data['utilization'] = this.utilization;
    data['alternative_names'] = this.alternativeNames;
    data['fci_classification'] = this.fciClassification;
    return data;
  }
}