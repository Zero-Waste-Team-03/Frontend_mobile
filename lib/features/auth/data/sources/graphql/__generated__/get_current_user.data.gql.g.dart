// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_current_user.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GGetCurrentUserData> _$gGetCurrentUserDataSerializer =
    _$GGetCurrentUserDataSerializer();
Serializer<GGetCurrentUserData_currentUser>
_$gGetCurrentUserDataCurrentUserSerializer =
    _$GGetCurrentUserData_currentUserSerializer();
Serializer<GGetCurrentUserData_currentUser_location>
_$gGetCurrentUserDataCurrentUserLocationSerializer =
    _$GGetCurrentUserData_currentUser_locationSerializer();
Serializer<GGetCurrentUserData_currentUser_avatar>
_$gGetCurrentUserDataCurrentUserAvatarSerializer =
    _$GGetCurrentUserData_currentUser_avatarSerializer();

class _$GGetCurrentUserDataSerializer
    implements StructuredSerializer<GGetCurrentUserData> {
  @override
  final Iterable<Type> types = const [
    GGetCurrentUserData,
    _$GGetCurrentUserData,
  ];
  @override
  final String wireName = 'GGetCurrentUserData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetCurrentUserData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'currentUser',
      serializers.serialize(
        object.currentUser,
        specifiedType: const FullType(GGetCurrentUserData_currentUser),
      ),
    ];

    return result;
  }

  @override
  GGetCurrentUserData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetCurrentUserDataBuilder();

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
        case 'currentUser':
          result.currentUser.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetCurrentUserData_currentUser,
                  ),
                )!
                as GGetCurrentUserData_currentUser,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetCurrentUserData_currentUserSerializer
    implements StructuredSerializer<GGetCurrentUserData_currentUser> {
  @override
  final Iterable<Type> types = const [
    GGetCurrentUserData_currentUser,
    _$GGetCurrentUserData_currentUser,
  ];
  @override
  final String wireName = 'GGetCurrentUserData_currentUser';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetCurrentUserData_currentUser object, {
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
      'email',
      serializers.serialize(
        object.email,
        specifiedType: const FullType(String),
      ),
      'role',
      serializers.serialize(
        object.role,
        specifiedType: const FullType(_i3.GUserRole),
      ),
      'isMailVerified',
      serializers.serialize(
        object.isMailVerified,
        specifiedType: const FullType(bool),
      ),
      'reputationScore',
      serializers.serialize(
        object.reputationScore,
        specifiedType: const FullType(int),
      ),
    ];
    Object? value;
    value = object.displayName;
    if (value != null) {
      result
        ..add('displayName')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.phoneNumber;
    if (value != null) {
      result
        ..add('phoneNumber')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.locationId;
    if (value != null) {
      result
        ..add('locationId')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.location;
    if (value != null) {
      result
        ..add('location')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GGetCurrentUserData_currentUser_location,
            ),
          ),
        );
    }
    value = object.avatar;
    if (value != null) {
      result
        ..add('avatar')
        ..add(
          serializers.serialize(
            value,
            specifiedType: const FullType(
              GGetCurrentUserData_currentUser_avatar,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GGetCurrentUserData_currentUser deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetCurrentUserData_currentUserBuilder();

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
        case 'email':
          result.email =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )!
                  as String;
          break;
        case 'displayName':
          result.displayName =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'role':
          result.role =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(_i3.GUserRole),
                  )!
                  as _i3.GUserRole;
          break;
        case 'description':
          result.description =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'isMailVerified':
          result.isMailVerified =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )!
                  as bool;
          break;
        case 'phoneNumber':
          result.phoneNumber =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'reputationScore':
          result.reputationScore =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(int),
                  )!
                  as int;
          break;
        case 'locationId':
          result.locationId =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'location':
          result.location.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetCurrentUserData_currentUser_location,
                  ),
                )!
                as GGetCurrentUserData_currentUser_location,
          );
          break;
        case 'avatar':
          result.avatar.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GGetCurrentUserData_currentUser_avatar,
                  ),
                )!
                as GGetCurrentUserData_currentUser_avatar,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GGetCurrentUserData_currentUser_locationSerializer
    implements StructuredSerializer<GGetCurrentUserData_currentUser_location> {
  @override
  final Iterable<Type> types = const [
    GGetCurrentUserData_currentUser_location,
    _$GGetCurrentUserData_currentUser_location,
  ];
  @override
  final String wireName = 'GGetCurrentUserData_currentUser_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetCurrentUserData_currentUser_location object, {
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
    ];
    Object? value;
    value = object.city;
    if (value != null) {
      result
        ..add('city')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.country;
    if (value != null) {
      result
        ..add('country')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    value = object.latitude;
    if (value != null) {
      result
        ..add('latitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.longitude;
    if (value != null) {
      result
        ..add('longitude')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(double)),
        );
    }
    value = object.neighborhood;
    if (value != null) {
      result
        ..add('neighborhood')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GGetCurrentUserData_currentUser_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetCurrentUserData_currentUser_locationBuilder();

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
        case 'city':
          result.city =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'country':
          result.country =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'latitude':
          result.latitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'longitude':
          result.longitude =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(double),
                  )
                  as double?;
          break;
        case 'neighborhood':
          result.neighborhood =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
      }
    }

    return result.build();
  }
}

