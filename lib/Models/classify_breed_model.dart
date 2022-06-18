/// response : {"classification_summary":"We are 99.52% confident that your scanned image is a <b>Cocker Spaniel</b> breed.","data":[{"breed":"Cocker Spaniel","percentage":"99.52","thumbnail":"https://genofax.s3.ap-southeast-1.amazonaws.com/breed-thumbnails/cocker spaniel.jpg","additional_info":true,"country_of_origin":"Great Britain","brief_history":"Spaniels is the one of the largest group of dogs and the Cocker Spaniel is a land spaniel. They were separated from the field and springer spaniels based on their utilization of flushing woodcock. There are two separate varieties of Cocker Spaniels, the English and American. Both these breed, earlier treated as one were officially separated in 1935. The American version of the Cocker spaniel is smaller than the English version. The American Cocker Spaniel is regarded as one of the most popular breed of all time in America. ","life_span":["Average: 12.0-15.0 years"],"ideal_weight":["Average: 26.0-35.0 lbs"],"ideal_height":["Average: 14.0-17.0 inches"],"temperament":["lively","affectionate","friendly","faithful","quiet","trainable"],"country_of_patronage":null,"utilization":["flushing dog"],"alternative_names":["american cocker spaniel (american breed outside of america)"," english cocker spaniel (british breed"," outside of britain)"],"fci_classification":"Group 8 Retrievers, Flushing Dogs, Water Dogs. Section 2 Flushing dogs"}]}
/// id : "456"
/// image_path : "dog/breed/838dbc.jpg"
/// request_fulfilled_at : "2022-02-18 08:38:44"
/// created_at : "2022-02-18 08:38:42"
/// updated_at : "2022-02-18 08:38:44"
/// image_url : "https://genofax.s3.ap-southeast-1.amazonaws.com/dog/breed/838dbc.jpg"

class ClassifyBreedModel {
  ClassifyBreedModel({
      Response? response, 
      String? id, 
      String? imagePath, 
      String? requestFulfilledAt, 
      String? createdAt, 
      String? updatedAt, 
      String? imageUrl,}){
    _response = response;
    _id = id;
    _imagePath = imagePath;
    _requestFulfilledAt = requestFulfilledAt;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageUrl = imageUrl;
}

  ClassifyBreedModel.fromJson(dynamic json) {
    _response = json['response'] != null ? Response.fromJson(json['response']) : null;
    _id = json['id'];
    _imagePath = json['image_path'];
    _requestFulfilledAt = json['request_fulfilled_at'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imageUrl = json['image_url'];
  }
  Response? _response;
  String? _id;
  String? _imagePath;
  String? _requestFulfilledAt;
  String? _createdAt;
  String? _updatedAt;
  String? _imageUrl;

  Response? get response => _response;
  String? get id => _id;
  String? get imagePath => _imagePath;
  String? get requestFulfilledAt => _requestFulfilledAt;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    map['id'] = _id;
    map['image_path'] = _imagePath;
    map['request_fulfilled_at'] = _requestFulfilledAt;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image_url'] = _imageUrl;
    return map;
  }

}

/// classification_summary : "We are 99.52% confident that your scanned image is a <b>Cocker Spaniel</b> breed."
/// data : [{"breed":"Cocker Spaniel","percentage":"99.52","thumbnail":"https://genofax.s3.ap-southeast-1.amazonaws.com/breed-thumbnails/cocker spaniel.jpg","additional_info":true,"country_of_origin":"Great Britain","brief_history":"Spaniels is the one of the largest group of dogs and the Cocker Spaniel is a land spaniel. They were separated from the field and springer spaniels based on their utilization of flushing woodcock. There are two separate varieties of Cocker Spaniels, the English and American. Both these breed, earlier treated as one were officially separated in 1935. The American version of the Cocker spaniel is smaller than the English version. The American Cocker Spaniel is regarded as one of the most popular breed of all time in America. ","life_span":["Average: 12.0-15.0 years"],"ideal_weight":["Average: 26.0-35.0 lbs"],"ideal_height":["Average: 14.0-17.0 inches"],"temperament":["lively","affectionate","friendly","faithful","quiet","trainable"],"country_of_patronage":null,"utilization":["flushing dog"],"alternative_names":["american cocker spaniel (american breed outside of america)"," english cocker spaniel (british breed"," outside of britain)"],"fci_classification":"Group 8 Retrievers, Flushing Dogs, Water Dogs. Section 2 Flushing dogs"}]

class Response {
  Response({
      String? classificationSummary, 
      List<ClassifyData>? data,}){
    _classificationSummary = classificationSummary;
    _data = data;
}

  Response.fromJson(dynamic json) {
    _classificationSummary = json['classification_summary'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(ClassifyData.fromJson(v));
      });
    }
  }
  String? _classificationSummary;
  List<ClassifyData>? _data;

  String? get classificationSummary => _classificationSummary;
  List<ClassifyData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['classification_summary'] = _classificationSummary;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// breed : "Cocker Spaniel"
