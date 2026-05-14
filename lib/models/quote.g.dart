// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quote _$QuoteFromJson(Map<String, dynamic> json) => Quote(
  sId: json['sId'] as String?,
  content: json['content'] as String?,
  author: json['author'] as String?,
  tags: (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList(),
  authorSlug: json['authorSlug'] as String?,
  length: (json['length'] as num?)?.toInt(),
  dateAdded: json['dateAdded'] as String?,
  dateModified: json['dateModified'] as String?,
);

Map<String, dynamic> _$QuoteToJson(Quote instance) => <String, dynamic>{
  'sId': instance.sId,
  'content': instance.content,
  'author': instance.author,
  'tags': instance.tags,
  'authorSlug': instance.authorSlug,
  'length': instance.length,
  'dateAdded': instance.dateAdded,
  'dateModified': instance.dateModified,
};
