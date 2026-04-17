// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_messages.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetConversationMessagesVars>
_$gGetConversationMessagesVarsSerializer =
    _$GGetConversationMessagesVarsSerializer();

class _$GGetConversationMessagesVarsSerializer
    implements StructuredSerializer<GGetConversationMessagesVars> {
  @override
  final Iterable<Type> types = const [
    GGetConversationMessagesVars,
    _$GGetConversationMessagesVars,
  ];
  @override
  final String wireName = 'GGetConversationMessagesVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetConversationMessagesVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'input',
      serializers.serialize(
        object.input,
        specifiedType: const FullType(_i1.GConversationMessagesInput),
      ),
    ];

    return result;
  }

  @override
  GGetConversationMessagesVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetConversationMessagesVarsBuilder();

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
                  specifiedType: const FullType(_i1.GConversationMessagesInput),
                )!
                as _i1.GConversationMessagesInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetConversationMessagesVars extends GGetConversationMessagesVars {
  @override
  final _i1.GConversationMessagesInput input;

  factory _$GGetConversationMessagesVars([
    void Function(GGetConversationMessagesVarsBuilder)? updates,
  ]) => (GGetConversationMessagesVarsBuilder()..update(updates))._build();

  _$GGetConversationMessagesVars._({required this.input}) : super._();
  @override
  GGetConversationMessagesVars rebuild(
    void Function(GGetConversationMessagesVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetConversationMessagesVarsBuilder toBuilder() =>
      GGetConversationMessagesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetConversationMessagesVars && input == other.input;
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
      r'GGetConversationMessagesVars',
    )..add('input', input)).toString();
  }
}

class GGetConversationMessagesVarsBuilder
    implements
        Builder<
          GGetConversationMessagesVars,
          GGetConversationMessagesVarsBuilder
        > {
  _$GGetConversationMessagesVars? _$v;

  _i1.GConversationMessagesInputBuilder? _input;
  _i1.GConversationMessagesInputBuilder get input =>
      _$this._input ??= _i1.GConversationMessagesInputBuilder();
  set input(_i1.GConversationMessagesInputBuilder? input) =>
      _$this._input = input;

  GGetConversationMessagesVarsBuilder();

  GGetConversationMessagesVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _input = $v.input.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetConversationMessagesVars other) {
    _$v = other as _$GGetConversationMessagesVars;
  }

  @override
  void update(void Function(GGetConversationMessagesVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetConversationMessagesVars build() => _build();

  _$GGetConversationMessagesVars _build() {
    _$GGetConversationMessagesVars _$result;
    try {
      _$result = _$v ?? _$GGetConversationMessagesVars._(input: input.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'input';
        input.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetConversationMessagesVars',
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
