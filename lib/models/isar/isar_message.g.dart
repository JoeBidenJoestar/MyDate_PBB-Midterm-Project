// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_message.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarMessageCollection on Isar {
  IsarCollection<IsarMessage> get isarMessages => this.collection();
}

const IsarMessageSchema = CollectionSchema(
  name: r'IsarMessage',
  id: 2123208272505019328,
  properties: {
    r'firebaseMessageId': PropertySchema(
      id: 0,
      name: r'firebaseMessageId',
      type: IsarType.string,
    ),
    r'isSynced': PropertySchema(
      id: 1,
      name: r'isSynced',
      type: IsarType.bool,
    ),
    r'senderId': PropertySchema(
      id: 2,
      name: r'senderId',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 3,
      name: r'text',
      type: IsarType.string,
    ),
    r'timestamp': PropertySchema(
      id: 4,
      name: r'timestamp',
      type: IsarType.long,
    )
  },
  estimateSize: _isarMessageEstimateSize,
  serialize: _isarMessageSerialize,
  deserialize: _isarMessageDeserialize,
  deserializeProp: _isarMessageDeserializeProp,
  idName: r'id',
  indexes: {
    r'firebaseMessageId': IndexSchema(
      id: 1008327446506495613,
      name: r'firebaseMessageId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'firebaseMessageId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isSynced': IndexSchema(
      id: -39763503327887510,
      name: r'isSynced',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isSynced',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {
    r'match': LinkSchema(
      id: 7608881502667698180,
      name: r'match',
      target: r'IsarMatch',
      single: true,
    )
  },
  embeddedSchemas: {},
  getId: _isarMessageGetId,
  getLinks: _isarMessageGetLinks,
  attach: _isarMessageAttach,
  version: '3.1.0+1',
);

int _isarMessageEstimateSize(
  IsarMessage object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.firebaseMessageId.length * 3;
  bytesCount += 3 + object.senderId.length * 3;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _isarMessageSerialize(
  IsarMessage object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.firebaseMessageId);
  writer.writeBool(offsets[1], object.isSynced);
  writer.writeString(offsets[2], object.senderId);
  writer.writeString(offsets[3], object.text);
  writer.writeLong(offsets[4], object.timestamp);
}

IsarMessage _isarMessageDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMessage();
  object.firebaseMessageId = reader.readString(offsets[0]);
  object.id = id;
  object.isSynced = reader.readBool(offsets[1]);
  object.senderId = reader.readString(offsets[2]);
  object.text = reader.readString(offsets[3]);
  object.timestamp = reader.readLong(offsets[4]);
  return object;
}

P _isarMessageDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarMessageGetId(IsarMessage object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarMessageGetLinks(IsarMessage object) {
  return [object.match];
}

void _isarMessageAttach(
    IsarCollection<dynamic> col, Id id, IsarMessage object) {
  object.id = id;
  object.match.attach(col, col.isar.collection<IsarMatch>(), r'match', id);
}

extension IsarMessageByIndex on IsarCollection<IsarMessage> {
  Future<IsarMessage?> getByFirebaseMessageId(String firebaseMessageId) {
    return getByIndex(r'firebaseMessageId', [firebaseMessageId]);
  }

  IsarMessage? getByFirebaseMessageIdSync(String firebaseMessageId) {
    return getByIndexSync(r'firebaseMessageId', [firebaseMessageId]);
  }

  Future<bool> deleteByFirebaseMessageId(String firebaseMessageId) {
    return deleteByIndex(r'firebaseMessageId', [firebaseMessageId]);
  }

  bool deleteByFirebaseMessageIdSync(String firebaseMessageId) {
    return deleteByIndexSync(r'firebaseMessageId', [firebaseMessageId]);
  }

  Future<List<IsarMessage?>> getAllByFirebaseMessageId(
      List<String> firebaseMessageIdValues) {
    final values = firebaseMessageIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'firebaseMessageId', values);
  }

  List<IsarMessage?> getAllByFirebaseMessageIdSync(
      List<String> firebaseMessageIdValues) {
    final values = firebaseMessageIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'firebaseMessageId', values);
  }

  Future<int> deleteAllByFirebaseMessageId(
      List<String> firebaseMessageIdValues) {
    final values = firebaseMessageIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'firebaseMessageId', values);
  }

  int deleteAllByFirebaseMessageIdSync(List<String> firebaseMessageIdValues) {
    final values = firebaseMessageIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'firebaseMessageId', values);
  }

  Future<Id> putByFirebaseMessageId(IsarMessage object) {
    return putByIndex(r'firebaseMessageId', object);
  }

  Id putByFirebaseMessageIdSync(IsarMessage object, {bool saveLinks = true}) {
    return putByIndexSync(r'firebaseMessageId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFirebaseMessageId(List<IsarMessage> objects) {
    return putAllByIndex(r'firebaseMessageId', objects);
  }

  List<Id> putAllByFirebaseMessageIdSync(List<IsarMessage> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'firebaseMessageId', objects,
        saveLinks: saveLinks);
  }
}

