// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_verification.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSendVerificationData> _$gSendVerificationDataSerializer =
    _$GSendVerificationDataSerializer();
Serializer<GSendVerificationData_sendVerification>
_$gSendVerificationDataSendVerificationSerializer =
    _$GSendVerificationData_sendVerificationSerializer();

class _$GSendVerificationDataSerializer
    implements StructuredSerializer<GSendVerificationData> {
  @override
  final Iterable<Type> types = const [
    GSendVerificationData,
    _$GSendVerificationData,
  ];
  @override
  final String wireName = 'GSendVerificationData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSendVerificationData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'sendVerification',
      serializers.serialize(
        object.sendVerification,
        specifiedType: const FullType(GSendVerificationData_sendVerification),
      ),
    ];

    return result;
  }

  @override
  GSendVerificationData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSendVerificationDataBuilder();

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
        case 'sendVerification':
          result.sendVerification.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GSendVerificationData_sendVerification,
                  ),
                )!
                as GSendVerificationData_sendVerification,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GSendVerificationData_sendVerificationSerializer
    implements StructuredSerializer<GSendVerificationData_sendVerification> {
  @override
  final Iterable<Type> types = const [
    GSendVerificationData_sendVerification,
    _$GSendVerificationData_sendVerification,
  ];
  @override
  final String wireName = 'GSendVerificationData_sendVerification';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSendVerificationData_sendVerification object, {
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
  GSendVerificationData_sendVerification deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSendVerificationData_sendVerificationBuilder();

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

class _$GSendVerificationData extends GSendVerificationData {
  @override
  final String G__typename;
  @override
  final GSendVerificationData_sendVerification sendVerification;

  factory _$GSendVerificationData([
    void Function(GSendVerificationDataBuilder)? updates,
  ]) => (GSendVerificationDataBuilder()..update(updates))._build();

  _$GSendVerificationData._({
    required this.G__typename,
    required this.sendVerification,
  }) : super._();
  @override
  GSendVerificationData rebuild(
    void Function(GSendVerificationDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GSendVerificationDataBuilder toBuilder() =>
      GSendVerificationDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendVerificationData &&
        G__typename == other.G__typename &&
        sendVerification == other.sendVerification;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, sendVerification.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GSendVerificationData')
          ..add('G__typename', G__typename)
          ..add('sendVerification', sendVerification))
        .toString();
  }
}

class GSendVerificationDataBuilder
    implements Builder<GSendVerificationData, GSendVerificationDataBuilder> {
  _$GSendVerificationData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GSendVerificationData_sendVerificationBuilder? _sendVerification;
  GSendVerificationData_sendVerificationBuilder get sendVerification =>
      _$this._sendVerification ??=
          GSendVerificationData_sendVerificationBuilder();
  set sendVerification(
    GSendVerificationData_sendVerificationBuilder? sendVerification,
  ) => _$this._sendVerification = sendVerification;

  GSendVerificationDataBuilder() {
    GSendVerificationData._initializeBuilder(this);
  }

  GSendVerificationDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _sendVerification = $v.sendVerification.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendVerificationData other) {
    _$v = other as _$GSendVerificationData;
  }

  @override
  void update(void Function(GSendVerificationDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendVerificationData build() => _build();

  _$GSendVerificationData _build() {
    _$GSendVerificationData _$result;
    try {
      _$result =
          _$v ??
          _$GSendVerificationData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GSendVerificationData',
              'G__typename',
            ),
            sendVerification: sendVerification.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sendVerification';
        sendVerification.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GSendVerificationData',
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

class _$GSendVerificationData_sendVerification
    extends GSendVerificationData_sendVerification {
  @override
  final String G__typename;
  @override
  final String message;

  factory _$GSendVerificationData_sendVerification([
    void Function(GSendVerificationData_sendVerificationBuilder)? updates,
  ]) => (GSendVerificationData_sendVerificationBuilder()..update(updates))
      ._build();

  _$GSendVerificationData_sendVerification._({
    required this.G__typename,
    required this.message,
  }) : super._();
  @override
  GSendVerificationData_sendVerification rebuild(
    void Function(GSendVerificationData_sendVerificationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GSendVerificationData_sendVerificationBuilder toBuilder() =>
      GSendVerificationData_sendVerificationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendVerificationData_sendVerification &&
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
            r'GSendVerificationData_sendVerification',
          )
          ..add('G__typename', G__typename)
          ..add('message', message))
        .toString();
  }
}

class GSendVerificationData_sendVerificationBuilder
    implements
        Builder<
          GSendVerificationData_sendVerification,
          GSendVerificationData_sendVerificationBuilder
        > {
  _$GSendVerificationData_sendVerification? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  GSendVerificationData_sendVerificationBuilder() {
    GSendVerificationData_sendVerification._initializeBuilder(this);
  }

  GSendVerificationData_sendVerificationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendVerificationData_sendVerification other) {
    _$v = other as _$GSendVerificationData_sendVerification;
  }

  @override
  void update(
    void Function(GSendVerificationData_sendVerificationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GSendVerificationData_sendVerification build() => _build();

  _$GSendVerificationData_sendVerification _build() {
    final _$result =
        _$v ??
        _$GSendVerificationData_sendVerification._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GSendVerificationData_sendVerification',
            'G__typename',
          ),
          message: BuiltValueNullFieldError.checkNotNull(
            message,
            r'GSendVerificationData_sendVerification',
            'message',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
