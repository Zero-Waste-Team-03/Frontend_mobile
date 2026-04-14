// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_donations.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetDonationsVars> _$gGetDonationsVarsSerializer =
    _$GGetDonationsVarsSerializer();

class _$GGetDonationsVarsSerializer
    implements StructuredSerializer<GGetDonationsVars> {
  @override
  final Iterable<Type> types = const [GGetDonationsVars, _$GGetDonationsVars];
  @override
  final String wireName = 'GGetDonationsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetDonationsVars object, {
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
    value = object.filter;
    if (value != null) {
      result
        ..add('filter')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(_i1.GDonationsFilterInput),
          ),
        );
    }
    return result;
  }

  @override
  GGetDonationsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetDonationsVarsBuilder();

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
        case 'filter':
          result.filter.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i1.GDonationsFilterInput),
                )!
                as _i1.GDonationsFilterInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetDonationsVars extends GGetDonationsVars {
  @override
  final _i1.GPaginationInput? pagination;
  @override
  final _i1.GDonationsFilterInput? filter;

  factory _$GGetDonationsVars([
    void Function(GGetDonationsVarsBuilder)? updates,
  ]) => (GGetDonationsVarsBuilder()..update(updates))._build();

  _$GGetDonationsVars._({this.pagination, this.filter}) : super._();
  @override
  GGetDonationsVars rebuild(void Function(GGetDonationsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GGetDonationsVarsBuilder toBuilder() =>
      GGetDonationsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetDonationsVars &&
        pagination == other.pagination &&
        filter == other.filter;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, pagination.hashCode);
    _$hash = $jc(_$hash, filter.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetDonationsVars')
          ..add('pagination', pagination)
          ..add('filter', filter))
        .toString();
  }
}

class GGetDonationsVarsBuilder
    implements Builder<GGetDonationsVars, GGetDonationsVarsBuilder> {
  _$GGetDonationsVars? _$v;

  _i1.GPaginationInputBuilder? _pagination;
  _i1.GPaginationInputBuilder get pagination =>
      _$this._pagination ??= _i1.GPaginationInputBuilder();
  set pagination(_i1.GPaginationInputBuilder? pagination) =>
      _$this._pagination = pagination;

  _i1.GDonationsFilterInputBuilder? _filter;
  _i1.GDonationsFilterInputBuilder get filter =>
      _$this._filter ??= _i1.GDonationsFilterInputBuilder();
  set filter(_i1.GDonationsFilterInputBuilder? filter) =>
      _$this._filter = filter;

  GGetDonationsVarsBuilder();

  GGetDonationsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pagination = $v.pagination?.toBuilder();
      _filter = $v.filter?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetDonationsVars other) {
    _$v = other as _$GGetDonationsVars;
  }

  @override
  void update(void Function(GGetDonationsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetDonationsVars build() => _build();

  _$GGetDonationsVars _build() {
    _$GGetDonationsVars _$result;
    try {
      _$result =
          _$v ??
          _$GGetDonationsVars._(
            pagination: _pagination?.build(),
            filter: _filter?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pagination';
        _pagination?.build();
        _$failedField = 'filter';
        _filter?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetDonationsVars',
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
