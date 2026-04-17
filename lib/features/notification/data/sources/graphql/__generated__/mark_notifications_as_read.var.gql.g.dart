// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mark_notifications_as_read.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMarkNotificationsAsReadVars>
_$gMarkNotificationsAsReadVarsSerializer =
    _$GMarkNotificationsAsReadVarsSerializer();

class _$GMarkNotificationsAsReadVarsSerializer
    implements StructuredSerializer<GMarkNotificationsAsReadVars> {
  @override
  final Iterable<Type> types = const [
    GMarkNotificationsAsReadVars,
    _$GMarkNotificationsAsReadVars,
  ];
  @override
  final String wireName = 'GMarkNotificationsAsReadVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMarkNotificationsAsReadVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'input',
      serializers.serialize(
        object.input,
        specifiedType: const FullType(_i1.GUpdateReadNotificationsInput),
      ),
    ];

    return result;
  }

  @override
  GMarkNotificationsAsReadVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMarkNotificationsAsReadVarsBuilder();

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
                    _i1.GUpdateReadNotificationsInput,
                  ),
                )!
                as _i1.GUpdateReadNotificationsInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMarkNotificationsAsReadVars extends GMarkNotificationsAsReadVars {
  @override
  final _i1.GUpdateReadNotificationsInput input;

  factory _$GMarkNotificationsAsReadVars([
    void Function(GMarkNotificationsAsReadVarsBuilder)? updates,
  ]) => (GMarkNotificationsAsReadVarsBuilder()..update(updates))._build();

  _$GMarkNotificationsAsReadVars._({required this.input}) : super._();
  @override
  GMarkNotificationsAsReadVars rebuild(
    void Function(GMarkNotificationsAsReadVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMarkNotificationsAsReadVarsBuilder toBuilder() =>
      GMarkNotificationsAsReadVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMarkNotificationsAsReadVars && input == other.input;
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
      r'GMarkNotificationsAsReadVars',
    )..add('input', input)).toString();
  }
}

class GMarkNotificationsAsReadVarsBuilder
    implements
        Builder<
          GMarkNotificationsAsReadVars,
          GMarkNotificationsAsReadVarsBuilder
        > {
  _$GMarkNotificationsAsReadVars? _$v;

  _i1.GUpdateReadNotificationsInputBuilder? _input;
  _i1.GUpdateReadNotificationsInputBuilder get input =>
      _$this._input ??= _i1.GUpdateReadNotificationsInputBuilder();
  set input(_i1.GUpdateReadNotificationsInputBuilder? input) =>
      _$this._input = input;

  GMarkNotificationsAsReadVarsBuilder();

  GMarkNotificationsAsReadVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMarkNotificationsAsReadVars other) {
    _$v = other as _$GMarkNotificationsAsReadVars;
  }

  @override
  void update(void Function(GMarkNotificationsAsReadVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMarkNotificationsAsReadVars build() => _build();

  _$GMarkNotificationsAsReadVars _build() {
    _$GMarkNotificationsAsReadVars _$result;
    try {
      _$result = _$v ?? _$GMarkNotificationsAsReadVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMarkNotificationsAsReadVars',
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
