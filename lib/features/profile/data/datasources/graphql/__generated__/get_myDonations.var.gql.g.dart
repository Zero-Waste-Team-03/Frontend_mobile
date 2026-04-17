// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_myDonations.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GMyDonationsVars> _$gMyDonationsVarsSerializer =
    _$GMyDonationsVarsSerializer();

class _$GMyDonationsVarsSerializer
    implements StructuredSerializer<GMyDonationsVars> {
  @override
  final Iterable<Type> types = const [GMyDonationsVars, _$GMyDonationsVars];
  @override
  final String wireName = 'GMyDonationsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GMyDonationsVars object, {
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
  GMyDonationsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GMyDonationsVarsBuilder();

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

class _$GMyDonationsVars extends GMyDonationsVars {
  @override
  final _i1.GPaginationInput? pagination;
  @override
  final _i1.GDonationsFilterInput? filter;

  factory _$GMyDonationsVars([
    void Function(GMyDonationsVarsBuilder)? updates,
  ]) => (GMyDonationsVarsBuilder()..update(updates))._build();

  _$GMyDonationsVars._({this.pagination, this.filter}) : super._();
  @override
  GMyDonationsVars rebuild(void Function(GMyDonationsVarsBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GMyDonationsVarsBuilder toBuilder() =>
      GMyDonationsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GMyDonationsVars &&
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
    return (newBuiltValueToStringHelper(r'GMyDonationsVars')
          ..add('pagination', pagination)
          ..add('filter', filter))
        .toString();
  }
}

class GMyDonationsVarsBuilder
    implements Builder<GMyDonationsVars, GMyDonationsVarsBuilder> {
  _$GMyDonationsVars? _$v;

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

  GMyDonationsVarsBuilder();

  GMyDonationsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pagination = $v.pagination?.toBuilder();
      _filter = $v.filter?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GMyDonationsVars other) {
    _$v = other as _$GMyDonationsVars;
  }

  @override
  void update(void Function(GMyDonationsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GMyDonationsVars build() => _build();

  _$GMyDonationsVars _build() {
    _$GMyDonationsVars _$result;
    try {
      _$result =
          _$v ??
          _$GMyDonationsVars._(
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
          r'GMyDonationsVars',
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
