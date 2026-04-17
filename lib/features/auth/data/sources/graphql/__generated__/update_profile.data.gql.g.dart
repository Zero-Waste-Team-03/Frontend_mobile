// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile.data.gql.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GUpdateProfileData> _$gUpdateProfileDataSerializer =
    _$GUpdateProfileDataSerializer();
Serializer<GUpdateProfileData_updateProfile>
_$gUpdateProfileDataUpdateProfileSerializer =
    _$GUpdateProfileData_updateProfileSerializer();
Serializer<GUpdateProfileData_updateProfile_location>
_$gUpdateProfileDataUpdateProfileLocationSerializer =
    _$GUpdateProfileData_updateProfile_locationSerializer();
Serializer<GUpdateProfileData_updateProfile_avatar>
_$gUpdateProfileDataUpdateProfileAvatarSerializer =
    _$GUpdateProfileData_updateProfile_avatarSerializer();

class _$GUpdateProfileDataSerializer
    implements StructuredSerializer<GUpdateProfileData> {
  @override
  final Iterable<Type> types = const [GUpdateProfileData, _$GUpdateProfileData];
  @override
  final String wireName = 'GUpdateProfileData';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileData object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      '__typename',
      serializers.serialize(
        object.G__typename,
        specifiedType: const FullType(String),
      ),
      'updateProfile',
      serializers.serialize(
        object.updateProfile,
        specifiedType: const FullType(GUpdateProfileData_updateProfile),
      ),
    ];

    return result;
  }

  @override
  GUpdateProfileData deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateProfileDataBuilder();

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
        case 'updateProfile':
          result.updateProfile.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GUpdateProfileData_updateProfile,
                  ),
                )!
                as GUpdateProfileData_updateProfile,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileData_updateProfileSerializer
    implements StructuredSerializer<GUpdateProfileData_updateProfile> {
  @override
  final Iterable<Type> types = const [
    GUpdateProfileData_updateProfile,
    _$GUpdateProfileData_updateProfile,
  ];
  @override
  final String wireName = 'GUpdateProfileData_updateProfile';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileData_updateProfile object, {
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
              GUpdateProfileData_updateProfile_location,
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
              GUpdateProfileData_updateProfile_avatar,
            ),
          ),
        );
    }
    return result;
  }

  @override
  GUpdateProfileData_updateProfile deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateProfileData_updateProfileBuilder();

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
                    GUpdateProfileData_updateProfile_location,
                  ),
                )!
                as GUpdateProfileData_updateProfile_location,
          );
          break;
        case 'avatar':
          result.avatar.replace(
            serializers.deserialize(
                  value,
                  specifiedType: const FullType(
                    GUpdateProfileData_updateProfile_avatar,
                  ),
                )!
                as GUpdateProfileData_updateProfile_avatar,
          );
          break;
      }
    }

    return result.build();
  }
}

