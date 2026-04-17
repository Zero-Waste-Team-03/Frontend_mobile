// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateProfileVars> _$gUpdateProfileVarsSerializer =
    _$GUpdateProfileVarsSerializer();

class _$GUpdateProfileVarsSerializer
    implements StructuredSerializer<GUpdateProfileVars> {
  @override
  final Iterable<Type> types = const [GUpdateProfileVars, _$GUpdateProfileVars];
  @override
  final String wireName = 'GUpdateProfileVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'updateProfileInput',
      serializers.serialize(
        object.updateProfileInput,
        specifiedType: const FullType(_i1.GUpdateProfileInput),
      ),
    ];

    return result;
  }

  @override
  GUpdateProfileVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateProfileVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'updateProfileInput':
          result.updateProfileInput.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GUpdateProfileInput),
                )!
                as _i1.GUpdateProfileInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileVars extends GUpdateProfileVars {
  @override
  final _i1.GUpdateProfileInput updateProfileInput;

  factory _$GUpdateProfileVars([
    void Function(GUpdateProfileVarsBuilder)? updates,
  ]) => (GUpdateProfileVarsBuilder()..update(updates))._build();

  _$GUpdateProfileVars._({required this.updateProfileInput}) : super._();
  @override
  GUpdateProfileVars rebuild(
    void Function(GUpdateProfileVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileVarsBuilder toBuilder() =>
      GUpdateProfileVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileVars &&
        updateProfileInput == other.updateProfileInput;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, updateProfileInput.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GUpdateProfileVars',
    )..add('updateProfileInput', updateProfileInput)).toString();
  }
}

class GUpdateProfileVarsBuilder
    implements Builder<GUpdateProfileVars, GUpdateProfileVarsBuilder> {
  _$GUpdateProfileVars? _$v;

  _i1.GUpdateProfileInputBuilder? _updateProfileInput;
  _i1.GUpdateProfileInputBuilder get updateProfileInput =>
      _$this._updateProfileInput ??= _i1.GUpdateProfileInputBuilder();
  set updateProfileInput(_i1.GUpdateProfileInputBuilder? updateProfileInput) =>
      _$this._updateProfileInput = updateProfileInput;

  GUpdateProfileVarsBuilder();

  GUpdateProfileVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _updateProfileInput = $v.updateProfileInput.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileVars other) {
    _$v = other as _$GUpdateProfileVars;
  }

  @override
  void update(void Function(GUpdateProfileVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileVars build() => _build();

  _$GUpdateProfileVars _build() {
    _$GUpdateProfileVars _$result;
    try {
      _$result =
          _$v ??
          _$GUpdateProfileVars._(
            updateProfileInput: updateProfileInput.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateProfileInput';
        updateProfileInput.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GUpdateProfileVars',
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

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
