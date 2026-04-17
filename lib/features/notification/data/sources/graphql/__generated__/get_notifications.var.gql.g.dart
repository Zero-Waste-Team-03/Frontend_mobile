// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notifications.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetNotificationsVars> _$gGetNotificationsVarsSerializer =
    _$GGetNotificationsVarsSerializer();

class _$GGetNotificationsVarsSerializer
    implements StructuredSerializer<GGetNotificationsVars> {
  @override
  final Iterable<Type> types = const [
    GGetNotificationsVars,
    _$GGetNotificationsVars,
  ];
  @override
  final String wireName = 'GGetNotificationsVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetNotificationsVars object, {
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
            specifiedType: const FullType(_i1.GPaginationQueryInput),
          ),
        );
    }
    return result;
  }

  @override
  GGetNotificationsVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetNotificationsVarsBuilder();

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
                  specifiedType: const FullType(_i1.GPaginationQueryInput),
                )!
                as _i1.GPaginationQueryInput,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetNotificationsVars extends GGetNotificationsVars {
  @override
  final _i1.GPaginationQueryInput? pagination;

  factory _$GGetNotificationsVars([
    void Function(GGetNotificationsVarsBuilder)? updates,
  ]) => (GGetNotificationsVarsBuilder()..update(updates))._build();

  _$GGetNotificationsVars._({this.pagination}) : super._();
  @override
  GGetNotificationsVars rebuild(
    void Function(GGetNotificationsVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetNotificationsVarsBuilder toBuilder() =>
      GGetNotificationsVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetNotificationsVars && pagination == other.pagination;
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
      r'GGetNotificationsVars',
    )..add('pagination', pagination)).toString();
  }
}

class GGetNotificationsVarsBuilder
    implements Builder<GGetNotificationsVars, GGetNotificationsVarsBuilder> {
  _$GGetNotificationsVars? _$v;

  _i1.GPaginationQueryInputBuilder? _pagination;
  _i1.GPaginationQueryInputBuilder get pagination =>
      _$this._pagination ??= _i1.GPaginationQueryInputBuilder();
  set pagination(_i1.GPaginationQueryInputBuilder? pagination) =>
      _$this._pagination = pagination;

  GGetNotificationsVarsBuilder();

  GGetNotificationsVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _pagination = $v.pagination?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetNotificationsVars other) {
    _$v = other as _$GGetNotificationsVars;
  }

  @override
  void update(void Function(GGetNotificationsVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetNotificationsVars build() => _build();

  _$GGetNotificationsVars _build() {
    _$GGetNotificationsVars _$result;
    try {
      _$result =
          _$v ?? _$GGetNotificationsVars._(pagination: _pagination?.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'pagination';
        _pagination?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetNotificationsVars',
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
