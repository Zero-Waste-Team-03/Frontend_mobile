// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_fields.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GReservationFieldsVars> _$gReservationFieldsVarsSerializer =
    _$GReservationFieldsVarsSerializer();

class _$GReservationFieldsVarsSerializer
    implements StructuredSerializer<GReservationFieldsVars> {
  @override
  final Iterable<Type> types = const [
    GReservationFieldsVars,
    _$GReservationFieldsVars,
  ];
  @override
  final String wireName = 'GReservationFieldsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReservationFieldsVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return <Object?>[];
  }

  @override
  GReservationFieldsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GReservationFieldsVarsBuilder().build();
  }
}

class _$GReservationFieldsVars extends GReservationFieldsVars {
  factory _$GReservationFieldsVars([
    void Function(GReservationFieldsVarsBuilder)? updates,
  ]) => (GReservationFieldsVarsBuilder()..update(updates))._build();

  _$GReservationFieldsVars._() : super._();
  @override
  GReservationFieldsVars rebuild(
    void Function(GReservationFieldsVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReservationFieldsVarsBuilder toBuilder() =>
      GReservationFieldsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReservationFieldsVars;
  }

  @override
  int get hashCode {
    return 598861205;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GReservationFieldsVars').toString();
  }
}

class GReservationFieldsVarsBuilder
    implements Builder<GReservationFieldsVars, GReservationFieldsVarsBuilder> {
  _$GReservationFieldsVars? _$v;

  GReservationFieldsVarsBuilder();

  @override
  void replace(GReservationFieldsVars other) {
    _$v = other as _$GReservationFieldsVars;
  }

  @override
  void update(void Function(GReservationFieldsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReservationFieldsVars build() => _build();

  _$GReservationFieldsVars _build() {
    final _$result = _$v ?? _$GReservationFieldsVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
