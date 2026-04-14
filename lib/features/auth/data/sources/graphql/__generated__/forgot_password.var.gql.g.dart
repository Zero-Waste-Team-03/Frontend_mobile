// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forgot_password.var.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GForgotPasswordVars> _$gForgotPasswordVarsSerializer =
    _$GForgotPasswordVarsSerializer();

class _$GForgotPasswordVarsSerializer
    implements StructuredSerializer<GForgotPasswordVars> {
  @override
  final Iterable<Type> types = const [
    GForgotPasswordVars,
    _$GForgotPasswordVars,
  ];
  @override
  final String wireName = 'GForgotPasswordVars';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GForgotPasswordVars object, {
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
  GForgotPasswordVars deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GForgotPasswordVarsBuilder();

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

class _$GForgotPasswordVars extends GForgotPasswordVars {
  @override
  final String email;

  factory _$GForgotPasswordVars([
    void Function(GForgotPasswordVarsBuilder)? updates,
  ]) => (GForgotPasswordVarsBuilder()..update(updates))._build();

  _$GForgotPasswordVars._({required this.email}) : super._();
  @override
  GForgotPasswordVars rebuild(
    void Function(GForgotPasswordVarsBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GForgotPasswordVarsBuilder toBuilder() =>
      GForgotPasswordVarsBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GForgotPasswordVars && email == other.email;
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
      r'GForgotPasswordVars',
    )..add('email', email)).toString();
  }
}

class GForgotPasswordVarsBuilder
    implements Builder<GForgotPasswordVars, GForgotPasswordVarsBuilder> {
  _$GForgotPasswordVars? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  GForgotPasswordVarsBuilder();

  GForgotPasswordVarsBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GForgotPasswordVars other) {
    _$v = other as _$GForgotPasswordVars;
  }

  @override
  void update(void Function(GForgotPasswordVarsBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GForgotPasswordVars build() => _build();

  _$GForgotPasswordVars _build() {
    final _$result =
        _$v ??
        _$GForgotPasswordVars._(
          email: BuiltValueNullFieldError.checkNotNull(
            email,
            r'GForgotPasswordVars',
            'email',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
