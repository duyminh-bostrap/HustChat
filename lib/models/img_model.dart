class ImageModel{
  String id;
  String name;

  ImageModel({required this.id, required this.name});
  
  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(id: json["_id"], name: json["fileName"]);
}