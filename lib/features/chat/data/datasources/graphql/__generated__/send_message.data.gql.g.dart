// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSendMessageData> _$gSendMessageDataSerializer =
    _$GSendMessageDataSerializer();
Serializer<GSendMessageData_sendMessage>
_$gSendMessageDataSendMessageSerializer =
    _$GSendMessageData_sendMessageSerializer();

class _$GSendMessageDataSerializer
    implements StructuredSerializer<GSendMessageData> {
  @override
  final Iterable<Type> types = const [GSendMessageData, _$GSendMessageData];
  @override
  final String wireName = 'GSendMessageData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSendMessageData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'sendMessage',
      serializers.serialize(
        object.sendMessage,
        specifiedType: const FullType(GSendMessageData_sendMessage),
      ),
    ];

    return result;
  }

  @override
  GSendMessageData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSendMessageDataBuilder();

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
        case 'sendMessage':
          result.sendMessage.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(GSendMessageData_sendMessage),
                )!
                as GSendMessageData_sendMessage,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GSendMessageData_sendMessageSerializer
    implements StructuredSerializer<GSendMessageData_sendMessage> {
  @override
  final Iterable<Type> types = const [
    GSendMessageData_sendMessage,
    _$GSendMessageData_sendMessage,
  ];
  @override
  final String wireName = 'GSendMessageData_sendMessage';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSendMessageData_sendMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'id',
      serializers.serialize(object.id, specifiedType: const FullType(String)),
      'content',
      serializers.serialize(
        object.content,
        specifiedType: const FullType(String),
      ),
      'createdAt',
      serializers.serialize(
        object.createdAt,
        specifiedType: const FullType(_i2.GDateTime),
      ),
      'isModerated',
      serializers.serialize(
        object.isModerated,
        specifiedType: const FullType(bool),
      ),
      'senderId',
      serializers.serialize(
        object.senderId,
        specifiedType: const FullType(String),
      ),
      'conversationId',
      serializers.serialize(
        object.conversationId,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GSendMessageData_sendMessage deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSendMessageData_sendMessageBuilder();

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
        case 'id':
          result.id =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'content':
          result.content =
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
        case 'isModerated':
          result.isModerated =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'senderId':
          result.senderId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'conversationId':
          result.conversationId =
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

class _$GSendMessageData extends GSendMessageData {
  @override
  final String G__typename;
  @override
  final GSendMessageData_sendMessage sendMessage;

  factory _$GSendMessageData([
    void Function(GSendMessageDataBuilder)? updates,
  ]) => (GSendMessageDataBuilder()..update(updates))._build();

  _$GSendMessageData._({required this.G__typename, required this.sendMessage})
    : super._();
  @override
  GSendMessageData rebuild(void Function(GSendMessageDataBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GSendMessageDataBuilder toBuilder() =>
      GSendMessageDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageData &&
        G__typename == other.G__typename &&
        sendMessage == other.sendMessage;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, sendMessage.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageData')
          ..add('G__typename', G__typename)
          ..add('sendMessage', sendMessage))
        .toString();
  }
}

class GSendMessageDataBuilder
    implements Builder<GSendMessageData, GSendMessageDataBuilder> {
  _$GSendMessageData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendMessageData_sendMessageBuilder? _sendMessage;
  GSendMessageData_sendMessageBuilder get sendMessage =>
      _$this._sendMessage ??= GSendMessageData_sendMessageBuilder();
  set sendMessage(GSendMessageData_sendMessageBuilder? sendMessage) =>
      _$this._sendMessage = sendMessage;

  GSendMessageDataBuilder() {
    GSendMessageData._initializeBuilder(this);
  }

  GSendMessageDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _sendMessage = $v.sendMessage.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageData other) {
    _$v = other as _$GSendMessageData;
  }

  @override
  void update(void Function(GSendMessageDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageData build() => _build();

  _$GSendMessageData _build() {
    _$GSendMessageData _$result;
    try {
      _$result =
          _$v ??
          _$GSendMessageData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSendMessageData',
              'G__typename',
            ),
            sendMessage: sendMessage.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sendMessage';
        sendMessage.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GSendMessageData',
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

class _$GSendMessageData_sendMessage extends GSendMessageData_sendMessage {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String content;
  @override
  final _i2.GDateTime createdAt;
  @override
  final bool isModerated;
  @override
  final String senderId;
  @override
  final String conversationId;

  factory _$GSendMessageData_sendMessage([
    void Function(GSendMessageData_sendMessageBuilder)? updates,
  ]) => (GSendMessageData_sendMessageBuilder()..update(updates))._build();

  _$GSendMessageData_sendMessage._({
    required this.G__typename,
    required this.id,
    required this.content,
    required this.createdAt,
    required this.isModerated,
    required this.senderId,
    required this.conversationId,
  }) : super._();
  @override
  GSendMessageData_sendMessage rebuild(
    void Function(GSendMessageData_sendMessageBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GSendMessageData_sendMessageBuilder toBuilder() =>
      GSendMessageData_sendMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendMessageData_sendMessage &&
        G__typename == other.G__typename &&
        id == other.id &&
        content == other.content &&
        createdAt == other.createdAt &&
        isModerated == other.isModerated &&
        senderId == other.senderId &&
        conversationId == other.conversationId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, isModerated.hashCode);
    _$hash = $jc(_$hash, senderId.hashCode);
    _$hash = $jc(_$hash, conversationId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendMessageData_sendMessage')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('content', content)
          ..add('createdAt', createdAt)
          ..add('isModerated', isModerated)
          ..add('senderId', senderId)
          ..add('conversationId', conversationId))
        .toString();
  }
}

class GSendMessageData_sendMessageBuilder
    implements
        Builder<
          GSendMessageData_sendMessage,
          GSendMessageData_sendMessageBuilder
        > {
  _$GSendMessageData_sendMessage? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  _i2.GDateTimeBuilder? _createdAt;
  _i2.GDateTimeBuilder get createdAt =>
      _$this._createdAt ??= _i2.GDateTimeBuilder();
  set createdAt(_i2.GDateTimeBuilder? createdAt) =>
      _$this._createdAt = createdAt;

  bool? _isModerated;
  bool? get isModerated => _$this._isModerated;
  set isModerated(bool? isModerated) => _$this._isModerated = isModerated;

  String? _senderId;
  String? get senderId => _$this._senderId;
  set senderId(String? senderId) => _$this._senderId = senderId;

  String? _conversationId;
  String? get conversationId => _$this._conversationId;
  set conversationId(String? conversationId) =>
      _$this._conversationId = conversationId;

  GSendMessageData_sendMessageBuilder() {
    GSendMessageData_sendMessage._initializeBuilder(this);
  }

  GSendMessageData_sendMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _content = $v.content;
      _createdAt = $v.createdAt.toBuilder();
      _isModerated = $v.isModerated;
      _senderId = $v.senderId;
      _conversationId = $v.conversationId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendMessageData_sendMessage other) {
    _$v = other as _$GSendMessageData_sendMessage;
  }

  @override
  void update(void Function(GSendMessageData_sendMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendMessageData_sendMessage build() => _build();

  _$GSendMessageData_sendMessage _build() {
    _$GSendMessageData_sendMessage _$result;
    try {
      _$result =
          _$v ??
          _$GSendMessageData_sendMessage._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSendMessageData_sendMessage',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GSendMessageData_sendMessage',
              'id',
            ),
            content: BuiltValueNullFieldError.checkNotNull(
              content,
              r'GSendMessageData_sendMessage',
              'content',
            ),
            createdAt: createdAt.build(),
            isModerated: BuiltValueNullFieldError.checkNotNull(
              isModerated,
              r'GSendMessageData_sendMessage',
              'isModerated',
            ),
            senderId: BuiltValueNullFieldError.checkNotNull(
              senderId,
              r'GSendMessageData_sendMessage',
              'senderId',
            ),
            conversationId: BuiltValueNullFieldError.checkNotNull(
              conversationId,
              r'GSendMessageData_sendMessage',
              'conversationId',
            ),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'createdAt';
        createdAt.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GSendMessageData_sendMessage',
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
