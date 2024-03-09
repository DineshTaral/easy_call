import 'package:json_annotation/json_annotation.dart';
part 'contacts_model.g.dart';

@JsonSerializable()
class ContactsModel{
  String? name;
  String? contact;
  String? image;

  ContactsModel({ this.name,this.contact,required this.image});

  factory ContactsModel.fromJson(Map<String,dynamic> json)=>_$ContactsModelFromJson(json);

  Map<String,dynamic> toJson()=>_$ContactsModelToJson(this);




}