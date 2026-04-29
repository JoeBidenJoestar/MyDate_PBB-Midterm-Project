// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'isar_match.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetIsarMatchCollection on Isar {
  IsarCollection<IsarMatch> get isarMatchs => this.collection();
}

const IsarMatchSchema = CollectionSchema(
  name: r'IsarMatch',
  id: -2075035109113596846,
  properties: {
    r'matchId': PropertySchema(
      id: 0,
      name: r'matchId',
      type: IsarType.string,
    )
  },
  estimateSize: _isarMatchEstimateSize,
  serialize: _isarMatchSerialize,
  deserialize: _isarMatchDeserialize,
  deserializeProp: _isarMatchDeserializeProp,
  idName: r'id',
  indexes: {
    r'matchId': IndexSchema(
      id: -6517933327003962923,
      name: r'matchId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'matchId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {
    r'matchedUser': LinkSchema(
      id: -6474694829186395002,
      name: r'matchedUser',
      target: r'IsarUser',
      single: true,
    ),
    r'messages': LinkSchema(
      id: 5174045922656994204,
      name: r'messages',
      target: r'IsarMessage',
      single: false,
      linkName: r'match',
    )
  },
  embeddedSchemas: {},
  getId: _isarMatchGetId,
  getLinks: _isarMatchGetLinks,
  attach: _isarMatchAttach,
  version: '3.1.0+1',
);

int _isarMatchEstimateSize(
  IsarMatch object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.matchId.length * 3;
  return bytesCount;
}

void _isarMatchSerialize(
  IsarMatch object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.matchId);
}

IsarMatch _isarMatchDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = IsarMatch();
  object.id = id;
  object.matchId = reader.readString(offsets[0]);
  return object;
}

P _isarMatchDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _isarMatchGetId(IsarMatch object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _isarMatchGetLinks(IsarMatch object) {
  return [object.matchedUser, object.messages];
}

void _isarMatchAttach(IsarCollection<dynamic> col, Id id, IsarMatch object) {
  object.id = id;
  object.matchedUser
      .attach(col, col.isar.collection<IsarUser>(), r'matchedUser', id);
  object.messages
      .attach(col, col.isar.collection<IsarMessage>(), r'messages', id);
}

extension IsarMatchByIndex on IsarCollection<IsarMatch> {
  Future<IsarMatch?> getByMatchId(String matchId) {
    return getByIndex(r'matchId', [matchId]);
  }

  IsarMatch? getByMatchIdSync(String matchId) {
    return getByIndexSync(r'matchId', [matchId]);
  }

  Future<bool> deleteByMatchId(String matchId) {
    return deleteByIndex(r'matchId', [matchId]);
  }

  bool deleteByMatchIdSync(String matchId) {
    return deleteByIndexSync(r'matchId', [matchId]);
  }

  Future<List<IsarMatch?>> getAllByMatchId(List<String> matchIdValues) {
    final values = matchIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'matchId', values);
  }

  List<IsarMatch?> getAllByMatchIdSync(List<String> matchIdValues) {
    final values = matchIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'matchId', values);
  }

  Future<int> deleteAllByMatchId(List<String> matchIdValues) {
    final values = matchIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'matchId', values);
  }

  int deleteAllByMatchIdSync(List<String> matchIdValues) {
    final values = matchIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'matchId', values);
  }

  Future<Id> putByMatchId(IsarMatch object) {
    return putByIndex(r'matchId', object);
  }

  Id putByMatchIdSync(IsarMatch object, {bool saveLinks = true}) {
    return putByIndexSync(r'matchId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMatchId(List<IsarMatch> objects) {
    return putAllByIndex(r'matchId', objects);
  }

  List<Id> putAllByMatchIdSync(List<IsarMatch> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'matchId', objects, saveLinks: saveLinks);
  }
}

extension IsarMatchQueryWhereSort
    on QueryBuilder<IsarMatch, IsarMatch, QWhere> {
  QueryBuilder<IsarMatch, IsarMatch, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension IsarMatchQueryWhere
    on QueryBuilder<IsarMatch, IsarMatch, QWhereClause> {
  QueryBuilder<IsarMatch, IsarMatch, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<IsarMatch, IsarMatch, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterWhereClause> idBetween(
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

  QueryBuilder<IsarMatch, IsarMatch, QAfterWhereClause> matchIdEqualTo(
      String matchId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'matchId',
        value: [matchId],
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterWhereClause> matchIdNotEqualTo(
      String matchId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'matchId',
              lower: [],
              upper: [matchId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'matchId',
              lower: [matchId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'matchId',
              lower: [matchId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'matchId',
              lower: [],
              upper: [matchId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension IsarMatchQueryFilter
    on QueryBuilder<IsarMatch, IsarMatch, QFilterCondition> {
  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> idBetween(
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

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'matchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'matchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'matchId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'matchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'matchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'matchId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'matchId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'matchId',
        value: '',
      ));
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition>
      matchIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'matchId',
        value: '',
      ));
    });
  }
}

extension IsarMatchQueryObject
    on QueryBuilder<IsarMatch, IsarMatch, QFilterCondition> {}

extension IsarMatchQueryLinks
    on QueryBuilder<IsarMatch, IsarMatch, QFilterCondition> {
  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> matchedUser(
      FilterQuery<IsarUser> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'matchedUser');
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition>
      matchedUserIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'matchedUser', 0, true, 0, true);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> messages(
      FilterQuery<IsarMessage> q) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'messages');
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition>
      messagesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'messages', length, true, length, true);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition> messagesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'messages', 0, true, 0, true);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition>
      messagesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'messages', 0, false, 999999, true);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition>
      messagesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'messages', 0, true, length, include);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition>
      messagesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'messages', length, include, 999999, true);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterFilterCondition>
      messagesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
          r'messages', lower, includeLower, upper, includeUpper);
    });
  }
}

extension IsarMatchQuerySortBy on QueryBuilder<IsarMatch, IsarMatch, QSortBy> {
  QueryBuilder<IsarMatch, IsarMatch, QAfterSortBy> sortByMatchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchId', Sort.asc);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterSortBy> sortByMatchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchId', Sort.desc);
    });
  }
}

extension IsarMatchQuerySortThenBy
    on QueryBuilder<IsarMatch, IsarMatch, QSortThenBy> {
  QueryBuilder<IsarMatch, IsarMatch, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterSortBy> thenByMatchId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchId', Sort.asc);
    });
  }

  QueryBuilder<IsarMatch, IsarMatch, QAfterSortBy> thenByMatchIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'matchId', Sort.desc);
    });
  }
}

extension IsarMatchQueryWhereDistinct
    on QueryBuilder<IsarMatch, IsarMatch, QDistinct> {
  QueryBuilder<IsarMatch, IsarMatch, QDistinct> distinctByMatchId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'matchId', caseSensitive: caseSensitive);
    });
  }
}

extension IsarMatchQueryProperty
    on QueryBuilder<IsarMatch, IsarMatch, QQueryProperty> {
  QueryBuilder<IsarMatch, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<IsarMatch, String, QQueryOperations> matchIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'matchId');
    });
  }
}
