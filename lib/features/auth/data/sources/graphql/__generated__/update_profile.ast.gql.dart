// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:gaspzero/features/auth/data/sources/graphql/__generated__/user_fields.ast.gql.dart'
    as _i2;
import 'package:gql/ast.dart' as _i1;

const UpdateProfile = _i1.OperationDefinitionNode(
  type: _i1.OperationType.mutation,
  name: _i1.NameNode(value: 'UpdateProfile'),
  variableDefinitions: [
    _i1.VariableDefinitionNode(
      variable: _i1.VariableNode(
        name: _i1.NameNode(value: 'updateProfileInput'),
      ),
      type: _i1.NamedTypeNode(
        name: _i1.NameNode(value: 'UpdateProfileInput'),
        isNonNull: true,
      ),
      defaultValue: _i1.DefaultValueNode(value: null),
      directives: [],
    ),
  ],
  directives: [],
  selectionSet: _i1.SelectionSetNode(
    selections: [
      _i1.FieldNode(
        name: _i1.NameNode(value: 'updateProfile'),
        alias: null,
        arguments: [
          _i1.ArgumentNode(
            name: _i1.NameNode(value: 'updateProfileInput'),
            value: _i1.VariableNode(
              name: _i1.NameNode(value: 'updateProfileInput'),
            ),
          ),
        ],
        directives: [],
        selectionSet: _i1.SelectionSetNode(
          selections: [
            _i1.FragmentSpreadNode(
              name: _i1.NameNode(value: 'UserFields'),
              directives: [],
            ),
          ],
        ),
      ),
    ],
  ),
);
const document = _i1.DocumentNode(definitions: [UpdateProfile, _i2.UserFields]);
