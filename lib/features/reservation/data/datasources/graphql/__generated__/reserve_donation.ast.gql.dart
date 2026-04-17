// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gaspzero/features/reservation/data/datasources/graphql/__generated__/reservation_fields.ast.gql.dart'
    as _i2;
import 'package:gql/ast.dart' as _i1;

const ReserveDonation = _i1.OperationDefinitionNode(
  type: _i1.OperationType.mutation,
  name: _i1.NameNode(value: 'ReserveDonation'),
  variableDefinitions: [
    _i1.VariableDefinitionNode(
      variable: _i1.VariableNode(name: _i1.NameNode(value: 'donationId')),
      type: _i1.NamedTypeNode(name: _i1.NameNode(value: 'ID'), isNonNull: true),
      defaultValue: _i1.DefaultValueNode(value: null),
      directives: [],
    ),
  ],
  directives: [],
  selectionSet: _i1.SelectionSetNode(
    selections: [
      _i1.FieldNode(
        name: _i1.NameNode(value: 'reserveDonation'),
        alias: null,
        arguments: [
          _i1.ArgumentNode(
            name: _i1.NameNode(value: 'donationId'),
            value: _i1.VariableNode(name: _i1.NameNode(value: 'donationId')),
          ),
        ],
        directives: [],
        selectionSet: _i1.SelectionSetNode(
          selections: [
            _i1.FragmentSpreadNode(
              name: _i1.NameNode(value: 'ReservationFields'),
              directives: [],
            ),
          ],
        ),
      ),
    ],
  ),
);
const document = _i1.DocumentNode(
  definitions: [ReserveDonation, _i2.ReservationFields],
);
