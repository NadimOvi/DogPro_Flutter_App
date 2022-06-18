class GetHistoryList{
  List<HistoryData>? data;

  GetHistoryList({this.data});

  GetHistoryList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <HistoryData>[];
      json['data'].forEach((v) {
        data!.add(new HistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class HistoryData {
  String? breedId;
  String? breedName;
  String? history;
  String? thumbnail;

  HistoryData({this.breedId, this.breedName, this.history, this.thumbnail});

  HistoryData.fromJson(Map<String, dynamic> json) {
    breedId = json['breed_id'];
    breedName = json['breed_name'];
    history = json['history'];
    thumbnail = json['thumbnail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['breed_id'] = this.breedId;
    data['breed_name'] = this.breedName;
    data['history'] = this.history;
    data['thumbnail'] = this.thumbnail;
    return data;
  }
}