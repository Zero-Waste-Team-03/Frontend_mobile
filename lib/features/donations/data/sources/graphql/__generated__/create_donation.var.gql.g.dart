// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_donation.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GCreateDonationVars> _$gCreateDonationVarsSerializer =
    _$GCreateDonationVarsSerializer();

class _$GCreateDonationVarsSerializer
    implements StructuredSerializer<GCreateDonationVars> {
  @override
  final Iterable<Type> types = const [
    GCreateDonationVars,
    _$GCreateDonationVars,
  ];
  @override
  final String wireName = 'GCreateDonationVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GCreateDonationVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'input',
      serializers.serialize(
        object.input,
        specifiedType: const FullType(_i1.GCreateDonationInput),
      ),
    ];

    return result;
  }

  @override
  GCreateDonationVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GCreateDonationVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'input':
          result.input.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GCreateDonationInput),
                )!
                as _i1.GCreateDonationInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GCreateDonationVars extends GCreateDonationVars {
  @override
  final _i1.GCreateDonationInput input;

  factory _$GCreateDonationVars([
    void Function(GCreateDonationVarsBuilder)? updates,
  ]) => (GCreateDonationVarsBuilder()..update(updates))._build();

  _$GCreateDonationVars._({required this.input}) : super._();
  @override
  GCreateDonationVars rebuild(
    void Function(GCreateDonationVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GCreateDonationVarsBuilder toBuilder() =>
      GCreateDonationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GCreateDonationVars && input == other.input;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, input.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GCreateDonationVars',
    )..add('input', input)).toString();
  }
}

class GCreateDonationVarsBuilder
    implements Builder<GCreateDonationVars, GCreateDonationVarsBuilder> {
  _$GCreateDonationVars? _$v;

  _i1.GCreateDonationInputBuilder? _input;
  _i1.GCreateDonationInputBuilder get input =>
      _$this._input ??= _i1.GCreateDonationInputBuilder();
  set input(_i1.GCreateDonationInputBuilder? input) => _$this._input = input;

  GCreateDonationVarsBuilder();

  GCreateDonationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GCreateDonationVars other) {
    _$v = other as _$GCreateDonationVars;
  }

  @override
  void update(void Function(GCreateDonationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GCreateDonationVars build() => _build();

  _$GCreateDonationVars _build() {
    _$GCreateDonationVars _$result;
    try {
      _$result = _$v ?? _$GCreateDonationVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GCreateDonationVars',
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
