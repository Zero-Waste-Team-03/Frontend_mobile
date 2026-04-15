// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_notification.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GDeleteNotificationVars> _$gDeleteNotificationVarsSerializer =
    _$GDeleteNotificationVarsSerializer();

class _$GDeleteNotificationVarsSerializer
    implements StructuredSerializer<GDeleteNotificationVars> {
  @override
  final Iterable<Type> types = const [
    GDeleteNotificationVars,
    _$GDeleteNotificationVars,
  ];
  @override
  final String wireName = 'GDeleteNotificationVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GDeleteNotificationVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GDeleteNotificationVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GDeleteNotificationVarsBuilder();

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

class _$GDeleteNotificationVars extends GDeleteNotificationVars {
  @override
  final String id;

  factory _$GDeleteNotificationVars([
    void Function(GDeleteNotificationVarsBuilder)? updates,
  ]) => (GDeleteNotificationVarsBuilder()..update(updates))._build();

  _$GDeleteNotificationVars._({required this.id}) : super._();
  @override
  GDeleteNotificationVars rebuild(
    void Function(GDeleteNotificationVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GDeleteNotificationVarsBuilder toBuilder() =>
      GDeleteNotificationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteNotificationVars && id == other.id;
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
      r'GDeleteNotificationVars',
    )..add('id', id)).toString();
  }
}

class GDeleteNotificationVarsBuilder
    implements
        Builder<GDeleteNotificationVars, GDeleteNotificationVarsBuilder> {
  _$GDeleteNotificationVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GDeleteNotificationVarsBuilder();

  GDeleteNotificationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteNotificationVars other) {
    _$v = other as _$GDeleteNotificationVars;
  }

  @override
  void update(void Function(GDeleteNotificationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteNotificationVars build() => _build();

  _$GDeleteNotificationVars _build() {
    final _$result =
        _$v ??
        _$GDeleteNotificationVars._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GDeleteNotificationVars',
            'id',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