extension IsarMessageQueryWhereSort
    on QueryBuilder<IsarMessage, IsarMessage, QWhere> {
  QueryBuilder<IsarMessage, IsarMessage, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterWhere> anyIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isSynced'),
      );
    });
  }
}

extension IsarMessageQueryWhere
    on QueryBuilder<IsarMessage, IsarMessage, QWhereClause> {
  QueryBuilder<IsarMessage, IsarMessage, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterWhereClause>
      firebaseMessageIdEqualTo(String firebaseMessageId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'firebaseMessageId',
        value: [firebaseMessageId],
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterWhereClause>
      firebaseMessageIdNotEqualTo(String firebaseMessageId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firebaseMessageId',
              lower: [],
              upper: [firebaseMessageId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firebaseMessageId',
              lower: [firebaseMessageId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firebaseMessageId',
              lower: [firebaseMessageId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'firebaseMessageId',
              lower: [],
              upper: [firebaseMessageId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterWhereClause> isSyncedEqualTo(
      bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isSynced',
        value: [isSynced],
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterWhereClause> isSyncedNotEqualTo(
      bool isSynced) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [],
              upper: [isSynced],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [isSynced],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [isSynced],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isSynced',
              lower: [],
              upper: [isSynced],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarMessageQueryFilter
    on QueryBuilder<IsarMessage, IsarMessage, QFilterCondition> {
  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'firebaseMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'firebaseMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'firebaseMessageId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'firebaseMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'firebaseMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'firebaseMessageId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'firebaseMessageId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'firebaseMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      firebaseMessageIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'firebaseMessageId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> isSyncedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSynced',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> senderIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      senderIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      senderIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> senderIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'senderId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      senderIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      senderIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      senderIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'senderId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> senderIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'senderId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      senderIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      senderIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'senderId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> textContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> textMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      timestampEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      timestampGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      timestampLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timestamp',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition>
      timestampBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timestamp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension IsarMessageQueryObject
    on QueryBuilder<IsarMessage, IsarMessage, QFilterCondition> {}

extension IsarMessageQueryLinks
    on QueryBuilder<IsarMessage, IsarMessage, QFilterCondition> {
  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> match(
      FilterQuery<IsarMatch> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'match');
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterFilterCondition> matchIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'match', 0, true, 0, true);
    });
  }
}

extension IsarMessageQuerySortBy
    on QueryBuilder<IsarMessage, IsarMessage, QSortBy> {
  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy>
      sortByFirebaseMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseMessageId', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy>
      sortByFirebaseMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseMessageId', Sort.desc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> sortByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> sortByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> sortBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> sortBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> sortByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> sortByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> sortByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> sortByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension IsarMessageQuerySortThenBy
    on QueryBuilder<IsarMessage, IsarMessage, QSortThenBy> {
  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy>
      thenByFirebaseMessageId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseMessageId', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy>
      thenByFirebaseMessageIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'firebaseMessageId', Sort.desc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenByIsSyncedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSynced', Sort.desc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenBySenderId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenBySenderIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'senderId', Sort.desc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenByText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenByTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'text', Sort.desc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.asc);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QAfterSortBy> thenByTimestampDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timestamp', Sort.desc);
    });
  }
}

extension IsarMessageQueryWhereDistinct
    on QueryBuilder<IsarMessage, IsarMessage, QDistinct> {
  QueryBuilder<IsarMessage, IsarMessage, QDistinct> distinctByFirebaseMessageId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'firebaseMessageId',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QDistinct> distinctByIsSynced() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSynced');
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QDistinct> distinctBySenderId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'senderId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QDistinct> distinctByText(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'text', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<IsarMessage, IsarMessage, QDistinct> distinctByTimestamp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timestamp');
    });
  }
}

extension IsarMessageQueryProperty
    on QueryBuilder<IsarMessage, IsarMessage, QQueryProperty> {
  QueryBuilder<IsarMessage, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarMessage, String, QQueryOperations>
      firebaseMessageIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'firebaseMessageId');
    });
  }

  QueryBuilder<IsarMessage, bool, QQueryOperations> isSyncedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSynced');
    });
  }

  QueryBuilder<IsarMessage, String, QQueryOperations> senderIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'senderId');
    });
  }

  QueryBuilder<IsarMessage, String, QQueryOperations> textProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'text');
    });
  }

  QueryBuilder<IsarMessage, int, QQueryOperations> timestampProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timestamp');
    });
  }
}
