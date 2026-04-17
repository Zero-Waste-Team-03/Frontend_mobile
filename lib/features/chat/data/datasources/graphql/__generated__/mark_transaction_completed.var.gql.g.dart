// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_transaction_completed.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkTransactionCompletedVars>
_$gMarkTransactionCompletedVarsSerializer =
    _$GMarkTransactionCompletedVarsSerializer();

class _$GMarkTransactionCompletedVarsSerializer
    implements StructuredSerializer<GMarkTransactionCompletedVars> {
  @override
  final Iterable<Type> types = const [
    GMarkTransactionCompletedVars,
    _$GMarkTransactionCompletedVars,
  ];
  @override
  final String wireName = 'GMarkTransactionCompletedVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMarkTransactionCompletedVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'input',
      serializers.serialize(
        object.input,
        specifiedType: const FullType(_i1.GMarkTransactionCompletedInput),
      ),
    ];

    return result;
  }

  @override
  GMarkTransactionCompletedVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMarkTransactionCompletedVarsBuilder();

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
                  specifiedType: const FullType(
                    _i1.GMarkTransactionCompletedInput,
                  ),
                )!
                as _i1.GMarkTransactionCompletedInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkTransactionCompletedVars extends GMarkTransactionCompletedVars {
  @override
  final _i1.GMarkTransactionCompletedInput input;

  factory _$GMarkTransactionCompletedVars([
    void Function(GMarkTransactionCompletedVarsBuilder)? updates,
  ]) => (GMarkTransactionCompletedVarsBuilder()..update(updates))._build();

  _$GMarkTransactionCompletedVars._({required this.input}) : super._();
  @override
  GMarkTransactionCompletedVars rebuild(
    void Function(GMarkTransactionCompletedVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMarkTransactionCompletedVarsBuilder toBuilder() =>
      GMarkTransactionCompletedVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkTransactionCompletedVars && input == other.input;
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
      r'GMarkTransactionCompletedVars',
    )..add('input', input)).toString();
  }
}

class GMarkTransactionCompletedVarsBuilder
    implements
        Builder<
          GMarkTransactionCompletedVars,
          GMarkTransactionCompletedVarsBuilder
        > {
  _$GMarkTransactionCompletedVars? _$v;

  _i1.GMarkTransactionCompletedInputBuilder? _input;
  _i1.GMarkTransactionCompletedInputBuilder get input =>
      _$this._input ??= _i1.GMarkTransactionCompletedInputBuilder();
  set input(_i1.GMarkTransactionCompletedInputBuilder? input) =>
      _$this._input = input;

  GMarkTransactionCompletedVarsBuilder();

  GMarkTransactionCompletedVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkTransactionCompletedVars other) {
    _$v = other as _$GMarkTransactionCompletedVars;
  }

  @override
  void update(void Function(GMarkTransactionCompletedVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkTransactionCompletedVars build() => _build();

  _$GMarkTransactionCompletedVars _build() {
    _$GMarkTransactionCompletedVars _$result;
    try {
      _$result = _$v ?? _$GMarkTransactionCompletedVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMarkTransactionCompletedVars',
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
