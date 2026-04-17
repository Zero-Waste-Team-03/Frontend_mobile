// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_active_conversations.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyActiveConversationsVars> _$gMyActiveConversationsVarsSerializer =
    _$GMyActiveConversationsVarsSerializer();

class _$GMyActiveConversationsVarsSerializer
    implements StructuredSerializer<GMyActiveConversationsVars> {
  @override
  final Iterable<Type> types = const [
    GMyActiveConversationsVars,
    _$GMyActiveConversationsVars,
  ];
  @override
  final String wireName = 'GMyActiveConversationsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyActiveConversationsVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return <Object?>[];
  }

  @override
  GMyActiveConversationsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GMyActiveConversationsVarsBuilder().build();
  }
}

class _$GMyActiveConversationsVars extends GMyActiveConversationsVars {
  factory _$GMyActiveConversationsVars([
    void Function(GMyActiveConversationsVarsBuilder)? updates,
  ]) => (GMyActiveConversationsVarsBuilder()..update(updates))._build();

  _$GMyActiveConversationsVars._() : super._();
  @override
  GMyActiveConversationsVars rebuild(
    void Function(GMyActiveConversationsVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyActiveConversationsVarsBuilder toBuilder() =>
      GMyActiveConversationsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyActiveConversationsVars;
  }

  @override
  int get hashCode {
    return 659839519;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper(
      r'GMyActiveConversationsVars',
    ).toString();
  }
}

class GMyActiveConversationsVarsBuilder
    implements
        Builder<GMyActiveConversationsVars, GMyActiveConversationsVarsBuilder> {
  _$GMyActiveConversationsVars? _$v;

  GMyActiveConversationsVarsBuilder();

  @override
  void replace(GMyActiveConversationsVars other) {
    _$v = other as _$GMyActiveConversationsVars;
  }

  @override
  void update(void Function(GMyActiveConversationsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyActiveConversationsVars build() => _build();

  _$GMyActiveConversationsVars _build() {
    final _$result = _$v ?? _$GMyActiveConversationsVars._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
