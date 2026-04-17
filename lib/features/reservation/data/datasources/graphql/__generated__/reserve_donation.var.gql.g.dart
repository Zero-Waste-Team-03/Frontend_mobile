// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reserve_donation.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GReserveDonationVars> _$gReserveDonationVarsSerializer =
    _$GReserveDonationVarsSerializer();

class _$GReserveDonationVarsSerializer
    implements StructuredSerializer<GReserveDonationVars> {
  @override
  final Iterable<Type> types = const [
    GReserveDonationVars,
    _$GReserveDonationVars,
  ];
  @override
  final String wireName = 'GReserveDonationVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GReserveDonationVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'donationId',
      serializers.serialize(
        object.donationId,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GReserveDonationVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GReserveDonationVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'donationId':
          result.donationId =
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

class _$GReserveDonationVars extends GReserveDonationVars {
  @override
  final String donationId;

  factory _$GReserveDonationVars([
    void Function(GReserveDonationVarsBuilder)? updates,
  ]) => (GReserveDonationVarsBuilder()..update(updates))._build();

  _$GReserveDonationVars._({required this.donationId}) : super._();
  @override
  GReserveDonationVars rebuild(
    void Function(GReserveDonationVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GReserveDonationVarsBuilder toBuilder() =>
      GReserveDonationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GReserveDonationVars && donationId == other.donationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, donationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GReserveDonationVars',
    )..add('donationId', donationId)).toString();
  }
}

class GReserveDonationVarsBuilder
    implements Builder<GReserveDonationVars, GReserveDonationVarsBuilder> {
  _$GReserveDonationVars? _$v;

  String? _donationId;
  String? get donationId => _$this._donationId;
  set donationId(String? donationId) => _$this._donationId = donationId;

  GReserveDonationVarsBuilder();

  GReserveDonationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _donationId = $v.donationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GReserveDonationVars other) {
    _$v = other as _$GReserveDonationVars;
  }

  @override
  void update(void Function(GReserveDonationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GReserveDonationVars build() => _build();

  _$GReserveDonationVars _build() {
    final _$result =
        _$v ??
        _$GReserveDonationVars._(
          donationId: BuiltValueNullFieldError.checkNotNull(
            donationId,
            r'GReserveDonationVars',
            'donationId',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
