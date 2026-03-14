import 'user_model.dart';

class StoryModel {
  final String id;
  final UserModel user;
  final bool isSeen;
  final bool isOwn;

  const StoryModel({
    required this.id,
    required this.user,
    this.isSeen = false,
    this.isOwn = false,
  });

  StoryModel copyWith({
    String? id,
    UserModel? user,
    bool? isSeen,
    bool? isOwn,
  }) {
    return StoryModel(
      id: id ?? this.id,
      user: user ?? this.user,
      isSeen: isSeen ?? this.isSeen,
      isOwn: isOwn ?? this.isOwn,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'isSeen': isSeen,
        'isOwn': isOwn,
      };

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
        id: json['id'] as String,
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        isSeen: json['isSeen'] as bool? ?? false,
        isOwn: json['isOwn'] as bool? ?? false,
      );
}
