import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String id,
    required String name,
    required String email,
    required String role,
    required String accessToken,
    String? refreshToken,
  }) = _UserEntity;

  factory UserEntity.empty() => const UserEntity(
    id: '',
    name: '',
    email: '',
    role: 'rep',
    accessToken: '',
    refreshToken: null,
  );

  factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);
}
