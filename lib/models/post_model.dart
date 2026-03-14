import 'user_model.dart';

class PostModel {
  final String id;
  final UserModel user;
  final List<String> imageUrls;
  final String caption;
  final int likesCount;
  final int commentsCount;
  final String timeAgo;
  final bool isLiked;
  final bool isSaved;
  final String? location;

  const PostModel({
    required this.id,
    required this.user,
    required this.imageUrls,
    required this.caption,
    required this.likesCount,
    required this.commentsCount,
    required this.timeAgo,
    this.isLiked = false,
    this.isSaved = false,
    this.location,
  });

  PostModel copyWith({
    String? id,
    UserModel? user,
    List<String>? imageUrls,
    String? caption,
    int? likesCount,
    int? commentsCount,
    String? timeAgo,
    bool? isLiked,
    bool? isSaved,
    String? location,
  }) {
    return PostModel(
      id: id ?? this.id,
      user: user ?? this.user,
      imageUrls: imageUrls ?? this.imageUrls,
      caption: caption ?? this.caption,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      timeAgo: timeAgo ?? this.timeAgo,
      isLiked: isLiked ?? this.isLiked,
      isSaved: isSaved ?? this.isSaved,
      location: location ?? this.location,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'user': user.toJson(),
        'imageUrls': imageUrls,
        'caption': caption,
        'likesCount': likesCount,
        'commentsCount': commentsCount,
        'timeAgo': timeAgo,
        'isLiked': isLiked,
        'isSaved': isSaved,
        'location': location,
      };

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        id: json['id'] as String,
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        imageUrls: List<String>.from(json['imageUrls'] as List),
        caption: json['caption'] as String,
        likesCount: json['likesCount'] as int,
        commentsCount: json['commentsCount'] as int,
        timeAgo: json['timeAgo'] as String,
        isLiked: json['isLiked'] as bool? ?? false,
        isSaved: json['isSaved'] as bool? ?? false,
        location: json['location'] as String?,
      );
}
