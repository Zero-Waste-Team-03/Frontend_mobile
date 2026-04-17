// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_reservation.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GConfirmReservationVars> _$gConfirmReservationVarsSerializer =
    _$GConfirmReservationVarsSerializer();

class _$GConfirmReservationVarsSerializer
    implements StructuredSerializer<GConfirmReservationVars> {
  @override
  final Iterable<Type> types = const [
    GConfirmReservationVars,
    _$GConfirmReservationVars,
  ];
  @override
  final String wireName = 'GConfirmReservationVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GConfirmReservationVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GConfirmReservationVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GConfirmReservationVarsBuilder();

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

class _$GConfirmReservationVars extends GConfirmReservationVars {
  @override
  final String id;

  factory _$GConfirmReservationVars([
    void Function(GConfirmReservationVarsBuilder)? updates,
  ]) => (GConfirmReservationVarsBuilder()..update(updates))._build();

  _$GConfirmReservationVars._({required this.id}) : super._();
  @override
  GConfirmReservationVars rebuild(
    void Function(GConfirmReservationVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GConfirmReservationVarsBuilder toBuilder() =>
      GConfirmReservationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GConfirmReservationVars && id == other.id;
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
      r'GConfirmReservationVars',
    )..add('id', id)).toString();
  }
}

class GConfirmReservationVarsBuilder
    implements
        Builder<GConfirmReservationVars, GConfirmReservationVarsBuilder> {
  _$GConfirmReservationVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GConfirmReservationVarsBuilder();

  GConfirmReservationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GConfirmReservationVars other) {
    _$v = other as _$GConfirmReservationVars;
  }

  @override
  void update(void Function(GConfirmReservationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GConfirmReservationVars build() => _build();

  _$GConfirmReservationVars _build() {
    final _$result =
        _$v ??
        _$GConfirmReservationVars._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GConfirmReservationVars',
            'id',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
