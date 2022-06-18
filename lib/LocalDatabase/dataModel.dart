class DataModel{
  final int? id;
  final String? ids;

  DataModel({this.id, required this.ids});

  factory DataModel.fromMap(Map<String, dynamic> json) => DataModel(
      id: json['id'],
      ids: json['ids']
  );

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'ids': ids,
    };
  }
}