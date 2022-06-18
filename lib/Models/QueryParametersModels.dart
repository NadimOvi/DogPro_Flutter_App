class QueryParametersModels {
  IdealWeightsRange? idealWeightsRange;
  IdealHeightsRange? idealHeightsRange;
  List<String>? temperaments;
  List<String>? utilization;

  QueryParametersModels(
      {this.idealWeightsRange,
        this.idealHeightsRange,
        this.temperaments,
        this.utilization});

  QueryParametersModels.fromJson(Map<String, dynamic> json) {
    idealWeightsRange = json['ideal_weights_range'] != null
        ? new IdealWeightsRange.fromJson(json['ideal_weights_range'])
        : null;
    idealHeightsRange = json['ideal_heights_range'] != null
        ? new IdealHeightsRange.fromJson(json['ideal_heights_range'])
        : null;
    temperaments = json['temperaments'].cast<String>();
    utilization = json['utilization'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.idealWeightsRange != null) {
      data['ideal_weights_range'] = this.idealWeightsRange!.toJson();
    }
    if (this.idealHeightsRange != null) {
      data['ideal_heights_range'] = this.idealHeightsRange!.toJson();
    }
    data['temperaments'] = this.temperaments;
    data['utilization'] = this.utilization;
    return data;
  }
}

class IdealWeightsRange {
  List<int>? allRanges;
  List<int>? l30To520Lbs;
  List<int>? l520To1010Lbs;
  List<int>? l1010To1500Lbs;
  List<int>? l1500To2000Lbs;

  IdealWeightsRange(
      {this.allRanges,
        this.l30To520Lbs,
        this.l520To1010Lbs,
        this.l1010To1500Lbs,
        this.l1500To2000Lbs});

  IdealWeightsRange.fromJson(Map<String, dynamic> json) {
    allRanges = json['All ranges'].cast<int>();
    l30To520Lbs = json['3.0 to 52.0 lbs'].cast<int>();
    l520To1010Lbs = json['52.0 to 101.0 lbs'].cast<int>();
    l1010To1500Lbs = json['101.0 to 150.0 lbs'].cast<int>();
    l1500To2000Lbs = json['150.0 to 200.0 lbs'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['All ranges'] = this.allRanges;
    data['3.0 to 52.0 lbs'] = this.l30To520Lbs;
    data['52.0 to 101.0 lbs'] = this.l520To1010Lbs;
    data['101.0 to 150.0 lbs'] = this.l1010To1500Lbs;
    data['150.0 to 200.0 lbs'] = this.l1500To2000Lbs;
    return data;
  }
}

class IdealHeightsRange {
  List<int>? allRanges;
  List<int>? l50To120Inches;
  List<int>? l120To190Inches;
  List<int>? l190To260Inches;
  List<int>? l260To350Inches;

  IdealHeightsRange(
      {this.allRanges,
        this.l50To120Inches,
        this.l120To190Inches,
        this.l190To260Inches,
        this.l260To350Inches});

  IdealHeightsRange.fromJson(Map<String, dynamic> json) {
    allRanges = json['All ranges'].cast<int>();
    l50To120Inches = json['5.0 to 12.0 inches'].cast<int>();
    l120To190Inches = json['12.0 to 19.0 inches'].cast<int>();
    l190To260Inches = json['19.0 to 26.0 inches'].cast<int>();
    l260To350Inches = json['26.0 to 35.0 inches'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['All ranges'] = this.allRanges;
    data['5.0 to 12.0 inches'] = this.l50To120Inches;
    data['12.0 to 19.0 inches'] = this.l120To190Inches;
    data['19.0 to 26.0 inches'] = this.l190To260Inches;
    data['26.0 to 35.0 inches'] = this.l260To350Inches;
    return data;
  }
}