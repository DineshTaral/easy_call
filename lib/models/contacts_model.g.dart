// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contacts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactsModel _$ContactsModelFromJson(Map<String, dynamic> json) =>
    ContactsModel(
      name: json['name'] as String?,
      contact: json['contact'] as String?,
      image: json['image'] as String?,
      id: json['_id'] as int?,
    );

Map<String, dynamic> _$ContactsModelToJson(ContactsModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'contact': instance.contact,
      'image': instance.image,
      '_id':instance.id,
    };