/// percentage : "99.52"
/// thumbnail : "https://genofax.s3.ap-southeast-1.amazonaws.com/breed-thumbnails/cocker spaniel.jpg"
/// additional_info : true
/// country_of_origin : "Great Britain"
/// brief_history : "Spaniels is the one of the largest group of dogs and the Cocker Spaniel is a land spaniel. They were separated from the field and springer spaniels based on their utilization of flushing woodcock. There are two separate varieties of Cocker Spaniels, the English and American. Both these breed, earlier treated as one were officially separated in 1935. The American version of the Cocker spaniel is smaller than the English version. The American Cocker Spaniel is regarded as one of the most popular breed of all time in America. "
/// life_span : ["Average: 12.0-15.0 years"]
/// ideal_weight : ["Average: 26.0-35.0 lbs"]
/// ideal_height : ["Average: 14.0-17.0 inches"]
/// temperament : ["lively","affectionate","friendly","faithful","quiet","trainable"]
/// country_of_patronage : null
/// utilization : ["flushing dog"]
/// alternative_names : ["american cocker spaniel (american breed outside of america)"," english cocker spaniel (british breed"," outside of britain)"]
/// fci_classification : "Group 8 Retrievers, Flushing Dogs, Water Dogs. Section 2 Flushing dogs"

class ClassifyData {
  ClassifyData({
      String? breed, 
      String? percentage, 
      String? thumbnail, 
      bool? additionalInfo, 
      String? countryOfOrigin, 
      String? briefHistory, 
      List<String>? lifeSpan, 
      List<String>? idealWeight, 
      List<String>? idealHeight, 
      List<String>? temperament, 
      dynamic countryOfPatronage, 
      List<String>? utilization, 
      List<String>? alternativeNames, 
      String? fciClassification,}){
    _breed = breed;
    _percentage = percentage;
    _thumbnail = thumbnail;
    _additionalInfo = additionalInfo;
    _countryOfOrigin = countryOfOrigin;
    _briefHistory = briefHistory;
    _lifeSpan = lifeSpan;
    _idealWeight = idealWeight;
    _idealHeight = idealHeight;
    _temperament = temperament;
    _countryOfPatronage = countryOfPatronage;
    _utilization = utilization;
    _alternativeNames = alternativeNames;
    _fciClassification = fciClassification;
}

  ClassifyData.fromJson(dynamic json) {
    _breed = json['breed'];
    _percentage = json['percentage'];
    _thumbnail = json['thumbnail'];
    _additionalInfo = json['additional_info'];
    _countryOfOrigin = json['country_of_origin'];
    _briefHistory = json['brief_history'];
    _lifeSpan = json['life_span'] != null ? json['life_span'].cast<String>() : [];
    _idealWeight = json['ideal_weight'] != null ? json['ideal_weight'].cast<String>() : [];
    _idealHeight = json['ideal_height'] != null ? json['ideal_height'].cast<String>() : [];
    _temperament = json['temperament'] != null ? json['temperament'].cast<String>() : [];
    _countryOfPatronage = json['country_of_patronage'];
    _utilization = json['utilization'] != null ? json['utilization'].cast<String>() : [];
    _alternativeNames = json['alternative_names'] != null ? json['alternative_names'].cast<String>() : [];
    _fciClassification = json['fci_classification'];
  }
  String? _breed;
  String? _percentage;
  String? _thumbnail;
  bool? _additionalInfo;
  String? _countryOfOrigin;
  String? _briefHistory;
  List<String>? _lifeSpan;
  List<String>? _idealWeight;
  List<String>? _idealHeight;
  List<String>? _temperament;
  dynamic _countryOfPatronage;
  List<String>? _utilization;
  List<String>? _alternativeNames;
  String? _fciClassification;

  String? get breed => _breed;
  String? get percentage => _percentage;
  String? get thumbnail => _thumbnail;
  bool? get additionalInfo => _additionalInfo;
  String? get countryOfOrigin => _countryOfOrigin;
  String? get briefHistory => _briefHistory;
  List<String>? get lifeSpan => _lifeSpan;
  List<String>? get idealWeight => _idealWeight;
  List<String>? get idealHeight => _idealHeight;
  List<String>? get temperament => _temperament;
  dynamic get countryOfPatronage => _countryOfPatronage;
  List<String>? get utilization => _utilization;
  List<String>? get alternativeNames => _alternativeNames;
  String? get fciClassification => _fciClassification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['breed'] = _breed;
    map['percentage'] = _percentage;
    map['thumbnail'] = _thumbnail;
    map['additional_info'] = _additionalInfo;
    map['country_of_origin'] = _countryOfOrigin;
    map['brief_history'] = _briefHistory;
    map['life_span'] = _lifeSpan;
    map['ideal_weight'] = _idealWeight;
    map['ideal_height'] = _idealHeight;
    map['temperament'] = _temperament;
    map['country_of_patronage'] = _countryOfPatronage;
    map['utilization'] = _utilization;
    map['alternative_names'] = _alternativeNames;
    map['fci_classification'] = _fciClassification;
    return map;
  }

}