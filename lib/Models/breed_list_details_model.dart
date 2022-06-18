

class BreedListDetailsModel {
  BreedListDetailsModel({
    String? breedId,
    String? breed,
    String? thumbnail,
    String? countryOfOrigin,
    String? briefHistory,
    List<String>? lifeSpan,
    List<String>? idealWeight,
    List<String>? idealHeight,
    List<String>? temperament,
    dynamic countryOfPatronage,
    List<String>? utilization,
    List<String>? alternativeNames,
    List<AssociatedDiseases>? associatedDiseases,
    dynamic fciClassification,}){
    _breedId = breedId;
    _breed = breed;
    _thumbnail = thumbnail;
    _countryOfOrigin = countryOfOrigin;
    _briefHistory = briefHistory;
    _lifeSpan = lifeSpan;
    _idealWeight = idealWeight;
    _idealHeight = idealHeight;
    _temperament = temperament;
    _countryOfPatronage = countryOfPatronage;
    _utilization = utilization;
    _alternativeNames = alternativeNames;
    _associatedDiseases = associatedDiseases;
    _fciClassification = fciClassification;
  }

  BreedListDetailsModel.fromJson(dynamic json) {
    _breedId = json['breed_id'];
    _breed = json['breed'];
    _thumbnail = json['thumbnail'];
    _countryOfOrigin = json['country_of_origin'];
    _briefHistory = json['brief_history'];
    _lifeSpan = json['life_span'] != null ? json['life_span'].cast<String>() : [];
    _idealWeight = json['ideal_weight'] != null ? json['ideal_weight'].cast<String>() : [];
    _idealHeight = json['ideal_height'] != null ? json['ideal_height'].cast<String>() : [];
    _temperament = json['temperament'] != null ? json['temperament'].cast<String>() : [];
    _countryOfPatronage = json['country_of_patronage'];
    _utilization = json['utilization'] != null ? json['utilization'].cast<String>() : [];
    _alternativeNames = json['alternative_names'] != null ? json['alternative_names'].cast<String>() : [];
    if (json['associated_diseases'] != null) {
      _associatedDiseases = [];
      json['associated_diseases'].forEach((v) {
        _associatedDiseases?.add(AssociatedDiseases.fromJson(v));
      });
    }
    _fciClassification = json['fci_classification'];
  }
  String? _breedId;
  String? _breed;
  String? _thumbnail;
  String? _countryOfOrigin;
  String? _briefHistory;
  List<String>? _lifeSpan;
  List<String>? _idealWeight;
  List<String>? _idealHeight;
  List<String>? _temperament;
  dynamic _countryOfPatronage;
  List<String>? _utilization;
  List<String>? _alternativeNames;
  List<AssociatedDiseases>? _associatedDiseases;
  dynamic _fciClassification;

  String? get breedId => _breedId;
  String? get breed => _breed;
  String? get thumbnail => _thumbnail;
  String? get countryOfOrigin => _countryOfOrigin;
  String? get briefHistory => _briefHistory;
  List<String>? get lifeSpan => _lifeSpan;
  List<String>? get idealWeight => _idealWeight;
  List<String>? get idealHeight => _idealHeight;
  List<String>? get temperament => _temperament;
  dynamic get countryOfPatronage => _countryOfPatronage;
  List<String>? get utilization => _utilization;
  List<String>? get alternativeNames => _alternativeNames;
  List<AssociatedDiseases>? get associatedDiseases => _associatedDiseases;
  dynamic get fciClassification => _fciClassification;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['breed_id'] = _breedId;
    map['breed'] = _breed;
    map['thumbnail'] = _thumbnail;
    map['country_of_origin'] = _countryOfOrigin;
    map['brief_history'] = _briefHistory;
    map['life_span'] = _lifeSpan;
    map['ideal_weight'] = _idealWeight;
    map['ideal_height'] = _idealHeight;
    map['temperament'] = _temperament;
    map['country_of_patronage'] = _countryOfPatronage;
    map['utilization'] = _utilization;
    map['alternative_names'] = _alternativeNames;
    if (_associatedDiseases != null) {
      map['associated_diseases'] = _associatedDiseases?.map((v) => v.toJson()).toList();
    }
    map['fci_classification'] = _fciClassification;
    return map;
  }

}

class AssociatedDiseases {
  AssociatedDiseases({
    int? diseaseId,
    String? diseaseName,}){
    _diseaseId = diseaseId;
    _diseaseName = diseaseName;
  }

  AssociatedDiseases.fromJson(dynamic json) {
    _diseaseId = json['disease_id'];
    _diseaseName = json['disease_name'];
  }
  int? _diseaseId;
  String? _diseaseName;

  int? get diseaseId => _diseaseId;
  String? get diseaseName => _diseaseName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['disease_id'] = _diseaseId;
    map['disease_name'] = _diseaseName;
    return map;
  }

}