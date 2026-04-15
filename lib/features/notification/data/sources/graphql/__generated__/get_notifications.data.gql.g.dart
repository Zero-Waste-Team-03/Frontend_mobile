// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_notifications.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetNotificationsData> _$gGetNotificationsDataSerializer =
    _$GGetNotificationsDataSerializer();
Serializer<GGetNotificationsData_notifications>
_$gGetNotificationsDataNotificationsSerializer =
    _$GGetNotificationsData_notificationsSerializer();

class _$GGetNotificationsDataSerializer
    implements StructuredSerializer<GGetNotificationsData> {
  @override
  final Iterable<Type> types = const [
    GGetNotificationsData,
    _$GGetNotificationsData,
  ];
  @override
  final String wireName = 'GGetNotificationsData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetNotificationsData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'notifications',
      serializers.serialize(
        object.notifications,
        specifiedType: const FullType(BuiltList, const [
          const FullType(GGetNotificationsData_notifications),
        ]),
      ),
    ];

    return result;
  }

  @override
  GGetNotificationsData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetNotificationsDataBuilder();

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
        case 'notifications':
          result.notifications.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(BuiltList, const [
                    const FullType(GGetNotificationsData_notifications),
                  ]),
                )!
                as BuiltList<Object?>,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetNotificationsData_notificationsSerializer
    implements StructuredSerializer<GGetNotificationsData_notifications> {
  @override
  final Iterable<Type> types = const [
    GGetNotificationsData_notifications,
    _$GGetNotificationsData_notifications,
  ];
  @override
  final String wireName = 'GGetNotificationsData_notifications';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetNotificationsData_notifications object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'body',
      serializers.serialize(object.body, specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'isRead',
      serializers.serialize(object.isRead, specifiedType: const FullType(bool)),
      'receiverId',
      serializers.serialize(
        object.receiverId,
        specifiedType: const FullType(String),
      ),
      'title',
      serializers.serialize(
        object.title,
        specifiedType: const FullType(String),
      ),
      'type',
      serializers.serialize(object.type, specifiedType: const FullType(String)),
      'updatedAt',
      serializers.serialize(
        object.updatedAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
    ];

    return result;
  }

  @override
  GGetNotificationsData_notifications deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetNotificationsData_notificationsBuilder();

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
        case 'body':
          result.body =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'createdAt':
          result.createdAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'isRead':
          result.isRead =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'receiverId':
          result.receiverId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'title':
          result.title =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'type':
          result.type =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'updatedAt':
          result.updatedAt.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(_i2.GDateTime),
                )!
                as _i2.GDateTime,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetNotificationsData extends GGetNotificationsData {
  @override
  final String G__typename;
  @override
  final BuiltList<GGetNotificationsData_notifications> notifications;

  factory _$GGetNotificationsData([
    void Function(GGetNotificationsDataBuilder)? updates,
  ]) => (GGetNotificationsDataBuilder()..update(updates))._build();

  _$GGetNotificationsData._({
    required this.G__typename,
    required this.notifications,
  }) : super._();
  @override
  GGetNotificationsData rebuild(
    void Function(GGetNotificationsDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetNotificationsDataBuilder toBuilder() =>
      GGetNotificationsDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetNotificationsData &&
        G__typename == other.G__typename &&
        notifications == other.notifications;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, notifications.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetNotificationsData')
          ..add('G__typename', G__typename)
          ..add('notifications', notifications))
        .toString();
  }
}

