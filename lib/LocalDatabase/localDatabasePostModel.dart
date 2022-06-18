/// data : [{"id":527,"image_path":"dog/breed/de78d7.jpg","request_fulfilled_at":"2022-03-01 03:47:04","response":{"data":[{"breed":"Bull Arab","breed_id":"bull arab","life_span":["Average: 12.0-15.0 years"],"thumbnail":"https://genofax.s3.ap-southeast-1.amazonaws.com/breed-thumbnails/bull arab.jpg","percentage":"59.77","temperament":["active","independent","tempered","kind"],"utilization":["hunting dog"],"ideal_height":["Average: 24.0-27.0 inches"],"ideal_weight":["Average: 66.0-110.0 lbs"],"brief_history":"The Bull Arab is a breed developed in Australia for pig hunting. They were developed by the Australian breeder Mike Hodgens in 1972 by cross breeding English Bull Terrier with a German Short haired Pointer and a Greyhound.","additional_info":true,"alternative_names":["pig dog"," aussie pig"," pointer"],"country_of_origin":"Australia","fci_classification":"# not included in FCI and iDOG","country_of_patronage":null}],"classification_summary":"We are 59.77% confident that your scanned image is a <b>Bull Arab</b> breed."},"created_at":"2022-03-01T03:47:02.000000Z","updated_at":"2022-03-01T03:47:04.000000Z","image_url":"https://genofax.s3.ap-southeast-1.amazonaws.com/dog/breed/de78d7.jpg"},{"id":522,"image_path":"dog/breed/d2e9a3.jpg","request_fulfilled_at":"2022-02-26 23:03:06","response":{"data":[{"breed":"Australian Cattledog","breed_id":"australian cattledog","life_span":["Average: 13.0-15.0 years"],"thumbnail":"https://genofax.s3.ap-southeast-1.amazonaws.com/breed-thumbnails/australian cattledog.jpg","percentage":"84.55","temperament":["cautious","energetic","loyal","confident","obedient","protective"],"utilization":["cattledog"],"ideal_height":["Average: 17.0-20.0 inches"],"ideal_weight":["Average: 31.0-35.0 lbs"],"brief_history":"The Australian cattle Dog was developed to help the establishment of the cattle industry in Australia. There was need of a cattle dog that could manage the rough terrain of Australia. To achieve this goal, George Hall cross bred a droving dog, the Old English Sheepdog, imported from Northumberland with a Dingo (Australian wild dog) to obtain the desired characteristics of strong, biting dog, possessing stamina and capable of mustering and moving wild cattle. Owing to this, these cattle dogs were commonly known as the Hall Heeler in the 1840s. After the demise of Thomas Hall in 1870, the hall heelers were freely available and were further bred. The cattle dogs of hall heeler derivations in the 1890s were seen in the kennels of exhibiting Queensland dog breeders and hence are also known as Queensland Heelers.","additional_info":true,"alternative_names":["blue heeler"," queensland heeler"],"country_of_origin":"Australia","fci_classification":"Group 1 Sheepdogs and Cattledogs, except Swiss Mountain and Cattledogs. Section 2 Cattledogs.","country_of_patronage":null}],"classification_summary":"We are 84.55% confident that your scanned image is a <b>Australian Cattledog</b> breed."},"created_at":"2022-02-26T23:03:04.000000Z","updated_at":"2022-02-26T23:03:06.000000Z","image_url":"https://genofax.s3.ap-southeast-1.amazonaws.com/dog/breed/d2e9a3.jpg"}]

class LocalDatabasePostModel {
  LocalDatabasePostModel({
      List<Data>? data,}){
    _data = data;
}

  LocalDatabasePostModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  List<Data>? _data;

  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : 527
/// image_path : "dog/breed/de78d7.jpg"
/// request_fulfilled_at : "2022-03-01 03:47:04"
/// response : {"data":[{"breed":"Bull Arab","breed_id":"bull arab","life_span":["Average: 12.0-15.0 years"],"thumbnail":"https://genofax.s3.ap-southeast-1.amazonaws.com/breed-thumbnails/bull arab.jpg","percentage":"59.77","temperament":["active","independent","tempered","kind"],"utilization":["hunting dog"],"ideal_height":["Average: 24.0-27.0 inches"],"ideal_weight":["Average: 66.0-110.0 lbs"],"brief_history":"The Bull Arab is a breed developed in Australia for pig hunting. They were developed by the Australian breeder Mike Hodgens in 1972 by cross breeding English Bull Terrier with a German Short haired Pointer and a Greyhound.","additional_info":true,"alternative_names":["pig dog"," aussie pig"," pointer"],"country_of_origin":"Australia","fci_classification":"# not included in FCI and iDOG","country_of_patronage":null}],"classification_summary":"We are 59.77% confident that your scanned image is a <b>Bull Arab</b> breed."}
/// created_at : "2022-03-01T03:47:02.000000Z"
/// updated_at : "2022-03-01T03:47:04.000000Z"
/// image_url : "https://genofax.s3.ap-southeast-1.amazonaws.com/dog/breed/de78d7.jpg"

class Data {
  Data({
      int? id, 
      String? imagePath, 
      String? requestFulfilledAt, 
      Response? response, 
      String? createdAt, 
      String? updatedAt, 
      String? imageUrl,}){
    _id = id;
    _imagePath = imagePath;
    _requestFulfilledAt = requestFulfilledAt;
    _response = response;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _imageUrl = imageUrl;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _imagePath = json['image_path'];
    _requestFulfilledAt = json['request_fulfilled_at'];
    _response = json['response'] != null ? Response.fromJson(json['response']) : null;
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _imageUrl = json['image_url'];
  }
  int? _id;
  String? _imagePath;
  String? _requestFulfilledAt;
  Response? _response;
  String? _createdAt;
  String? _updatedAt;
  String? _imageUrl;

  int? get id => _id;
  String? get imagePath => _imagePath;
  String? get requestFulfilledAt => _requestFulfilledAt;
  Response? get response => _response;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  String? get imageUrl => _imageUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image_path'] = _imagePath;
    map['request_fulfilled_at'] = _requestFulfilledAt;
    if (_response != null) {
      map['response'] = _response?.toJson();
    }
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['image_url'] = _imageUrl;
    return map;
  }

}

/// data : [{"breed":"Bull Arab","breed_id":"bull arab","life_span":["Average: 12.0-15.0 years"],"thumbnail":"https://genofax.s3.ap-southeast-1.amazonaws.com/breed-thumbnails/bull arab.jpg","percentage":"59.77","temperament":["active","independent","tempered","kind"],"utilization":["hunting dog"],"ideal_height":["Average: 24.0-27.0 inches"],"ideal_weight":["Average: 66.0-110.0 lbs"],"brief_history":"The Bull Arab is a breed developed in Australia for pig hunting. They were developed by the Australian breeder Mike Hodgens in 1972 by cross breeding English Bull Terrier with a German Short haired Pointer and a Greyhound.","additional_info":true,"alternative_names":["pig dog"," aussie pig"," pointer"],"country_of_origin":"Australia","fci_classification":"# not included in FCI and iDOG","country_of_patronage":null}]
/// classification_summary : "We are 59.77% confident that your scanned image is a <b>Bull Arab</b> breed."

class Response {
  Response({
      List<LocalData>? data,
      String? classificationSummary,}){
    _data = data;
    _classificationSummary = classificationSummary;
}

  Response.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(LocalData.fromJson(v));
      });
    }
    _classificationSummary = json['classification_summary'];
  }
  List<LocalData>? _data;
  String? _classificationSummary;

  List<LocalData>? get data => _data;
  String? get classificationSummary => _classificationSummary;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['classification_summary'] = _classificationSummary;
    return map;
  }

}

/// breed : "Bull Arab"
/// breed_id : "bull arab"
/// life_span : ["Average: 12.0-15.0 years"]
/// thumbnail : "https://genofax.s3.ap-southeast-1.amazonaws.com/breed-thumbnails/bull arab.jpg"
/// percentage : "59.77"
/// temperament : ["active","independent","tempered","kind"]
/// utilization : ["hunting dog"]
/// ideal_height : ["Average: 24.0-27.0 inches"]
/// ideal_weight : ["Average: 66.0-110.0 lbs"]
/// brief_history : "The Bull Arab is a breed developed in Australia for pig hunting. They were developed by the Australian breeder Mike Hodgens in 1972 by cross breeding English Bull Terrier with a German Short haired Pointer and a Greyhound."
/// additional_info : true
/// alternative_names : ["pig dog"," aussie pig"," pointer"]
/// country_of_origin : "Australia"
/// fci_classification : "# not included in FCI and iDOG"
/// country_of_patronage : null

