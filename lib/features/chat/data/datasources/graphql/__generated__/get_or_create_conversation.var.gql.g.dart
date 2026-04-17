// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_or_create_conversation.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetOrCreateConversationVars>
_$gGetOrCreateConversationVarsSerializer =
    _$GGetOrCreateConversationVarsSerializer();

class _$GGetOrCreateConversationVarsSerializer
    implements StructuredSerializer<GGetOrCreateConversationVars> {
  @override
  final Iterable<Type> types = const [
    GGetOrCreateConversationVars,
    _$GGetOrCreateConversationVars,
  ];
  @override
  final String wireName = 'GGetOrCreateConversationVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetOrCreateConversationVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'reservationId',
      serializers.serialize(
        object.reservationId,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GGetOrCreateConversationVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetOrCreateConversationVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'reservationId':
          result.reservationId =
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

class _$GGetOrCreateConversationVars extends GGetOrCreateConversationVars {
  @override
  final String reservationId;

  factory _$GGetOrCreateConversationVars([
    void Function(GGetOrCreateConversationVarsBuilder)? updates,
  ]) => (GGetOrCreateConversationVarsBuilder()..update(updates))._build();

  _$GGetOrCreateConversationVars._({required this.reservationId}) : super._();
  @override
  GGetOrCreateConversationVars rebuild(
    void Function(GGetOrCreateConversationVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetOrCreateConversationVarsBuilder toBuilder() =>
      GGetOrCreateConversationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetOrCreateConversationVars &&
        reservationId == other.reservationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reservationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GGetOrCreateConversationVars',
    )..add('reservationId', reservationId)).toString();
  }
}

class GGetOrCreateConversationVarsBuilder
    implements
        Builder<
          GGetOrCreateConversationVars,
          GGetOrCreateConversationVarsBuilder
        > {
  _$GGetOrCreateConversationVars? _$v;

  String? _reservationId;
  String? get reservationId => _$this._reservationId;
  set reservationId(String? reservationId) =>
      _$this._reservationId = reservationId;

  GGetOrCreateConversationVarsBuilder();

  GGetOrCreateConversationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reservationId = $v.reservationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetOrCreateConversationVars other) {
    _$v = other as _$GGetOrCreateConversationVars;
  }

  @override
  void update(void Function(GGetOrCreateConversationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetOrCreateConversationVars build() => _build();

  _$GGetOrCreateConversationVars _build() {
    final _$result =
        _$v ??
        _$GGetOrCreateConversationVars._(
          reservationId: BuiltValueNullFieldError.checkNotNull(
            reservationId,
            r'GGetOrCreateConversationVars',
            'reservationId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
