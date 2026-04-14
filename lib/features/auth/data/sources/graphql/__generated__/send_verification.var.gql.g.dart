// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_verification.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GSendVerificationVars> _$gSendVerificationVarsSerializer =
    _$GSendVerificationVarsSerializer();

class _$GSendVerificationVarsSerializer
    implements StructuredSerializer<GSendVerificationVars> {
  @override
  final Iterable<Type> types = const [
    GSendVerificationVars,
    _$GSendVerificationVars,
  ];
  @override
  final String wireName = 'GSendVerificationVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GSendVerificationVars object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      'email',
      serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      ),
    ];

    return result;
  }

  @override
  GSendVerificationVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GSendVerificationVarsBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current! as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'email':
          result.email =
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

class _$GSendVerificationVars extends GSendVerificationVars {
  @override
  final String email;

  factory _$GSendVerificationVars([
    void Function(GSendVerificationVarsBuilder)? updates,
  ]) => (GSendVerificationVarsBuilder()..update(updates))._build();

  _$GSendVerificationVars._({required this.email}) : super._();
  @override
  GSendVerificationVars rebuild(
    void Function(GSendVerificationVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GSendVerificationVarsBuilder toBuilder() =>
      GSendVerificationVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GSendVerificationVars && email == other.email;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
      r'GSendVerificationVars',
    )..add('email', email)).toString();
  }
}

class GSendVerificationVarsBuilder
    implements Builder<GSendVerificationVars, GSendVerificationVarsBuilder> {
  _$GSendVerificationVars? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GSendVerificationVarsBuilder();

  GSendVerificationVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GSendVerificationVars other) {
    _$v = other as _$GSendVerificationVars;
  }

  @override
  void update(void Function(GSendVerificationVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GSendVerificationVars build() => _build();

  _$GSendVerificationVars _build() {
    final _$result =
        _$v ??
        _$GSendVerificationVars._(
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'GSendVerificationVars',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