class LocalData {
  Data({
      String? breed, 
      String? breedId, 
      List<String>? lifeSpan, 
      String? thumbnail, 
      String? percentage, 
      List<String>? temperament, 
      List<String>? utilization, 
      List<String>? idealHeight, 
      List<String>? idealWeight, 
      String? briefHistory, 
      bool? additionalInfo, 
      List<String>? alternativeNames, 
      String? countryOfOrigin, 
      String? fciClassification, 
      dynamic countryOfPatronage,}){
    _breed = breed;
    _breedId = breedId;
    _lifeSpan = lifeSpan;
    _thumbnail = thumbnail;
    _percentage = percentage;
    _temperament = temperament;
    _utilization = utilization;
    _idealHeight = idealHeight;
    _idealWeight = idealWeight;
    _briefHistory = briefHistory;
    _additionalInfo = additionalInfo;
    _alternativeNames = alternativeNames;
    _countryOfOrigin = countryOfOrigin;
    _fciClassification = fciClassification;
    _countryOfPatronage = countryOfPatronage;
}

  LocalData.fromJson(dynamic json) {
    _breed = json['breed'];
    _breedId = json['breed_id'];
    _lifeSpan = json['life_span'] != null ? json['life_span'].cast<String>() : [];
    _thumbnail = json['thumbnail'];
    _percentage = json['percentage'];
    _temperament = json['temperament'] != null ? json['temperament'].cast<String>() : [];
    _utilization = json['utilization'] != null ? json['utilization'].cast<String>() : [];
    _idealHeight = json['ideal_height'] != null ? json['ideal_height'].cast<String>() : [];
    _idealWeight = json['ideal_weight'] != null ? json['ideal_weight'].cast<String>() : [];
    _briefHistory = json['brief_history'];
    _additionalInfo = json['additional_info'];
    _alternativeNames = json['alternative_names'] != null ? json['alternative_names'].cast<String>() : [];
    _countryOfOrigin = json['country_of_origin'];
    _fciClassification = json['fci_classification'];
    _countryOfPatronage = json['country_of_patronage'];
  }
  String? _breed;
  String? _breedId;
  List<String>? _lifeSpan;
  String? _thumbnail;
  String? _percentage;
  List<String>? _temperament;
  List<String>? _utilization;
  List<String>? _idealHeight;
  List<String>? _idealWeight;
  String? _briefHistory;
  bool? _additionalInfo;
  List<String>? _alternativeNames;
  String? _countryOfOrigin;
  String? _fciClassification;
  dynamic _countryOfPatronage;

  String? get breed => _breed;
  String? get breedId => _breedId;
  List<String>? get lifeSpan => _lifeSpan;
  String? get thumbnail => _thumbnail;
  String? get percentage => _percentage;
  List<String>? get temperament => _temperament;
  List<String>? get utilization => _utilization;
  List<String>? get idealHeight => _idealHeight;
  List<String>? get idealWeight => _idealWeight;
  String? get briefHistory => _briefHistory;
  bool? get additionalInfo => _additionalInfo;
  List<String>? get alternativeNames => _alternativeNames;
  String? get countryOfOrigin => _countryOfOrigin;
  String? get fciClassification => _fciClassification;
  dynamic get countryOfPatronage => _countryOfPatronage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['breed'] = _breed;
    map['breed_id'] = _breedId;
    map['life_span'] = _lifeSpan;
    map['thumbnail'] = _thumbnail;
    map['percentage'] = _percentage;
    map['temperament'] = _temperament;
    map['utilization'] = _utilization;
    map['ideal_height'] = _idealHeight;
    map['ideal_weight'] = _idealWeight;
    map['brief_history'] = _briefHistory;
    map['additional_info'] = _additionalInfo;
    map['alternative_names'] = _alternativeNames;
    map['country_of_origin'] = _countryOfOrigin;
    map['fci_classification'] = _fciClassification;
    map['country_of_patronage'] = _countryOfPatronage;
    return map;
  }

}