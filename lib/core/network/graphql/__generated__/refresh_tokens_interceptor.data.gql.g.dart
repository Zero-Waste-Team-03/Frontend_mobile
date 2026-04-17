// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_tokens_interceptor.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GRefreshTokensForInterceptorData>
_$gRefreshTokensForInterceptorDataSerializer =
    _$GRefreshTokensForInterceptorDataSerializer();
Serializer<GRefreshTokensForInterceptorData_refreshTokens>
_$gRefreshTokensForInterceptorDataRefreshTokensSerializer =
    _$GRefreshTokensForInterceptorData_refreshTokensSerializer();

class _$GRefreshTokensForInterceptorDataSerializer
    implements StructuredSerializer<GRefreshTokensForInterceptorData> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokensForInterceptorData,
    _$GRefreshTokensForInterceptorData,
  ];
  @override
  final String wireName = 'GRefreshTokensForInterceptorData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRefreshTokensForInterceptorData object, {
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
        specifiedType: const FullType(
          GRefreshTokensForInterceptorData_refreshTokens,
        ),
      ),
    ];

    return result;
  }

  @override
  GRefreshTokensForInterceptorData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRefreshTokensForInterceptorDataBuilder();

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
                    GRefreshTokensForInterceptorData_refreshTokens,
                  ),
                )!
                as GRefreshTokensForInterceptorData_refreshTokens,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GRefreshTokensForInterceptorData_refreshTokensSerializer
    implements
        StructuredSerializer<GRefreshTokensForInterceptorData_refreshTokens> {
  @override
  final Iterable<Type> types = const [
    GRefreshTokensForInterceptorData_refreshTokens,
    _$GRefreshTokensForInterceptorData_refreshTokens,
  ];
  @override
  final String wireName = 'GRefreshTokensForInterceptorData_refreshTokens';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GRefreshTokensForInterceptorData_refreshTokens object, {
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
    ];

    return result;
  }

  @override
  GRefreshTokensForInterceptorData_refreshTokens deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GRefreshTokensForInterceptorData_refreshTokensBuilder();

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
      }
    }

    return result.build();
  }
}