class GGetNotificationsDataBuilder
    implements Builder<GGetNotificationsData, GGetNotificationsDataBuilder> {
  _$GGetNotificationsData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  ListBuilder<GGetNotificationsData_notifications>? _notifications;
  ListBuilder<GGetNotificationsData_notifications> get notifications =>
      _$this._notifications ??=
          ListBuilder<GGetNotificationsData_notifications>();
  set notifications(
    ListBuilder<GGetNotificationsData_notifications>? notifications,
  ) => _$this._notifications = notifications;

  GGetNotificationsDataBuilder() {
    GGetNotificationsData._initializeBuilder(this);
  }

  GGetNotificationsDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _notifications = $v.notifications.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetNotificationsData other) {
    _$v = other as _$GGetNotificationsData;
  }

  @override
  void update(void Function(GGetNotificationsDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetNotificationsData build() => _build();

  _$GGetNotificationsData _build() {
    _$GGetNotificationsData _$result;
    try {
      _$result =
          _$v ??
          _$GGetNotificationsData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetNotificationsData',
              'G__typename',
            ),
            notifications: notifications.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'notifications';
        notifications.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetNotificationsData',
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

class _$GGetNotificationsData_notifications
    extends GGetNotificationsData_notifications {
  @override
  final String G__typename;
  @override
  final String body;
  @override
  final _i2.GDateTime createdAt;
  @override
  final String id;
  @override
  final bool isRead;
  @override
  final String receiverId;
  @override
  final String title;
  @override
  final String type;
  @override
  final _i2.GDateTime updatedAt;

  factory _$GGetNotificationsData_notifications([
    void Function(GGetNotificationsData_notificationsBuilder)? updates,
  ]) =>
      (GGetNotificationsData_notificationsBuilder()..update(updates))._build();

  _$GGetNotificationsData_notifications._({
    required this.G__typename,
    required this.body,
    required this.createdAt,
    required this.id,
    required this.isRead,
    required this.receiverId,
    required this.title,
    required this.type,
    required this.updatedAt,
  }) : super._();
  @override
  GGetNotificationsData_notifications rebuild(
    void Function(GGetNotificationsData_notificationsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetNotificationsData_notificationsBuilder toBuilder() =>
      GGetNotificationsData_notificationsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetNotificationsData_notifications &&
        G__typename == other.G__typename &&
        body == other.body &&
        createdAt == other.createdAt &&
        id == other.id &&
        isRead == other.isRead &&
        receiverId == other.receiverId &&
        title == other.title &&
        type == other.type &&
        updatedAt == other.updatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, body.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, receiverId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, updatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetNotificationsData_notifications')
          ..add('G__typename', G__typename)
          ..add('body', body)
          ..add('createdAt', createdAt)
          ..add('id', id)
          ..add('isRead', isRead)
          ..add('receiverId', receiverId)
          ..add('title', title)
          ..add('type', type)
          ..add('updatedAt', updatedAt))
        .toString();
  }
}

class GGetNotificationsData_notificationsBuilder
    implements
        Builder<
          GGetNotificationsData_notifications,
          GGetNotificationsData_notificationsBuilder
        > {
  _$GGetNotificationsData_notifications? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _body;
  String? get body => _$this._body;
  set body(String? body) => _$this._body = body;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  String? _receiverId;
  String? get receiverId => _$this._receiverId;
  set receiverId(String? receiverId) => _$this._receiverId = receiverId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  _i2.GDateTimeBuilder? _updatedAt;
  _i2.GDateTimeBuilder get updatedAt =>
      _$this._updatedAt ??= _i2.GDateTimeBuilder();
  set updatedAt(_i2.GDateTimeBuilder? updatedAt) =>
      _$this._updatedAt = updatedAt;

  GGetNotificationsData_notificationsBuilder() {
    GGetNotificationsData_notifications._initializeBuilder(this);
  }

  GGetNotificationsData_notificationsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _body = $v.body;
      _createdAt = $v.createdAt.toBuilder();
      _id = $v.id;
      _isRead = $v.isRead;
      _receiverId = $v.receiverId;
      _title = $v.title;
      _type = $v.type;
      _updatedAt = $v.updatedAt.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetNotificationsData_notifications other) {
    _$v = other as _$GGetNotificationsData_notifications;
  }

  @override
  void update(
    void Function(GGetNotificationsData_notificationsBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetNotificationsData_notifications build() => _build();

  _$GGetNotificationsData_notifications _build() {
    _$GGetNotificationsData_notifications _$result;
    try {
      _$result =
          _$v ??
          _$GGetNotificationsData_notifications._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetNotificationsData_notifications',
              'G__typename',
            ),
            body: BuiltValueNullFieldError.checkNotNull(
              body,
              r'GGetNotificationsData_notifications',
              'body',
            ),
            createdAt: createdAt.build(),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GGetNotificationsData_notifications',
              'id',
            ),
            isRead: BuiltValueNullFieldError.checkNotNull(
              isRead,
              r'GGetNotificationsData_notifications',
              'isRead',
            ),
            receiverId: BuiltValueNullFieldError.checkNotNull(
              receiverId,
              r'GGetNotificationsData_notifications',
              'receiverId',
            ),
            title: BuiltValueNullFieldError.checkNotNull(
              title,
              r'GGetNotificationsData_notifications',
              'title',
            ),
            type: BuiltValueNullFieldError.checkNotNull(
              type,
              r'GGetNotificationsData_notifications',
              'type',
            ),
            updatedAt: updatedAt.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();

        _$failedField = 'updatedAt';
        updatedAt.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetNotificationsData_notifications',
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
