/// name : "Megaesophagus"
/// alternative_name : null
/// inherent_mode : null
/// cause : null
/// diagnosis : null
/// symptom : "Although it may not be noticed until young adulthood, this disorder is usually first recognized in puppies around the time of weaning. Affected pups regurgitate food, fail to thrive, and may develop respiratory difficulties associated with aspiration pneumonia due to inhalation of food particles. Signs include laboured breathing, fever and lethargy, and nasal discharge. Some dogs appear to gradually outgrow this condition (by a year or so), while in others there is no improvement."
/// treat_method : "If an underlying cause can be identified, treatment may improve esophageal function. There is no specific treatment for the megaesophagus itself, but it can usually be managed by feeding small, frequent, high-caloric meals from an elevated location so that gravity assists the passage of food. Different consistencies of foods can be tried to determine which causes the least regurgitation. Some dogs appear to outgrow the problem, while in others there is no improvement and feeding management is required for life. Your veterinarian will discuss with you possible complications that you must watch out for, the most serious of which is aspiration pneumonia."
/// breeder_advice : "Affected wire-haired fox terriers, their parents (carriers of the trait) and siblings (suspect carriers) should not be bred. Affected miniature schnauzers should not be bred. In other breeds in which inheritance is unknown, it is safest to avoid breeding affected dogs, their parents and siblings."
/// source_link : null
/// description : "Megaesophagus is when the muscles of the esophagus do not work and food and water cannot be moved into the stomach. As a result, the food and water stay in the esophagus within the chest cavity and are never pushed into the stomach. The food and water that are stuck in the esophagus will at some point cause your dog to aspirate the contents, resulting in aspiration pneumonia."
/// associated_diseases : [{"name":"Megaoesophagus","other_name":null,"mode_of_inheritance":null,"omia_link":"OMIA: 631","gene_link":null}]

class DiseasesDetailsModel {
  DiseasesDetailsModel({
      String? name, 
      dynamic alternativeName, 
      dynamic inherentMode, 
      dynamic cause, 
      dynamic diagnosis, 
      String? symptom, 
      String? treatMethod, 
      String? breederAdvice, 
      dynamic sourceLink, 
      String? description, 
      List<AssociatedDiseases>? associatedDiseases,}){
    _name = name;
    _alternativeName = alternativeName;
    _inherentMode = inherentMode;
    _cause = cause;
    _diagnosis = diagnosis;
    _symptom = symptom;
    _treatMethod = treatMethod;
    _breederAdvice = breederAdvice;
    _sourceLink = sourceLink;
    _description = description;
    _associatedDiseases = associatedDiseases;
}

  DiseasesDetailsModel.fromJson(dynamic json) {
    _name = json['name'];
    _alternativeName = json['alternative_name'];
    _inherentMode = json['inherent_mode'];
    _cause = json['cause'];
    _diagnosis = json['diagnosis'];
    _symptom = json['symptom'];
    _treatMethod = json['treat_method'];
    _breederAdvice = json['breeder_advice'];
    _sourceLink = json['source_link'];
    _description = json['description'];
    if (json['associated_diseases'] != null) {
      _associatedDiseases = [];
      json['associated_diseases'].forEach((v) {
        _associatedDiseases?.add(AssociatedDiseases.fromJson(v));
      });
    }
  }
  String? _name;
  dynamic _alternativeName;
  dynamic _inherentMode;
  dynamic _cause;
  dynamic _diagnosis;
  String? _symptom;
  String? _treatMethod;
  String? _breederAdvice;
  dynamic _sourceLink;
  String? _description;
  List<AssociatedDiseases>? _associatedDiseases;

  String? get name => _name;
  dynamic get alternativeName => _alternativeName;
  dynamic get inherentMode => _inherentMode;
  dynamic get cause => _cause;
  dynamic get diagnosis => _diagnosis;
  String? get symptom => _symptom;
  String? get treatMethod => _treatMethod;
  String? get breederAdvice => _breederAdvice;
  dynamic get sourceLink => _sourceLink;
  String? get description => _description;
  List<AssociatedDiseases>? get associatedDiseases => _associatedDiseases;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['alternative_name'] = _alternativeName;
    map['inherent_mode'] = _inherentMode;
    map['cause'] = _cause;
    map['diagnosis'] = _diagnosis;
    map['symptom'] = _symptom;
    map['treat_method'] = _treatMethod;
    map['breeder_advice'] = _breederAdvice;
    map['source_link'] = _sourceLink;
    map['description'] = _description;
    if (_associatedDiseases != null) {
      map['associated_diseases'] = _associatedDiseases?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// name : "Megaoesophagus"
/// other_name : null
/// mode_of_inheritance : null
/// omia_link : "OMIA: 631"
/// gene_link : null

class AssociatedDiseases {
  AssociatedDiseases({
      String? name, 
      dynamic otherName, 
      dynamic modeOfInheritance, 
      String? omiaLink, 
      dynamic geneLink,}){
    _name = name;
    _otherName = otherName;
    _modeOfInheritance = modeOfInheritance;
    _omiaLink = omiaLink;
    _geneLink = geneLink;
}

  AssociatedDiseases.fromJson(dynamic json) {
    _name = json['name'];
    _otherName = json['other_name'];
    _modeOfInheritance = json['mode_of_inheritance'];
    _omiaLink = json['omia_link'];
    _geneLink = json['gene_link'];
  }
  String? _name;
  dynamic _otherName;
  dynamic _modeOfInheritance;
  String? _omiaLink;
  dynamic _geneLink;

  String? get name => _name;
  dynamic get otherName => _otherName;
  dynamic get modeOfInheritance => _modeOfInheritance;
  String? get omiaLink => _omiaLink;
  dynamic get geneLink => _geneLink;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['other_name'] = _otherName;
    map['mode_of_inheritance'] = _modeOfInheritance;
    map['omia_link'] = _omiaLink;
    map['gene_link'] = _geneLink;
    return map;
  }

}