class _$GUpdateProfileData_updateProfile_locationSerializer
    implements StructuredSerializer<GUpdateProfileData_updateProfile_location> {
  @override
  final Iterable<Type> types = const [
    GUpdateProfileData_updateProfile_location,
    _$GUpdateProfileData_updateProfile_location,
  ];
  @override
  final String wireName = 'GUpdateProfileData_updateProfile_location';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileData_updateProfile_location object, {
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
  GUpdateProfileData_updateProfile_location deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateProfileData_updateProfile_locationBuilder();

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

class _$GUpdateProfileData_updateProfile_avatarSerializer
    implements StructuredSerializer<GUpdateProfileData_updateProfile_avatar> {
  @override
  final Iterable<Type> types = const [
    GUpdateProfileData_updateProfile_avatar,
    _$GUpdateProfileData_updateProfile_avatar,
  ];
  @override
  final String wireName = 'GUpdateProfileData_updateProfile_avatar';

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    GUpdateProfileData_updateProfile_avatar object, {
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
  GUpdateProfileData_updateProfile_avatar deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GUpdateProfileData_updateProfile_avatarBuilder();

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

class _$GUpdateProfileData extends GUpdateProfileData {
  @override
  final String G__typename;
  @override
  final GUpdateProfileData_updateProfile updateProfile;

  factory _$GUpdateProfileData([
    void Function(GUpdateProfileDataBuilder)? updates,
  ]) => (GUpdateProfileDataBuilder()..update(updates))._build();

  _$GUpdateProfileData._({
    required this.G__typename,
    required this.updateProfile,
  }) : super._();
  @override
  GUpdateProfileData rebuild(
    void Function(GUpdateProfileDataBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileDataBuilder toBuilder() =>
      GUpdateProfileDataBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileData &&
        G__typename == other.G__typename &&
        updateProfile == other.updateProfile;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, G__typename.hashCode);
    _$hash = $jc(_$hash, updateProfile.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GUpdateProfileData')
          ..add('G__typename', G__typename)
          ..add('updateProfile', updateProfile))
        .toString();
  }
}

class GUpdateProfileDataBuilder
    implements Builder<GUpdateProfileData, GUpdateProfileDataBuilder> {
  _$GUpdateProfileData? _$v;

  String? _G__typename;
  String? get G__typename => _$this._G__typename;
  set G__typename(String? G__typename) => _$this._G__typename = G__typename;

  GUpdateProfileData_updateProfileBuilder? _updateProfile;
  GUpdateProfileData_updateProfileBuilder get updateProfile =>
      _$this._updateProfile ??= GUpdateProfileData_updateProfileBuilder();
  set updateProfile(GUpdateProfileData_updateProfileBuilder? updateProfile) =>
      _$this._updateProfile = updateProfile;

  GUpdateProfileDataBuilder() {
    GUpdateProfileData._initializeBuilder(this);
  }

  GUpdateProfileDataBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _G__typename = $v.G__typename;
      _updateProfile = $v.updateProfile.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GUpdateProfileData other) {
    _$v = other as _$GUpdateProfileData;
  }

  @override
  void update(void Function(GUpdateProfileDataBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData build() => _build();

  _$GUpdateProfileData _build() {
    _$GUpdateProfileData _$result;
    try {
      _$result =
          _$v ??
          _$GUpdateProfileData._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GUpdateProfileData',
              'G__typename',
            ),
            updateProfile: updateProfile.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'updateProfile';
        updateProfile.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'GUpdateProfileData',
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

class _$GUpdateProfileData_updateProfile
    extends GUpdateProfileData_updateProfile {
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
  final GUpdateProfileData_updateProfile_location? location;
  @override
  final GUpdateProfileData_updateProfile_avatar? avatar;

  factory _$GUpdateProfileData_updateProfile([
    void Function(GUpdateProfileData_updateProfileBuilder)? updates,
  ]) => (GUpdateProfileData_updateProfileBuilder()..update(updates))._build();

  _$GUpdateProfileData_updateProfile._({
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
  GUpdateProfileData_updateProfile rebuild(
    void Function(GUpdateProfileData_updateProfileBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileData_updateProfileBuilder toBuilder() =>
      GUpdateProfileData_updateProfileBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileData_updateProfile &&
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
    return (newBuiltValueToStringHelper(r'GUpdateProfileData_updateProfile')
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

class GUpdateProfileData_updateProfileBuilder
    implements
        Builder<
          GUpdateProfileData_updateProfile,
          GUpdateProfileData_updateProfileBuilder
        > {
  _$GUpdateProfileData_updateProfile? _$v;

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

  GUpdateProfileData_updateProfile_locationBuilder? _location;
  GUpdateProfileData_updateProfile_locationBuilder get location =>
      _$this._location ??= GUpdateProfileData_updateProfile_locationBuilder();
  set location(GUpdateProfileData_updateProfile_locationBuilder? location) =>
      _$this._location = location;

  GUpdateProfileData_updateProfile_avatarBuilder? _avatar;
  GUpdateProfileData_updateProfile_avatarBuilder get avatar =>
      _$this._avatar ??= GUpdateProfileData_updateProfile_avatarBuilder();
  set avatar(GUpdateProfileData_updateProfile_avatarBuilder? avatar) =>
      _$this._avatar = avatar;

  GUpdateProfileData_updateProfileBuilder() {
    GUpdateProfileData_updateProfile._initializeBuilder(this);
  }

  GUpdateProfileData_updateProfileBuilder get _$this {
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
  void replace(GUpdateProfileData_updateProfile other) {
    _$v = other as _$GUpdateProfileData_updateProfile;
  }

  @override
  void update(void Function(GUpdateProfileData_updateProfileBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData_updateProfile build() => _build();

  _$GUpdateProfileData_updateProfile _build() {
    _$GUpdateProfileData_updateProfile _$result;
    try {
      _$result =
          _$v ??
          _$GUpdateProfileData_updateProfile._(
            G__typename: BuiltValueNullFieldError.checkNotNull(
              G__typename,
              r'GUpdateProfileData_updateProfile',
              'G__typename',
            ),
            id: BuiltValueNullFieldError.checkNotNull(
              id,
              r'GUpdateProfileData_updateProfile',
              'id',
            ),
            email: BuiltValueNullFieldError.checkNotNull(
              email,
              r'GUpdateProfileData_updateProfile',
              'email',
            ),
            displayName: displayName,
            role: BuiltValueNullFieldError.checkNotNull(
              role,
              r'GUpdateProfileData_updateProfile',
              'role',
            ),
            description: description,
            isMailVerified: BuiltValueNullFieldError.checkNotNull(
              isMailVerified,
              r'GUpdateProfileData_updateProfile',
              'isMailVerified',
            ),
            phoneNumber: phoneNumber,
            reputationScore: BuiltValueNullFieldError.checkNotNull(
              reputationScore,
              r'GUpdateProfileData_updateProfile',
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
          r'GUpdateProfileData_updateProfile',
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

class _$GUpdateProfileData_updateProfile_location
    extends GUpdateProfileData_updateProfile_location {
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

  factory _$GUpdateProfileData_updateProfile_location([
    void Function(GUpdateProfileData_updateProfile_locationBuilder)? updates,
  ]) => (GUpdateProfileData_updateProfile_locationBuilder()..update(updates))
      ._build();

  _$GUpdateProfileData_updateProfile_location._({
    required this.G__typename,
    required this.id,
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.neighborhood,
  }) : super._();
  @override
  GUpdateProfileData_updateProfile_location rebuild(
    void Function(GUpdateProfileData_updateProfile_locationBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileData_updateProfile_locationBuilder toBuilder() =>
      GUpdateProfileData_updateProfile_locationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileData_updateProfile_location &&
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
            r'GUpdateProfileData_updateProfile_location',
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

class GUpdateProfileData_updateProfile_locationBuilder
    implements
        Builder<
          GUpdateProfileData_updateProfile_location,
          GUpdateProfileData_updateProfile_locationBuilder
        > {
  _$GUpdateProfileData_updateProfile_location? _$v;

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

  GUpdateProfileData_updateProfile_locationBuilder() {
    GUpdateProfileData_updateProfile_location._initializeBuilder(this);
  }

  GUpdateProfileData_updateProfile_locationBuilder get _$this {
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
  void replace(GUpdateProfileData_updateProfile_location other) {
    _$v = other as _$GUpdateProfileData_updateProfile_location;
  }

  @override
  void update(
    void Function(GUpdateProfileData_updateProfile_locationBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData_updateProfile_location build() => _build();

  _$GUpdateProfileData_updateProfile_location _build() {
    final _$result =
        _$v ??
        _$GUpdateProfileData_updateProfile_location._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GUpdateProfileData_updateProfile_location',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GUpdateProfileData_updateProfile_location',
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

class _$GUpdateProfileData_updateProfile_avatar
    extends GUpdateProfileData_updateProfile_avatar {
  @override
  final String G__typename;
  @override
  final String id;
  @override
  final String? url;
  @override
  final String fileType;

  factory _$GUpdateProfileData_updateProfile_avatar([
    void Function(GUpdateProfileData_updateProfile_avatarBuilder)? updates,
  ]) => (GUpdateProfileData_updateProfile_avatarBuilder()..update(updates))
      ._build();

  _$GUpdateProfileData_updateProfile_avatar._({
    required this.G__typename,
    required this.id,
    this.url,
    required this.fileType,
  }) : super._();
  @override
  GUpdateProfileData_updateProfile_avatar rebuild(
    void Function(GUpdateProfileData_updateProfile_avatarBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  GUpdateProfileData_updateProfile_avatarBuilder toBuilder() =>
      GUpdateProfileData_updateProfile_avatarBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GUpdateProfileData_updateProfile_avatar &&
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
            r'GUpdateProfileData_updateProfile_avatar',
          )
          ..add('G__typename', G__typename)
          ..add('id', id)
          ..add('url', url)
          ..add('fileType', fileType))
        .toString();
  }
}

class GUpdateProfileData_updateProfile_avatarBuilder
    implements
        Builder<
          GUpdateProfileData_updateProfile_avatar,
          GUpdateProfileData_updateProfile_avatarBuilder
        > {
  _$GUpdateProfileData_updateProfile_avatar? _$v;

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

  GUpdateProfileData_updateProfile_avatarBuilder() {
    GUpdateProfileData_updateProfile_avatar._initializeBuilder(this);
  }

  GUpdateProfileData_updateProfile_avatarBuilder get _$this {
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
  void replace(GUpdateProfileData_updateProfile_avatar other) {
    _$v = other as _$GUpdateProfileData_updateProfile_avatar;
  }

  @override
  void update(
    void Function(GUpdateProfileData_updateProfile_avatarBuilder)? updates,
  ) {
    if (updates != null) updates(this);
  }

  @override
  GUpdateProfileData_updateProfile_avatar build() => _build();

  _$GUpdateProfileData_updateProfile_avatar _build() {
    final _$result =
        _$v ??
        _$GUpdateProfileData_updateProfile_avatar._(
          G__typename: BuiltValueNullFieldError.checkNotNull(
            G__typename,
            r'GUpdateProfileData_updateProfile_avatar',
            'G__typename',
          ),
          id: BuiltValueNullFieldError.checkNotNull(
            id,
            r'GUpdateProfileData_updateProfile_avatar',
            'id',
          ),
          url: url,
          fileType: BuiltValueNullFieldError.checkNotNull(
            fileType,
            r'GUpdateProfileData_updateProfile_avatar',
            'fileType',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
