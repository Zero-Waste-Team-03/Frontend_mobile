// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_tokens.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRefreshTokensData> _$gRefreshTokensDataSerializer =
    _$GRefreshTokensDataSerializer();
Serializer<GRefreshTokensData_refreshTokens>
_$gRefreshTokensDataRefreshTokensSerializer =
    _$GRefreshTokensData_refreshTokensSerializer();
Serializer<GRefreshTokensData_refreshTokens_user>
_$gRefreshTokensDataRefreshTokensUserSerializer =
    _$GRefreshTokensData_refreshTokens_userSerializer();
Serializer<GRefreshTokensData_refreshTokens_user_location>
_$gRefreshTokensDataRefreshTokensUserLocationSerializer =
    _$GRefreshTokensData_refreshTokens_user_locationSerializer();
Serializer<GRefreshTokensData_refreshTokens_user_avatar>
_$gRefreshTokensDataRefreshTokensUserAvatarSerializer =
    _$GRefreshTokensData_refreshTokens_user_avatarSerializer();

class _$GRefreshTokensDataSerializer
    implements StructuredSerializer<GRefreshTokensData> {
  @override
  final Iterable<Type> types = const [GRefreshTokensData, _$GRefreshTokensData];
  @override
  final String wireName = 'GRefreshTokensData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRefreshTokensData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'refreshTokens',
      serializers.serialize(
        object.refreshTokens,
        specifiedType: const FullType(GRefreshTokensData_refreshTokens),
      ),
    ];

    return result;
  }

  @override
  GRefreshTokensData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRefreshTokensDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'refreshTokens':
          result.refreshTokens.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GRefreshTokensData_refreshTokens,
                  ),
                )!
                as GRefreshTokensData_refreshTokens,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokensData_refreshTokensSerializer
    implements StructuredSerializer<GRefreshTokensData_refreshTokens> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokensData_refreshTokens,
    _$GRefreshTokensData_refreshTokens,
  ];
  @override
  final String wireName = 'GRefreshTokensData_refreshTokens';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRefreshTokensData_refreshTokens object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'accessToken',
      serializers.serialize(
        object.accessToken,
        specifiedType: const FullType(String),
      ),
      'refreshToken',
      serializers.serialize(
        object.refreshToken,
        specifiedType: const FullType(String),
      ),
      'user',
      serializers.serialize(
        object.user,
        specifiedType: const FullType(GRefreshTokensData_refreshTokens_user),
      ),
    ];

    return result;
  }

  @override
  GRefreshTokensData_refreshTokens deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRefreshTokensData_refreshTokensBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'accessToken':
          result.accessToken =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'refreshToken':
          result.refreshToken =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'user':
          result.user.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GRefreshTokensData_refreshTokens_user,
                  ),
                )!
                as GRefreshTokensData_refreshTokens_user,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokensData_refreshTokens_userSerializer
    implements StructuredSerializer<GRefreshTokensData_refreshTokens_user> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokensData_refreshTokens_user,
    _$GRefreshTokensData_refreshTokens_user,
  ];
  @override
  final String wireName = 'GRefreshTokensData_refreshTokens_user';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRefreshTokensData_refreshTokens_user object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'email',
      serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      ),
      'role',
      serializers.serialize(
        object.role,
        specifiedType: const FullType(_i3.GUserRole),
      ),
      'isMailVerified',
      serializers.serialize(
        object.isMailVerified,
        specifiedType: const FullType(bool),
      ),
      'reputationScore',
      serializers.serialize(
        object.reputationScore,
        specifiedType: const FullType(int),
      ),
    ];
    Object? value;
    value = object.displayName;
    if (value != null) {
      result
        ..add('displayName')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phoneNumber')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.locationId;
    if (value != null) {
      result
        ..add('locationId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GRefreshTokensData_refreshTokens_user_location,
            ),
          ),
        );
    }
    value = object.avatar;
    if (value != null) {
      result
        ..add('avatar')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GRefreshTokensData_refreshTokens_user_avatar,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GRefreshTokensData_refreshTokens_user deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRefreshTokensData_refreshTokens_userBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'email':
          result.email =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'displayName':
          result.displayName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'role':
          result.role =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i3.GUserRole),
                  )!
                  as _i3.GUserRole;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'isMailVerified':
          result.isMailVerified =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'phoneNumber':
          result.phoneNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'reputationScore':
          result.reputationScore =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'locationId':
          result.locationId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'location':
          result.location.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GRefreshTokensData_refreshTokens_user_location,
                  ),
                )!
                as GRefreshTokensData_refreshTokens_user_location,
          );
          break;
        case 'avatar':
          result.avatar.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GRefreshTokensData_refreshTokens_user_avatar,
                  ),
                )!
                as GRefreshTokensData_refreshTokens_user_avatar,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokensData_refreshTokens_user_locationSerializer
    implements
        StructuredSerializer<GRefreshTokensData_refreshTokens_user_location> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokensData_refreshTokens_user_location,
    _$GRefreshTokensData_refreshTokens_user_location,
  ];
  @override
  final String wireName = 'GRefreshTokensData_refreshTokens_user_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRefreshTokensData_refreshTokens_user_location object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.city;
    if (value != null) {
      result
        ..add('city')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.country;
    if (value != null) {
      result
        ..add('country')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.latitude;
    if (value != null) {
      result
        ..add('latitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.longitude;
    if (value != null) {
      result
        ..add('longitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.neighborhood;
    if (value != null) {
      result
        ..add('neighborhood')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GRefreshTokensData_refreshTokens_user_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRefreshTokensData_refreshTokens_user_locationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'city':
          result.city =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'country':
          result.country =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'latitude':
          result.latitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'longitude':
          result.longitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'neighborhood':
          result.neighborhood =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokensData_refreshTokens_user_avatarSerializer
    implements
        StructuredSerializer<GRefreshTokensData_refreshTokens_user_avatar> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokensData_refreshTokens_user_avatar,
    _$GRefreshTokensData_refreshTokens_user_avatar,
  ];
  @override
  final String wireName = 'GRefreshTokensData_refreshTokens_user_avatar';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRefreshTokensData_refreshTokens_user_avatar object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'fileType',
      serializers.serialize(
        object.fileType,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.url;
    if (value != null) {
      result
        ..add('url')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GRefreshTokensData_refreshTokens_user_avatar deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRefreshTokensData_refreshTokens_user_avatarBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'url':
          result.url =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'fileType':
          result.fileType =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokensData extends GRefreshTokensData {
  @override
  final String G__typename;
  @override
  final GRefreshTokensData_refreshTokens refreshTokens;

  factory _$GRefreshTokensData([
    void Function(GRefreshTokensDataBuilder)? updates,
  ]) => (GRefreshTokensDataBuilder()..update(updates))._build();

  _$GRefreshTokensData._({
    required this.G__typename,
    required this.refreshTokens,
  }) : super._();
  @override
  GRefreshTokensData rebuild(
    void Function(GRefreshTokensDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRefreshTokensDataBuilder toBuilder() =>
      GRefreshTokensDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokensData &&
        G__typename == other.G__typename &&
        refreshTokens == other.refreshTokens;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, refreshTokens.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRefreshTokensData')
          ..add('G__typename', G__typename)
          ..add('refreshTokens', refreshTokens))
        .toString();
  }
}

class GRefreshTokensDataBuilder
    implements Builder<GRefreshTokensData, GRefreshTokensDataBuilder> {
  _$GRefreshTokensData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRefreshTokensData_refreshTokensBuilder? _refreshTokens;
  GRefreshTokensData_refreshTokensBuilder get refreshTokens =>
      _$this._refreshTokens ??= GRefreshTokensData_refreshTokensBuilder();
  set refreshTokens(GRefreshTokensData_refreshTokensBuilder? refreshTokens) =>
      _$this._refreshTokens = refreshTokens;

  GRefreshTokensDataBuilder() {
    GRefreshTokensData._initializeBuilder(this);
  }

  GRefreshTokensDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _refreshTokens = $v.refreshTokens.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokensData other) {
    _$v = other as _$GRefreshTokensData;
  }

  @override
  void update(void Function(GRefreshTokensDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokensData build() => _build();

  _$GRefreshTokensData _build() {
    _$GRefreshTokensData _$result;
    try {
      _$result =
          _$v ??
          _$GRefreshTokensData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRefreshTokensData',
              'G__typename',
            ),
            refreshTokens: refreshTokens.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'refreshTokens';
        refreshTokens.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GRefreshTokensData',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokensData_refreshTokens
    extends GRefreshTokensData_refreshTokens {
  @override
  final String G__typename;
  @override
  final String accessToken;
  @override
  final String refreshToken;
  @override
  final GRefreshTokensData_refreshTokens_user user;

  factory _$GRefreshTokensData_refreshTokens([
    void Function(GRefreshTokensData_refreshTokensBuilder)? updates,
  ]) => (GRefreshTokensData_refreshTokensBuilder()..update(updates))._build();

  _$GRefreshTokensData_refreshTokens._({
    required this.G__typename,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  }) : super._();
  @override
  GRefreshTokensData_refreshTokens rebuild(
    void Function(GRefreshTokensData_refreshTokensBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRefreshTokensData_refreshTokensBuilder toBuilder() =>
      GRefreshTokensData_refreshTokensBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokensData_refreshTokens &&
        G__typename == other.G__typename &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken &&
        user == other.user;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jc(_$hash, user.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GRefreshTokensData_refreshTokens')
          ..add('G__typename', G__typename)
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken)
          ..add('user', user))
        .toString();
  }
}

class GRefreshTokensData_refreshTokensBuilder
    implements
        Builder<
          GRefreshTokensData_refreshTokens,
          GRefreshTokensData_refreshTokensBuilder
        > {
  _$GRefreshTokensData_refreshTokens? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  GRefreshTokensData_refreshTokens_userBuilder? _user;
  GRefreshTokensData_refreshTokens_userBuilder get user =>
      _$this._user ??= GRefreshTokensData_refreshTokens_userBuilder();
  set user(GRefreshTokensData_refreshTokens_userBuilder? user) =>
      _$this._user = user;

  GRefreshTokensData_refreshTokensBuilder() {
    GRefreshTokensData_refreshTokens._initializeBuilder(this);
  }

  GRefreshTokensData_refreshTokensBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _user = $v.user.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokensData_refreshTokens other) {
    _$v = other as _$GRefreshTokensData_refreshTokens;
  }

  @override
  void update(void Function(GRefreshTokensData_refreshTokensBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokensData_refreshTokens build() => _build();

  _$GRefreshTokensData_refreshTokens _build() {
    _$GRefreshTokensData_refreshTokens _$result;
    try {
      _$result =
          _$v ??
          _$GRefreshTokensData_refreshTokens._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRefreshTokensData_refreshTokens',
              'G__typename',
            ),
            accessToken: BuiltValueNullFieldError.checkNotNull(
              accessToken,
              r'GRefreshTokensData_refreshTokens',
              'accessToken',
            ),
            refreshToken: BuiltValueNullFieldError.checkNotNull(
              refreshToken,
              r'GRefreshTokensData_refreshTokens',
              'refreshToken',
            ),
            user: user.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'user';
        user.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GRefreshTokensData_refreshTokens',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokensData_refreshTokens_user
    extends GRefreshTokensData_refreshTokens_user {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final _i3.GUserRole role;
  @override
  final String? description;
  @override
  final bool isMailVerified;
  @override
  final String? phoneNumber;
  @override
  final int reputationScore;
  @override
  final String? locationId;
  @override
  final GRefreshTokensData_refreshTokens_user_location? location;
  @override
  final GRefreshTokensData_refreshTokens_user_avatar? avatar;

  factory _$GRefreshTokensData_refreshTokens_user([
    void Function(GRefreshTokensData_refreshTokens_userBuilder)? updates,
  ]) => (GRefreshTokensData_refreshTokens_userBuilder()..update(updates))
      ._build();

  _$GRefreshTokensData_refreshTokens_user._({
    required this.G__typename,
    required this.id,
    required this.email,
    this.displayName,
    required this.role,
    this.description,
    required this.isMailVerified,
    this.phoneNumber,
    required this.reputationScore,
    this.locationId,
    this.location,
    this.avatar,
  }) : super._();
  @override
  GRefreshTokensData_refreshTokens_user rebuild(
    void Function(GRefreshTokensData_refreshTokens_userBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRefreshTokensData_refreshTokens_userBuilder toBuilder() =>
      GRefreshTokensData_refreshTokens_userBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokensData_refreshTokens_user &&
        G__typename == other.G__typename &&
        id == other.id &&
        email == other.email &&
        displayName == other.displayName &&
        role == other.role &&
        description == other.description &&
        isMailVerified == other.isMailVerified &&
        phoneNumber == other.phoneNumber &&
        reputationScore == other.reputationScore &&
        locationId == other.locationId &&
        location == other.location &&
        avatar == other.avatar;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isMailVerified.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, reputationScore.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRefreshTokensData_refreshTokens_user',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('role', role)
          ..add('description', description)
          ..add('isMailVerified', isMailVerified)
          ..add('phoneNumber', phoneNumber)
          ..add('reputationScore', reputationScore)
          ..add('locationId', locationId)
          ..add('location', location)
          ..add('avatar', avatar))
        .toString();
  }
}

class GRefreshTokensData_refreshTokens_userBuilder
    implements
        Builder<
          GRefreshTokensData_refreshTokens_user,
          GRefreshTokensData_refreshTokens_userBuilder
        > {
  _$GRefreshTokensData_refreshTokens_user? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  _i3.GUserRole? _role;
  _i3.GUserRole? get role => _$this._role;
  set role(_i3.GUserRole? role) => _$this._role = role;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isMailVerified;
  bool? get isMailVerified => _$this._isMailVerified;
  set isMailVerified(bool? isMailVerified) =>
      _$this._isMailVerified = isMailVerified;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  int? _reputationScore;
  int? get reputationScore => _$this._reputationScore;
  set reputationScore(int? reputationScore) =>
      _$this._reputationScore = reputationScore;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  GRefreshTokensData_refreshTokens_user_locationBuilder? _location;
  GRefreshTokensData_refreshTokens_user_locationBuilder get location =>
      _$this._location ??=
          GRefreshTokensData_refreshTokens_user_locationBuilder();
  set location(
    GRefreshTokensData_refreshTokens_user_locationBuilder? location,
  ) => _$this._location = location;

  GRefreshTokensData_refreshTokens_user_avatarBuilder? _avatar;
  GRefreshTokensData_refreshTokens_user_avatarBuilder get avatar =>
      _$this._avatar ??= GRefreshTokensData_refreshTokens_user_avatarBuilder();
  set avatar(GRefreshTokensData_refreshTokens_user_avatarBuilder? avatar) =>
      _$this._avatar = avatar;

  GRefreshTokensData_refreshTokens_userBuilder() {
    GRefreshTokensData_refreshTokens_user._initializeBuilder(this);
  }

  GRefreshTokensData_refreshTokens_userBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _email = $v.email;
      _displayName = $v.displayName;
      _role = $v.role;
      _description = $v.description;
      _isMailVerified = $v.isMailVerified;
      _phoneNumber = $v.phoneNumber;
      _reputationScore = $v.reputationScore;
      _locationId = $v.locationId;
      _location = $v.location?.toBuilder();
      _avatar = $v.avatar?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokensData_refreshTokens_user other) {
    _$v = other as _$GRefreshTokensData_refreshTokens_user;
  }

  @override
  void update(
    void Function(GRefreshTokensData_refreshTokens_userBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokensData_refreshTokens_user build() => _build();

  _$GRefreshTokensData_refreshTokens_user _build() {
    _$GRefreshTokensData_refreshTokens_user _$result;
    try {
      _$result =
          _$v ??
          _$GRefreshTokensData_refreshTokens_user._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRefreshTokensData_refreshTokens_user',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GRefreshTokensData_refreshTokens_user',
              'id',
            ),
            email: BuiltValueNullFieldError.checkNotNull(
              email,
              r'GRefreshTokensData_refreshTokens_user',
              'email',
            ),
            displayName: displayName,
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'GRefreshTokensData_refreshTokens_user',
              'role',
            ),
            description: description,
            isMailVerified: BuiltValueNullFieldError.checkNotNull(
              isMailVerified,
              r'GRefreshTokensData_refreshTokens_user',
              'isMailVerified',
            ),
            phoneNumber: phoneNumber,
            reputationScore: BuiltValueNullFieldError.checkNotNull(
              reputationScore,
              r'GRefreshTokensData_refreshTokens_user',
              'reputationScore',
            ),
            locationId: locationId,
            location: _location?.build(),
            avatar: _avatar?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
        _$failedField = 'avatar';
        _avatar?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GRefreshTokensData_refreshTokens_user',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokensData_refreshTokens_user_location
    extends GRefreshTokensData_refreshTokens_user_location {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? neighborhood;

  factory _$GRefreshTokensData_refreshTokens_user_location([
    void Function(GRefreshTokensData_refreshTokens_user_locationBuilder)?
    updates,
  ]) =>
      (GRefreshTokensData_refreshTokens_user_locationBuilder()..update(updates))
          ._build();

  _$GRefreshTokensData_refreshTokens_user_location._({
    required this.G__typename,
    required this.id,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.neighborhood,
  }) : super._();
  @override
  GRefreshTokensData_refreshTokens_user_location rebuild(
    void Function(GRefreshTokensData_refreshTokens_user_locationBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRefreshTokensData_refreshTokens_user_locationBuilder toBuilder() =>
      GRefreshTokensData_refreshTokens_user_locationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokensData_refreshTokens_user_location &&
        G__typename == other.G__typename &&
        id == other.id &&
        city == other.city &&
        country == other.country &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        neighborhood == other.neighborhood;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, neighborhood.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRefreshTokensData_refreshTokens_user_location',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('city', city)
          ..add('country', country)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('neighborhood', neighborhood))
        .toString();
  }
}

class GRefreshTokensData_refreshTokens_user_locationBuilder
    implements
        Builder<
          GRefreshTokensData_refreshTokens_user_location,
          GRefreshTokensData_refreshTokens_user_locationBuilder
        > {
  _$GRefreshTokensData_refreshTokens_user_location? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  String? _neighborhood;
  String? get neighborhood => _$this._neighborhood;
  set neighborhood(String? neighborhood) => _$this._neighborhood = neighborhood;

  GRefreshTokensData_refreshTokens_user_locationBuilder() {
    GRefreshTokensData_refreshTokens_user_location._initializeBuilder(this);
  }

  GRefreshTokensData_refreshTokens_user_locationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _city = $v.city;
      _country = $v.country;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _neighborhood = $v.neighborhood;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokensData_refreshTokens_user_location other) {
    _$v = other as _$GRefreshTokensData_refreshTokens_user_location;
  }

  @override
  void update(
    void Function(GRefreshTokensData_refreshTokens_user_locationBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokensData_refreshTokens_user_location build() => _build();

  _$GRefreshTokensData_refreshTokens_user_location _build() {
    final _$result =
        _$v ??
        _$GRefreshTokensData_refreshTokens_user_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GRefreshTokensData_refreshTokens_user_location',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GRefreshTokensData_refreshTokens_user_location',
            'id',
          ),
          city: city,
          country: country,
          latitude: latitude,
          longitude: longitude,
          neighborhood: neighborhood,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GRefreshTokensData_refreshTokens_user_avatar
    extends GRefreshTokensData_refreshTokens_user_avatar {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? url;
  @override
  final String fileType;

  factory _$GRefreshTokensData_refreshTokens_user_avatar([
    void Function(GRefreshTokensData_refreshTokens_user_avatarBuilder)? updates,
  ]) => (GRefreshTokensData_refreshTokens_user_avatarBuilder()..update(updates))
      ._build();

  _$GRefreshTokensData_refreshTokens_user_avatar._({
    required this.G__typename,
    required this.id,
    this.url,
    required this.fileType,
  }) : super._();
  @override
  GRefreshTokensData_refreshTokens_user_avatar rebuild(
    void Function(GRefreshTokensData_refreshTokens_user_avatarBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRefreshTokensData_refreshTokens_user_avatarBuilder toBuilder() =>
      GRefreshTokensData_refreshTokens_user_avatarBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokensData_refreshTokens_user_avatar &&
        G__typename == other.G__typename &&
        id == other.id &&
        url == other.url &&
        fileType == other.fileType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, fileType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRefreshTokensData_refreshTokens_user_avatar',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('url', url)
          ..add('fileType', fileType))
        .toString();
  }
}

class GRefreshTokensData_refreshTokens_user_avatarBuilder
    implements
        Builder<
          GRefreshTokensData_refreshTokens_user_avatar,
          GRefreshTokensData_refreshTokens_user_avatarBuilder
        > {
  _$GRefreshTokensData_refreshTokens_user_avatar? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _fileType;
  String? get fileType => _$this._fileType;
  set fileType(String? fileType) => _$this._fileType = fileType;

  GRefreshTokensData_refreshTokens_user_avatarBuilder() {
    GRefreshTokensData_refreshTokens_user_avatar._initializeBuilder(this);
  }

  GRefreshTokensData_refreshTokens_user_avatarBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _url = $v.url;
      _fileType = $v.fileType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokensData_refreshTokens_user_avatar other) {
    _$v = other as _$GRefreshTokensData_refreshTokens_user_avatar;
  }

  @override
  void update(
    void Function(GRefreshTokensData_refreshTokens_user_avatarBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokensData_refreshTokens_user_avatar build() => _build();

  _$GRefreshTokensData_refreshTokens_user_avatar _build() {
    final _$result =
        _$v ??
        _$GRefreshTokensData_refreshTokens_user_avatar._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GRefreshTokensData_refreshTokens_user_avatar',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GRefreshTokensData_refreshTokens_user_avatar',
            'id',
          ),
          url: url,
          fileType: BuiltValueNullFieldError.checkNotNull(
            fileType,
            r'GRefreshTokensData_refreshTokens_user_avatar',
            'fileType',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
