import 'package:json_annotation/json_annotation.dart';
part 'contacts_model.g.dart';

@JsonSerializable()
class ContactsModel{
  String? name;
  String? contact;
  String? image;
  int? id;
  ContactsModel({ this.name,this.contact,required this.image,required this.id});

  factory ContactsModel.fromJson(Map<String,dynamic> json)=>_$ContactsModelFromJson(json);

  Map<String,dynamic> toJson()=>_$ContactsModelToJson(this);




}