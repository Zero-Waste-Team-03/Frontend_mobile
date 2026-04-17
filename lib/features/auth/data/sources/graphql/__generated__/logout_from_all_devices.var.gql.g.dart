// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'logout_from_all_devices.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GLogoutFromAllDevicesVars> _$gLogoutFromAllDevicesVarsSerializer =
    _$GLogoutFromAllDevicesVarsSerializer();

class _$GLogoutFromAllDevicesVarsSerializer
    implements StructuredSerializer<GLogoutFromAllDevicesVars> {
  @override
  final Iterable<Type> types = const [
    GLogoutFromAllDevicesVars,
    _$GLogoutFromAllDevicesVars,
  ];
  @override
  final String wireName = 'GLogoutFromAllDevicesVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GLogoutFromAllDevicesVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return <Object?>[];
  }

  @override
  GLogoutFromAllDevicesVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GLogoutFromAllDevicesVarsBuilder().build();
  }
}

class _$GLogoutFromAllDevicesVars extends GLogoutFromAllDevicesVars {
  factory _$GLogoutFromAllDevicesVars([
    void Function(GLogoutFromAllDevicesVarsBuilder)? updates,
  ]) => (GLogoutFromAllDevicesVarsBuilder()..update(updates))._build();

  _$GLogoutFromAllDevicesVars._() : super._();
  @override
  GLogoutFromAllDevicesVars rebuild(
    void Function(GLogoutFromAllDevicesVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GLogoutFromAllDevicesVarsBuilder toBuilder() =>
      GLogoutFromAllDevicesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GLogoutFromAllDevicesVars;
  }

  @override
  int get hashCode {
    return 73749168;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(r'GLogoutFromAllDevicesVars').toString();
  }
}

class GLogoutFromAllDevicesVarsBuilder
    implements
        Builder<GLogoutFromAllDevicesVars, GLogoutFromAllDevicesVarsBuilder> {
  _$GLogoutFromAllDevicesVars? _$v;

  GLogoutFromAllDevicesVarsBuilder();

  @override
  void replace(GLogoutFromAllDevicesVars other) {
    _$v = other as _$GLogoutFromAllDevicesVars;
  }

  @override
  void update(void Function(GLogoutFromAllDevicesVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GLogoutFromAllDevicesVars build() => _build();

  _$GLogoutFromAllDevicesVars _build() {
    final _$result = _$v ?? _$GLogoutFromAllDevicesVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
