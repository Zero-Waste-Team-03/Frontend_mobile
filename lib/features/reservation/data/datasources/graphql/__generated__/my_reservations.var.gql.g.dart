// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_reservations.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyReservationsVars> _$gMyReservationsVarsSerializer =
    _$GMyReservationsVarsSerializer();

class _$GMyReservationsVarsSerializer
    implements StructuredSerializer<GMyReservationsVars> {
  @override
  final Iterable<Type> types = const [
    GMyReservationsVars,
    _$GMyReservationsVars,
  ];
  @override
  final String wireName = 'GMyReservationsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyReservationsVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[];
    Object? value;
    value = object.pagination;
    if (value != null) {
      result
        ..add('pagination')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i1.GPaginationInput),
          ),
        );
    }
    return result;
  }

  @override
  GMyReservationsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyReservationsVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'pagination':
          result.pagination.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GPaginationInput),
                )!
                as _i1.GPaginationInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GMyReservationsVars extends GMyReservationsVars {
  @override
  final _i1.GPaginationInput? pagination;

  factory _$GMyReservationsVars([
    void Function(GMyReservationsVarsBuilder)? updates,
  ]) => (GMyReservationsVarsBuilder()..update(updates))._build();

  _$GMyReservationsVars._({this.pagination}) : super._();
  @override
  GMyReservationsVars rebuild(
    void Function(GMyReservationsVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GMyReservationsVarsBuilder toBuilder() =>
      GMyReservationsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyReservationsVars && pagination == other.pagination;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pagination.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GMyReservationsVars',
    )..add('pagination', pagination)).toString();
  }
}

class GMyReservationsVarsBuilder
    implements Builder<GMyReservationsVars, GMyReservationsVarsBuilder> {
  _$GMyReservationsVars? _$v;

  _i1.GPaginationInputBuilder? _pagination;
  _i1.GPaginationInputBuilder get pagination =>
      _$this._pagination ??= _i1.GPaginationInputBuilder();
  set pagination(_i1.GPaginationInputBuilder? pagination) =>
      _$this._pagination = pagination;

  GMyReservationsVarsBuilder();

  GMyReservationsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyReservationsVars other) {
    _$v = other as _$GMyReservationsVars;
  }

  @override
  void update(void Function(GMyReservationsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyReservationsVars build() => _build();

  _$GMyReservationsVars _build() {
    _$GMyReservationsVars _$result;
    try {
      _$result =
          _$v ?? _$GMyReservationsVars._(pagination: _pagination?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pagination';
        _pagination?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GMyReservationsVars',
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
