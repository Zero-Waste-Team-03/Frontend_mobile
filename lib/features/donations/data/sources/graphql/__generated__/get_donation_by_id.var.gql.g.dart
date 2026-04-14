// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_donation_by_id.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetDonationByIdVars> _$gGetDonationByIdVarsSerializer =
    _$GGetDonationByIdVarsSerializer();

class _$GGetDonationByIdVarsSerializer
    implements StructuredSerializer<GGetDonationByIdVars> {
  @override
  final Iterable<Type> types = const [
    GGetDonationByIdVars,
    _$GGetDonationByIdVars,
  ];
  @override
  final String wireName = 'GGetDonationByIdVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationByIdVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  GGetDonationByIdVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationByIdVarsBuilder();

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

class _$GGetDonationByIdVars extends GGetDonationByIdVars {
  @override
  final String id;

  factory _$GGetDonationByIdVars([
    void Function(GGetDonationByIdVarsBuilder)? updates,
  ]) => (GGetDonationByIdVarsBuilder()..update(updates))._build();

  _$GGetDonationByIdVars._({required this.id}) : super._();
  @override
  GGetDonationByIdVars rebuild(
    void Function(GGetDonationByIdVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetDonationByIdVarsBuilder toBuilder() =>
      GGetDonationByIdVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationByIdVars && id == other.id;
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
      r'GGetDonationByIdVars',
    )..add('id', id)).toString();
  }
}

class GGetDonationByIdVarsBuilder
    implements Builder<GGetDonationByIdVars, GGetDonationByIdVarsBuilder> {
  _$GGetDonationByIdVars? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  GGetDonationByIdVarsBuilder();

  GGetDonationByIdVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetDonationByIdVars other) {
    _$v = other as _$GGetDonationByIdVars;
  }

  @override
  void update(void Function(GGetDonationByIdVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationByIdVars build() => _build();

  _$GGetDonationByIdVars _build() {
    final _$result =
        _$v ??
        _$GGetDonationByIdVars._(
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GGetDonationByIdVars',
            'id',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
