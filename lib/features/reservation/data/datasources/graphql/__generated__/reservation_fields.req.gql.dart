// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:ferry_exec/ferry_exec.dart' as _i1;
import 'package:gaspzero/core/graphql/__generated__/serializers.gql.dart'
    as _i6;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reservation_fields.ast.gql.dart'
    as _i4;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reservation_fields.data.gql.dart'
    as _i2;
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reservation_fields.var.gql.dart'
    as _i3;
import 'package:gql/ast.dart' as _i5;

part 'reservation_fields.req.gql.g.dart';

abstract class GReservationFieldsReq
    implements
        Built<GReservationFieldsReq, GReservationFieldsReqBuilder>,
        _i1.FragmentRequest<_i2.GReservationFieldsData,
            _i3.GReservationFieldsVars> {
  GReservationFieldsReq._();

  factory GReservationFieldsReq(
          [void Function(GReservationFieldsReqBuilder b) updates]) =
      _$GReservationFieldsReq;

  static void _initializeBuilder(GReservationFieldsReqBuilder b) => b
    ..document = _i4.document
    ..fragmentName = 'ReservationFields';

  @override
  _i3.GReservationFieldsVars get vars;
  @override
  _i5.DocumentNode get document;
  @override
  String? get fragmentName;
  @override
  Map<String, dynamic> get idFields;
  @override
  _i2.GReservationFieldsData? parseData(Map<String, dynamic> json) =>
      _i2.GReservationFieldsData.fromJson(json);

  @override
  Map<String, dynamic> varsToJson() => vars.toJson();

  @override
  Map<String, dynamic> dataToJson(_i2.GReservationFieldsData data) =>
      data.toJson();

  static Serializer<GReservationFieldsReq> get serializer =>
      _$gReservationFieldsReqSerializer;

  Map<String, dynamic> toJson() => (_i6.serializers.serializeWith(
        GReservationFieldsReq.serializer,
        this,
      ) as Map<String, dynamic>);

  static GReservationFieldsReq? fromJson(Map<String, dynamic> json) =>
      _i6.serializers.deserializeWith(
        GReservationFieldsReq.serializer,
        json,
      );
}
