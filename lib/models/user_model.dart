class UserModel {
  final String id;
  final String username;
  final String avatarUrl;
  final bool isVerified;
  final bool isFollowing;

  const UserModel({
    required this.id,
    required this.username,
    required this.avatarUrl,
    this.isVerified = false,
    this.isFollowing = true,
  });

  UserModel copyWith({
    String? id,
    String? username,
    String? avatarUrl,
    bool? isVerified,
    bool? isFollowing,
  }) {
    return UserModel(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      isVerified: isVerified ?? this.isVerified,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'avatarUrl': avatarUrl,
        'isVerified': isVerified,
        'isFollowing': isFollowing,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        username: json['username'] as String,
        avatarUrl: json['avatarUrl'] as String,
        isVerified: json['isVerified'] as bool? ?? false,
        isFollowing: json['isFollowing'] as bool? ?? true,
      );
}