class _$GGetCurrentUserData_currentUser_avatarSerializer
    implements StructuredSerializer<GGetCurrentUserData_currentUser_avatar> {
  @override
  final Iterable<Type> types = const [
    GGetCurrentUserData_currentUser_avatar,
    _$GGetCurrentUserData_currentUser_avatar,
  ];
  @override
  final String wireName = 'GGetCurrentUserData_currentUser_avatar';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GGetCurrentUserData_currentUser_avatar object, {
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
      'fileType',
      serializers.serialize(
        object.fileType,
        specifiedType: const FullType(String),
      ),
    ];
    Object? value;
    value = object.url;
    if (value != null) {
      result
        ..add('url')
        ..add(
          serializers.serialize(value, specifiedType: const FullType(String)),
        );
    }
    return result;
  }

  @override
  GGetCurrentUserData_currentUser_avatar deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GGetCurrentUserData_currentUser_avatarBuilder();

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
        case 'url':
          result.url =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String?;
          break;
        case 'fileType':
          result.fileType =
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

class _$GGetCurrentUserData extends GGetCurrentUserData {
  @override
  final String G__typename;
  @override
  final GGetCurrentUserData_currentUser currentUser;

  factory _$GGetCurrentUserData([
    void Function(GGetCurrentUserDataBuilder)? updates,
  ]) => (GGetCurrentUserDataBuilder()..update(updates))._build();

  _$GGetCurrentUserData._({
    required this.G__typename,
    required this.currentUser,
  }) : super._();
  @override
  GGetCurrentUserData rebuild(
    void Function(GGetCurrentUserDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetCurrentUserDataBuilder toBuilder() =>
      GGetCurrentUserDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetCurrentUserData &&
        G__typename == other.G__typename &&
        currentUser == other.currentUser;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, currentUser.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetCurrentUserData')
          ..add('G__typename', G__typename)
          ..add('currentUser', currentUser))
        .toString();
  }
}

