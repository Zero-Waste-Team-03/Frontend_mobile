// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reservation.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyReservationVars> _$gMyReservationVarsSerializer =
    _$GMyReservationVarsSerializer();

class _$GMyReservationVarsSerializer
    implements StructuredSerializer<GMyReservationVars> {
  @override
  final Iterable<Type> types = const [GMyReservationVars, _$GMyReservationVars];
  @override
  final String wireName = 'GMyReservationVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GMyReservationVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'id':
          result.id =
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

class _$GMyReservationVars extends GMyReservationVars {
  @override
  final String id;

  factory _$GMyReservationVars([
    void Function(GMyReservationVarsBuilder)? updates,
  ]) => (GMyReservationVarsBuilder()..update(updates))._build();

  _$GMyReservationVars._({required this.id}) : super._();
  @override
  GMyReservationVars rebuild(
    void Function(GMyReservationVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationVarsBuilder toBuilder() =>
      GMyReservationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationVars && id == other.id;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GMyReservationVars',
    )..add('id', id)).toString();
  }
}

class GMyReservationVarsBuilder
    implements Builder<GMyReservationVars, GMyReservationVarsBuilder> {
  _$GMyReservationVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GMyReservationVarsBuilder();

  GMyReservationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationVars other) {
    _$v = other as _$GMyReservationVars;
  }

  @override
  void update(void Function(GMyReservationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationVars build() => _build();

  _$GMyReservationVars _build() {
    final _$result =
        _$v ??
        _$GMyReservationVars._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GMyReservationVars',
            'id',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
