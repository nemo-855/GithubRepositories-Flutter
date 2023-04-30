import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../domain/model/owner.dart';

part 'owner_response.freezed.dart';
part 'owner_response.g.dart';

@freezed
class OwnerResponse with _$OwnerResponse {
  @JsonSerializable(explicitToJson: true)

  const factory OwnerResponse({
    required String login,
    required String avatarUrl,
  }) = _OwnerResponse;

  factory OwnerResponse.fromJson(Map<String, Object?> json)
  => _$OwnerResponseFromJson(json);
}

extension ResponseConverter on OwnerResponse {
  Owner toOwner() {
    return Owner(name: login, avatarUrl: avatarUrl);
  }
}