class _$GRefreshTokensForInterceptorData
    extends GRefreshTokensForInterceptorData {
  @override
  final String G__typename;
  @override
  final GRefreshTokensForInterceptorData_refreshTokens refreshTokens;

  factory _$GRefreshTokensForInterceptorData([
    void Function(GRefreshTokensForInterceptorDataBuilder)? updates,
  ]) => (GRefreshTokensForInterceptorDataBuilder()..update(updates))._build();

  _$GRefreshTokensForInterceptorData._({
    required this.G__typename,
    required this.refreshTokens,
  }) : super._();
  @override
  GRefreshTokensForInterceptorData rebuild(
    void Function(GRefreshTokensForInterceptorDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRefreshTokensForInterceptorDataBuilder toBuilder() =>
      GRefreshTokensForInterceptorDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokensForInterceptorData &&
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
    return (newBuiltValueToStringHelper(r'GRefreshTokensForInterceptorData')
          ..add('G__typename', G__typename)
          ..add('refreshTokens', refreshTokens))
        .toString();
  }
}

class GRefreshTokensForInterceptorDataBuilder
    implements
        Builder<
          GRefreshTokensForInterceptorData,
          GRefreshTokensForInterceptorDataBuilder
        > {
  _$GRefreshTokensForInterceptorData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GRefreshTokensForInterceptorData_refreshTokensBuilder? _refreshTokens;
  GRefreshTokensForInterceptorData_refreshTokensBuilder get refreshTokens =>
      _$this._refreshTokens ??=
          GRefreshTokensForInterceptorData_refreshTokensBuilder();
  set refreshTokens(
    GRefreshTokensForInterceptorData_refreshTokensBuilder? refreshTokens,
  ) => _$this._refreshTokens = refreshTokens;

  GRefreshTokensForInterceptorDataBuilder() {
    GRefreshTokensForInterceptorData._initializeBuilder(this);
  }

  GRefreshTokensForInterceptorDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _refreshTokens = $v.refreshTokens.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokensForInterceptorData other) {
    _$v = other as _$GRefreshTokensForInterceptorData;
  }

  @override
  void update(void Function(GRefreshTokensForInterceptorDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokensForInterceptorData build() => _build();

  _$GRefreshTokensForInterceptorData _build() {
    _$GRefreshTokensForInterceptorData _$result;
    try {
      _$result =
          _$v ??
          _$GRefreshTokensForInterceptorData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GRefreshTokensForInterceptorData',
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
          r'GRefreshTokensForInterceptorData',
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

class _$GRefreshTokensForInterceptorData_refreshTokens
    extends GRefreshTokensForInterceptorData_refreshTokens {
  @override
  final String G__typename;
  @override
  final String accessToken;
  @override
  final String refreshToken;

  factory _$GRefreshTokensForInterceptorData_refreshTokens([
    void Function(GRefreshTokensForInterceptorData_refreshTokensBuilder)?
    updates,
  ]) =>
      (GRefreshTokensForInterceptorData_refreshTokensBuilder()..update(updates))
          ._build();

  _$GRefreshTokensForInterceptorData_refreshTokens._({
    required this.G__typename,
    required this.accessToken,
    required this.refreshToken,
  }) : super._();
  @override
  GRefreshTokensForInterceptorData_refreshTokens rebuild(
    void Function(GRefreshTokensForInterceptorData_refreshTokensBuilder)
    updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GRefreshTokensForInterceptorData_refreshTokensBuilder toBuilder() =>
      GRefreshTokensForInterceptorData_refreshTokensBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GRefreshTokensForInterceptorData_refreshTokens &&
        G__typename == other.G__typename &&
        accessToken == other.accessToken &&
        refreshToken == other.refreshToken;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, accessToken.hashCode);
    _$hash = $jc(_$hash, refreshToken.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GRefreshTokensForInterceptorData_refreshTokens',
          )
          ..add('G__typename', G__typename)
          ..add('accessToken', accessToken)
          ..add('refreshToken', refreshToken))
        .toString();
  }
}

class GRefreshTokensForInterceptorData_refreshTokensBuilder
    implements
        Builder<
          GRefreshTokensForInterceptorData_refreshTokens,
          GRefreshTokensForInterceptorData_refreshTokensBuilder
        > {
  _$GRefreshTokensForInterceptorData_refreshTokens? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _accessToken;
  String? get accessToken => _$this._accessToken;
  set accessToken(String? accessToken) => _$this._accessToken = accessToken;

  String? _refreshToken;
  String? get refreshToken => _$this._refreshToken;
  set refreshToken(String? refreshToken) => _$this._refreshToken = refreshToken;

  GRefreshTokensForInterceptorData_refreshTokensBuilder() {
    GRefreshTokensForInterceptorData_refreshTokens._initializeBuilder(this);
  }

  GRefreshTokensForInterceptorData_refreshTokensBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _accessToken = $v.accessToken;
      _refreshToken = $v.refreshToken;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GRefreshTokensForInterceptorData_refreshTokens other) {
    _$v = other as _$GRefreshTokensForInterceptorData_refreshTokens;
  }

  @override
  void update(
    void Function(GRefreshTokensForInterceptorData_refreshTokensBuilder)?
    updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GRefreshTokensForInterceptorData_refreshTokens build() => _build();

  _$GRefreshTokensForInterceptorData_refreshTokens _build() {
    final _$result =
        _$v ??
        _$GRefreshTokensForInterceptorData_refreshTokens._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GRefreshTokensForInterceptorData_refreshTokens',
            'G__typename',
          ),
          accessToken: BuiltValueNullFieldError.checkNotNull(
            accessToken,
            r'GRefreshTokensForInterceptorData_refreshTokens',
            'accessToken',
          ),
          refreshToken: BuiltValueNullFieldError.checkNotNull(
            refreshToken,
            r'GRefreshTokensForInterceptorData_refreshTokens',
            'refreshToken',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