class GGetCurrentUserDataBuilder
    implements Builder<GGetCurrentUserData, GGetCurrentUserDataBuilder> {
  _$GGetCurrentUserData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GGetCurrentUserData_currentUserBuilder? _currentUser;
  GGetCurrentUserData_currentUserBuilder get currentUser =>
      _$this._currentUser ??= GGetCurrentUserData_currentUserBuilder();
  set currentUser(GGetCurrentUserData_currentUserBuilder? currentUser) =>
      _$this._currentUser = currentUser;

  GGetCurrentUserDataBuilder() {
    GGetCurrentUserData._initializeBuilder(this);
  }

  GGetCurrentUserDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _currentUser = $v.currentUser.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetCurrentUserData other) {
    _$v = other as _$GGetCurrentUserData;
  }

  @override
  void update(void Function(GGetCurrentUserDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetCurrentUserData build() => _build();

  _$GGetCurrentUserData _build() {
    _$GGetCurrentUserData _$result;
    try {
      _$result =
          _$v ??
          _$GGetCurrentUserData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetCurrentUserData',
              'G__typename',
            ),
            currentUser: currentUser.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'currentUser';
        currentUser.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetCurrentUserData',
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

class _$GGetCurrentUserData_currentUser
    extends GGetCurrentUserData_currentUser {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String email;
  @override
  final String? displayName;
  @override
  final _i3.GUserRole role;
  @override
  final String? description;
  @override
  final bool isMailVerified;
  @override
  final String? phoneNumber;
  @override
  final int reputationScore;
  @override
  final String? locationId;
  @override
  final GGetCurrentUserData_currentUser_location? location;
  @override
  final GGetCurrentUserData_currentUser_avatar? avatar;

  factory _$GGetCurrentUserData_currentUser([
    void Function(GGetCurrentUserData_currentUserBuilder)? updates,
  ]) => (GGetCurrentUserData_currentUserBuilder()..update(updates))._build();

  _$GGetCurrentUserData_currentUser._({
    required this.G__typename,
    required this.id,
    required this.email,
    this.displayName,
    required this.role,
    this.description,
    required this.isMailVerified,
    this.phoneNumber,
    required this.reputationScore,
    this.locationId,
    this.location,
    this.avatar,
  }) : super._();
  @override
  GGetCurrentUserData_currentUser rebuild(
    void Function(GGetCurrentUserData_currentUserBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetCurrentUserData_currentUserBuilder toBuilder() =>
      GGetCurrentUserData_currentUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetCurrentUserData_currentUser &&
        G__typename == other.G__typename &&
        id == other.id &&
        email == other.email &&
        displayName == other.displayName &&
        role == other.role &&
        description == other.description &&
        isMailVerified == other.isMailVerified &&
        phoneNumber == other.phoneNumber &&
        reputationScore == other.reputationScore &&
        locationId == other.locationId &&
        location == other.location &&
        avatar == other.avatar;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, displayName.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, isMailVerified.hashCode);
    _$hash = $jc(_$hash, phoneNumber.hashCode);
    _$hash = $jc(_$hash, reputationScore.hashCode);
    _$hash = $jc(_$hash, locationId.hashCode);
    _$hash = $jc(_$hash, location.hashCode);
    _$hash = $jc(_$hash, avatar.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GGetCurrentUserData_currentUser')
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('email', email)
          ..add('displayName', displayName)
          ..add('role', role)
          ..add('description', description)
          ..add('isMailVerified', isMailVerified)
          ..add('phoneNumber', phoneNumber)
          ..add('reputationScore', reputationScore)
          ..add('locationId', locationId)
          ..add('location', location)
          ..add('avatar', avatar))
        .toString();
  }
}

class GGetCurrentUserData_currentUserBuilder
    implements
        Builder<
          GGetCurrentUserData_currentUser,
          GGetCurrentUserData_currentUserBuilder
        > {
  _$GGetCurrentUserData_currentUser? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _displayName;
  String? get displayName => _$this._displayName;
  set displayName(String? displayName) => _$this._displayName = displayName;

  _i3.GUserRole? _role;
  _i3.GUserRole? get role => _$this._role;
  set role(_i3.GUserRole? role) => _$this._role = role;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  bool? _isMailVerified;
  bool? get isMailVerified => _$this._isMailVerified;
  set isMailVerified(bool? isMailVerified) =>
      _$this._isMailVerified = isMailVerified;

  String? _phoneNumber;
  String? get phoneNumber => _$this._phoneNumber;
  set phoneNumber(String? phoneNumber) => _$this._phoneNumber = phoneNumber;

  int? _reputationScore;
  int? get reputationScore => _$this._reputationScore;
  set reputationScore(int? reputationScore) =>
      _$this._reputationScore = reputationScore;

  String? _locationId;
  String? get locationId => _$this._locationId;
  set locationId(String? locationId) => _$this._locationId = locationId;

  GGetCurrentUserData_currentUser_locationBuilder? _location;
  GGetCurrentUserData_currentUser_locationBuilder get location =>
      _$this._location ??= GGetCurrentUserData_currentUser_locationBuilder();
  set location(GGetCurrentUserData_currentUser_locationBuilder? location) =>
      _$this._location = location;

  GGetCurrentUserData_currentUser_avatarBuilder? _avatar;
  GGetCurrentUserData_currentUser_avatarBuilder get avatar =>
      _$this._avatar ??= GGetCurrentUserData_currentUser_avatarBuilder();
  set avatar(GGetCurrentUserData_currentUser_avatarBuilder? avatar) =>
      _$this._avatar = avatar;

  GGetCurrentUserData_currentUserBuilder() {
    GGetCurrentUserData_currentUser._initializeBuilder(this);
  }

  GGetCurrentUserData_currentUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _email = $v.email;
      _displayName = $v.displayName;
      _role = $v.role;
      _description = $v.description;
      _isMailVerified = $v.isMailVerified;
      _phoneNumber = $v.phoneNumber;
      _reputationScore = $v.reputationScore;
      _locationId = $v.locationId;
      _location = $v.location?.toBuilder();
      _avatar = $v.avatar?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetCurrentUserData_currentUser other) {
    _$v = other as _$GGetCurrentUserData_currentUser;
  }

  @override
  void update(void Function(GGetCurrentUserData_currentUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GGetCurrentUserData_currentUser build() => _build();

  _$GGetCurrentUserData_currentUser _build() {
    _$GGetCurrentUserData_currentUser _$result;
    try {
      _$result =
          _$v ??
          _$GGetCurrentUserData_currentUser._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GGetCurrentUserData_currentUser',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GGetCurrentUserData_currentUser',
              'id',
            ),
            email: BuiltValueNullFieldError.checkNotNull(
              email,
              r'GGetCurrentUserData_currentUser',
              'email',
            ),
            displayName: displayName,
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'GGetCurrentUserData_currentUser',
              'role',
            ),
            description: description,
            isMailVerified: BuiltValueNullFieldError.checkNotNull(
              isMailVerified,
              r'GGetCurrentUserData_currentUser',
              'isMailVerified',
            ),
            phoneNumber: phoneNumber,
            reputationScore: BuiltValueNullFieldError.checkNotNull(
              reputationScore,
              r'GGetCurrentUserData_currentUser',
              'reputationScore',
            ),
            locationId: locationId,
            location: _location?.build(),
            avatar: _avatar?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'location';
        _location?.build();
        _$failedField = 'avatar';
        _avatar?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GGetCurrentUserData_currentUser',
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

class _$GGetCurrentUserData_currentUser_location
    extends GGetCurrentUserData_currentUser_location {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? city;
  @override
  final String? country;
  @override
  final double? latitude;
  @override
  final double? longitude;
  @override
  final String? neighborhood;

  factory _$GGetCurrentUserData_currentUser_location([
    void Function(GGetCurrentUserData_currentUser_locationBuilder)? updates,
  ]) => (GGetCurrentUserData_currentUser_locationBuilder()..update(updates))
      ._build();

  _$GGetCurrentUserData_currentUser_location._({
    required this.G__typename,
    required this.id,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.neighborhood,
  }) : super._();
  @override
  GGetCurrentUserData_currentUser_location rebuild(
    void Function(GGetCurrentUserData_currentUser_locationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetCurrentUserData_currentUser_locationBuilder toBuilder() =>
      GGetCurrentUserData_currentUser_locationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetCurrentUserData_currentUser_location &&
        G__typename == other.G__typename &&
        id == other.id &&
        city == other.city &&
        country == other.country &&
        latitude == other.latitude &&
        longitude == other.longitude &&
        neighborhood == other.neighborhood;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, city.hashCode);
    _$hash = $jc(_$hash, country.hashCode);
    _$hash = $jc(_$hash, latitude.hashCode);
    _$hash = $jc(_$hash, longitude.hashCode);
    _$hash = $jc(_$hash, neighborhood.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetCurrentUserData_currentUser_location',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('city', city)
          ..add('country', country)
          ..add('latitude', latitude)
          ..add('longitude', longitude)
          ..add('neighborhood', neighborhood))
        .toString();
  }
}

class GGetCurrentUserData_currentUser_locationBuilder
    implements
        Builder<
          GGetCurrentUserData_currentUser_location,
          GGetCurrentUserData_currentUser_locationBuilder
        > {
  _$GGetCurrentUserData_currentUser_location? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _city;
  String? get city => _$this._city;
  set city(String? city) => _$this._city = city;

  String? _country;
  String? get country => _$this._country;
  set country(String? country) => _$this._country = country;

  double? _latitude;
  double? get latitude => _$this._latitude;
  set latitude(double? latitude) => _$this._latitude = latitude;

  double? _longitude;
  double? get longitude => _$this._longitude;
  set longitude(double? longitude) => _$this._longitude = longitude;

  String? _neighborhood;
  String? get neighborhood => _$this._neighborhood;
  set neighborhood(String? neighborhood) => _$this._neighborhood = neighborhood;

  GGetCurrentUserData_currentUser_locationBuilder() {
    GGetCurrentUserData_currentUser_location._initializeBuilder(this);
  }

  GGetCurrentUserData_currentUser_locationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _city = $v.city;
      _country = $v.country;
      _latitude = $v.latitude;
      _longitude = $v.longitude;
      _neighborhood = $v.neighborhood;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetCurrentUserData_currentUser_location other) {
    _$v = other as _$GGetCurrentUserData_currentUser_location;
  }

  @override
  void update(
    void Function(GGetCurrentUserData_currentUser_locationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetCurrentUserData_currentUser_location build() => _build();

  _$GGetCurrentUserData_currentUser_location _build() {
    final _$result =
        _$v ??
        _$GGetCurrentUserData_currentUser_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetCurrentUserData_currentUser_location',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GGetCurrentUserData_currentUser_location',
            'id',
          ),
          city: city,
          country: country,
          latitude: latitude,
          longitude: longitude,
          neighborhood: neighborhood,
        );
    replace(_$result);
    return _$result;
  }
}

class _$GGetCurrentUserData_currentUser_avatar
    extends GGetCurrentUserData_currentUser_avatar {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? url;
  @override
  final String fileType;

  factory _$GGetCurrentUserData_currentUser_avatar([
    void Function(GGetCurrentUserData_currentUser_avatarBuilder)? updates,
  ]) => (GGetCurrentUserData_currentUser_avatarBuilder()..update(updates))
      ._build();

  _$GGetCurrentUserData_currentUser_avatar._({
    required this.G__typename,
    required this.id,
    this.url,
    required this.fileType,
  }) : super._();
  @override
  GGetCurrentUserData_currentUser_avatar rebuild(
    void Function(GGetCurrentUserData_currentUser_avatarBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GGetCurrentUserData_currentUser_avatarBuilder toBuilder() =>
      GGetCurrentUserData_currentUser_avatarBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GGetCurrentUserData_currentUser_avatar &&
        G__typename == other.G__typename &&
        id == other.id &&
        url == other.url &&
        fileType == other.fileType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, url.hashCode);
    _$hash = $jc(_$hash, fileType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'GGetCurrentUserData_currentUser_avatar',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('url', url)
          ..add('fileType', fileType))
        .toString();
  }
}

class GGetCurrentUserData_currentUser_avatarBuilder
    implements
        Builder<
          GGetCurrentUserData_currentUser_avatar,
          GGetCurrentUserData_currentUser_avatarBuilder
        > {
  _$GGetCurrentUserData_currentUser_avatar? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  String? _fileType;
  String? get fileType => _$this._fileType;
  set fileType(String? fileType) => _$this._fileType = fileType;

  GGetCurrentUserData_currentUser_avatarBuilder() {
    GGetCurrentUserData_currentUser_avatar._initializeBuilder(this);
  }

  GGetCurrentUserData_currentUser_avatarBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _id = $v.id;
      _url = $v.url;
      _fileType = $v.fileType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GGetCurrentUserData_currentUser_avatar other) {
    _$v = other as _$GGetCurrentUserData_currentUser_avatar;
  }

  @override
  void update(
    void Function(GGetCurrentUserData_currentUser_avatarBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GGetCurrentUserData_currentUser_avatar build() => _build();

  _$GGetCurrentUserData_currentUser_avatar _build() {
    final _$result =
        _$v ??
        _$GGetCurrentUserData_currentUser_avatar._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GGetCurrentUserData_currentUser_avatar',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GGetCurrentUserData_currentUser_avatar',
            'id',
          ),
          url: url,
          fileType: BuiltValueNullFieldError.checkNotNull(
            fileType,
            r'GGetCurrentUserData_currentUser_avatar',
            'fileType',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
