class BreedList{
  List<Data>? data;

  BreedList({this.data});

  BreedList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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
  String? breedId;
  String? name;
  String? thumbnail;

  Data({this.breedId, this.name, this.thumbnail});

  Data.fromJson(Map<String, dynamic> json) {
    breedId = json['breed_id'];
    name = json['name'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breed_id'] = this.breedId;
    data['name'] = this.name;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}