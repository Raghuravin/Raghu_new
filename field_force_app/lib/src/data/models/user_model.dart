import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required String name,
    required String email,
    required String role,
    required String accessToken,
    String? refreshToken,
  }) = _UserModel;

  const UserModel._();

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  factory UserModel.fromEntity(UserEntity entity) => UserModel(
    id: entity.id,
    name: entity.name,
    email: entity.email,
    role: entity.role,
    accessToken: entity.accessToken,
    refreshToken: entity.refreshToken,
  );

  UserEntity toEntity() => UserEntity(
    id: id,
    name: name,
    email: email,
    role: role,
    accessToken: accessToken,
    refreshToken: refreshToken,
  );
}
