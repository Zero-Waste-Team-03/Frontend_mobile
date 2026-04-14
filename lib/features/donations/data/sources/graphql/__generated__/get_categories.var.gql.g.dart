// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_categories.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetCategoriesVars> _$gGetCategoriesVarsSerializer =
    _$GGetCategoriesVarsSerializer();

class _$GGetCategoriesVarsSerializer
    implements StructuredSerializer<GGetCategoriesVars> {
  @override
  final Iterable<Type> types = const [GGetCategoriesVars, _$GGetCategoriesVars];
  @override
  final String wireName = 'GGetCategoriesVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetCategoriesVars object, {
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
  GGetCategoriesVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetCategoriesVarsBuilder();

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

class _$GGetCategoriesVars extends GGetCategoriesVars {
  @override
  final _i1.GPaginationInput? pagination;

  factory _$GGetCategoriesVars([
    void Function(GGetCategoriesVarsBuilder)? updates,
  ]) => (GGetCategoriesVarsBuilder()..update(updates))._build();

  _$GGetCategoriesVars._({this.pagination}) : super._();
  @override
  GGetCategoriesVars rebuild(
    void Function(GGetCategoriesVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetCategoriesVarsBuilder toBuilder() =>
      GGetCategoriesVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetCategoriesVars && pagination == other.pagination;
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
      r'GGetCategoriesVars',
    )..add('pagination', pagination)).toString();
  }
}

class GGetCategoriesVarsBuilder
    implements Builder<GGetCategoriesVars, GGetCategoriesVarsBuilder> {
  _$GGetCategoriesVars? _$v;

  _i1.GPaginationInputBuilder? _pagination;
  _i1.GPaginationInputBuilder get pagination =>
      _$this._pagination ??= _i1.GPaginationInputBuilder();
  set pagination(_i1.GPaginationInputBuilder? pagination) =>
      _$this._pagination = pagination;

  GGetCategoriesVarsBuilder();

  GGetCategoriesVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetCategoriesVars other) {
    _$v = other as _$GGetCategoriesVars;
  }

  @override
  void update(void Function(GGetCategoriesVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetCategoriesVars build() => _build();

  _$GGetCategoriesVars _build() {
    _$GGetCategoriesVars _$result;
    try {
      _$result =
          _$v ?? _$GGetCategoriesVars._(pagination: _pagination?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pagination';
        _pagination?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetCategoriesVars',
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
