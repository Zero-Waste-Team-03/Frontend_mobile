// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_notification.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GDeleteNotificationData> _$gDeleteNotificationDataSerializer =
    _$GDeleteNotificationDataSerializer();
Serializer<GDeleteNotificationData_deleteNotification>
_$gDeleteNotificationDataDeleteNotificationSerializer =
    _$GDeleteNotificationData_deleteNotificationSerializer();

class _$GDeleteNotificationDataSerializer
    implements StructuredSerializer<GDeleteNotificationData> {
  @override
  final Iterable<Type> types = const [
    GDeleteNotificationData,
    _$GDeleteNotificationData,
  ];
  @override
  final String wireName = 'GDeleteNotificationData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GDeleteNotificationData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'deleteNotification',
      serializers.serialize(
        object.deleteNotification,
        specifiedType: const FullType(
          GDeleteNotificationData_deleteNotification,
        ),
      ),
    ];

    return result;
  }

  @override
  GDeleteNotificationData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GDeleteNotificationDataBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'deleteNotification':
          result.deleteNotification.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GDeleteNotificationData_deleteNotification,
                  ),
                )!
                as GDeleteNotificationData_deleteNotification,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GDeleteNotificationData_deleteNotificationSerializer
    implements
        StructuredSerializer<GDeleteNotificationData_deleteNotification> {
  @override
  final Iterable<Type> types = const [
    GDeleteNotificationData_deleteNotification,
    _$GDeleteNotificationData_deleteNotification,
  ];
  @override
  final String wireName = 'GDeleteNotificationData_deleteNotification';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GDeleteNotificationData_deleteNotification object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'message',
      serializers.serialize(
        object.message,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GDeleteNotificationData_deleteNotification deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GDeleteNotificationData_deleteNotificationBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case '__typename':
          result.G__typename =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'message':
          result.message =
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

class _$GDeleteNotificationData extends GDeleteNotificationData {
  @override
  final String G__typename;
  @override
  final GDeleteNotificationData_deleteNotification deleteNotification;

  factory _$GDeleteNotificationData([
    void Function(GDeleteNotificationDataBuilder)? updates,
  ]) => (GDeleteNotificationDataBuilder()..update(updates))._build();

  _$GDeleteNotificationData._({
    required this.G__typename,
    required this.deleteNotification,
  }) : super._();
  @override
  GDeleteNotificationData rebuild(
    void Function(GDeleteNotificationDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GDeleteNotificationDataBuilder toBuilder() =>
      GDeleteNotificationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteNotificationData &&
        G__typename == other.G__typename &&
        deleteNotification == other.deleteNotification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, deleteNotification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GDeleteNotificationData')
          ..add('G__typename', G__typename)
          ..add('deleteNotification', deleteNotification))
        .toString();
  }
}

class GDeleteNotificationDataBuilder
    implements
        Builder<GDeleteNotificationData, GDeleteNotificationDataBuilder> {
  _$GDeleteNotificationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GDeleteNotificationData_deleteNotificationBuilder? _deleteNotification;
  GDeleteNotificationData_deleteNotificationBuilder get deleteNotification =>
      _$this._deleteNotification ??=
          GDeleteNotificationData_deleteNotificationBuilder();
  set deleteNotification(
    GDeleteNotificationData_deleteNotificationBuilder? deleteNotification,
  ) => _$this._deleteNotification = deleteNotification;

  GDeleteNotificationDataBuilder() {
    GDeleteNotificationData._initializeBuilder(this);
  }

  GDeleteNotificationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _deleteNotification = $v.deleteNotification.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteNotificationData other) {
    _$v = other as _$GDeleteNotificationData;
  }

  @override
  void update(void Function(GDeleteNotificationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteNotificationData build() => _build();

  _$GDeleteNotificationData _build() {
    _$GDeleteNotificationData _$result;
    try {
      _$result =
          _$v ??
          _$GDeleteNotificationData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GDeleteNotificationData',
              'G__typename',
            ),
            deleteNotification: deleteNotification.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'deleteNotification';
        deleteNotification.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GDeleteNotificationData',
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

class _$GDeleteNotificationData_deleteNotification
    extends GDeleteNotificationData_deleteNotification {
  @override
  final String G__typename;
  @override
  final String message;

  factory _$GDeleteNotificationData_deleteNotification([
    void Function(GDeleteNotificationData_deleteNotificationBuilder)? updates,
  ]) => (GDeleteNotificationData_deleteNotificationBuilder()..update(updates))
      ._build();

  _$GDeleteNotificationData_deleteNotification._({
    required this.G__typename,
    required this.message,
  }) : super._();
  @override
  GDeleteNotificationData_deleteNotification rebuild(
    void Function(GDeleteNotificationData_deleteNotificationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GDeleteNotificationData_deleteNotificationBuilder toBuilder() =>
      GDeleteNotificationData_deleteNotificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GDeleteNotificationData_deleteNotification &&
        G__typename == other.G__typename &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GDeleteNotificationData_deleteNotification',
          )
          ..add('G__typename', G__typename)
          ..add('message', message))
        .toString();
  }
}

class GDeleteNotificationData_deleteNotificationBuilder
    implements
        Builder<
          GDeleteNotificationData_deleteNotification,
          GDeleteNotificationData_deleteNotificationBuilder
        > {
  _$GDeleteNotificationData_deleteNotification? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GDeleteNotificationData_deleteNotificationBuilder() {
    GDeleteNotificationData_deleteNotification._initializeBuilder(this);
  }

  GDeleteNotificationData_deleteNotificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GDeleteNotificationData_deleteNotification other) {
    _$v = other as _$GDeleteNotificationData_deleteNotification;
  }

  @override
  void update(
    void Function(GDeleteNotificationData_deleteNotificationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GDeleteNotificationData_deleteNotification build() => _build();

  _$GDeleteNotificationData_deleteNotification _build() {
    final _$result =
        _$v ??
        _$GDeleteNotificationData_deleteNotification._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GDeleteNotificationData_deleteNotification',
            'G__typename',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'GDeleteNotificationData_deleteNotification',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
